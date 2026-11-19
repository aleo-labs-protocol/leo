// Copyright (C) 2019-2026 Provable Inc.
// This file is part of the Leo library.

// The Leo library is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// The Leo library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with the Leo library. If not, see <https://www.gnu.org/licenses/>.

use snarkvm::{
    prelude::{ToBits, ToBitsRaw},
    synthesizer::program::{DeserializeVariant, SerializeVariant},
};

use crate::{ArrayType, Expression, Intrinsic, TypeKind, const_eval::Value};
use leo_errors::Formatted;
use leo_span::Span;

use super::{errors, *};

fn pop_value(values: &mut Vec<Value>) -> Result<Value, String> {
    values.pop().ok_or_else(|| "value expected during constant evaluation".to_string())
}

fn type_fail<T, E>(r: Result<T, E>) -> Result<T, String> {
    r.map_err(|_| "type failure".to_string())
}

fn snark<T>(r: Result<T, anyhow::Error>) -> Result<T, String> {
    r.map_err(|e| format!("{e}"))
}

pub fn evaluate_intrinsic(
    values: &mut Vec<Value>,
    intrinsic: Intrinsic,
    arguments: &[Expression],
    span: Span,
) -> Result<Option<Value>, Formatted> {
    evaluate_intrinsic_inner(values, intrinsic, arguments).map_err(|reason| errors::intrinsic_failure(reason, span))
}

fn evaluate_intrinsic_inner(
    values: &mut Vec<Value>,
    intrinsic: Intrinsic,
    _arguments: &[Expression],
) -> Result<Option<Value>, String> {
    use snarkvm::{
        prelude::LiteralType,
        synthesizer::program::{CommitVariant, ECDSAVerifyVariant, HashVariant},
    };

    let dohash = |values: &mut Vec<Value>, variant: HashVariant, typ: TypeKind| -> Result<Value, String> {
        let input = type_fail(pop_value(values)?.try_into())?;
        let value = snark(snarkvm::synthesizer::program::evaluate_hash(variant, &input, &snark(typ.to_snarkvm())?))?;
        Ok(value.into())
    };

    let docommit = |values: &mut Vec<Value>, variant: CommitVariant, typ: LiteralType| -> Result<Value, String> {
        let randomizer: Scalar = type_fail(pop_value(values)?.try_into())?;
        let input: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let value = snark(snarkvm::synthesizer::program::evaluate_commit(variant, &input, &randomizer, typ))?;
        Ok(value.into())
    };

    let doschnorr = |values: &mut Vec<Value>| -> Result<Value, String> {
        let message: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let address: Address = type_fail(pop_value(values)?.try_into())?;
        let signature: Signature = type_fail(pop_value(values)?.try_into())?;
        let is_valid =
            snark(snarkvm::synthesizer::program::evaluate_schnorr_verification(&signature, &address, &message))?;
        Ok(Boolean::new(is_valid).into())
    };

    let doecdsa = |values: &mut Vec<Value>, variant: ECDSAVerifyVariant| -> Result<Value, String> {
        let message: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let public_key: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let signature: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let is_valid = snark(snarkvm::synthesizer::program::evaluate_ecdsa_verification(
            variant,
            &signature,
            &public_key,
            &message,
        ))?;
        Ok(Boolean::new(is_valid).into())
    };

    let doserialize = |values: &mut Vec<Value>, variant: SerializeVariant| -> Result<Value, String> {
        let input: SvmValue = type_fail(pop_value(values)?.try_into())?;
        let num_bits = match variant {
            SerializeVariant::ToBits => input.to_bits_le().len(),
            SerializeVariant::ToBitsRaw => input.to_bits_raw_le().len(),
        };
        let Ok(num_bits) = u32::try_from(num_bits) else {
            return Err("cannot serialize value with more than 2^32 bits".into());
        };
        let array_type = snark(ArrayType::bit_array(num_bits).to_snarkvm())?;
        let value = snark(snarkvm::synthesizer::program::evaluate_serialize(variant, &input, &array_type))?;
        Ok(value.into())
    };

    let dodeserialize =
        |values: &mut Vec<Value>, variant: DeserializeVariant, type_: TypeKind| -> Result<Value, String> {
            let value: SvmValue = type_fail(pop_value(values)?.try_into())?;
            let bits = match value {
                SvmValue::Plaintext(plaintext) => snark(plaintext.as_bit_array())?,
                _ => return Err("expected array for deserialization".into()),
            };
            let get_struct_fail = |_: &SvmIdentifier| anyhow::bail!("structs are not supported");
            let get_external_struct_fail = |_: &SvmLocator| anyhow::bail!("structs are not supported");
            let value = snark(snarkvm::synthesizer::program::evaluate_deserialize(
                variant,
                &bits,
                &snark(type_.to_snarkvm())?,
                &get_struct_fail,
                &get_external_struct_fail,
            ))?;
            Ok(value.into())
        };

    let value = match intrinsic {
        Intrinsic::ChaChaRand(_) => {
            // Random values cannot be evaluated at compile time.
            return Ok(None);
        }
        Intrinsic::Commit(commit_variant, type_) => docommit(values, commit_variant, type_)?,
        Intrinsic::Hash(hash_variant, type_) => dohash(values, hash_variant, type_)?,
        Intrinsic::ECDSAVerify(ecdsa_variant) => doecdsa(values, ecdsa_variant)?,
        Intrinsic::SignatureVerify => doschnorr(values)?,
        Intrinsic::Serialize(variant) => doserialize(values, variant)?,
        Intrinsic::Deserialize(variant, type_) => dodeserialize(values, variant, type_)?,
        Intrinsic::GroupToXCoordinate => {
            let g: Group = type_fail(pop_value(values)?.try_into())?;
            g.to_x_coordinate().into()
        }
        Intrinsic::GroupToYCoordinate => {
            let g: Group = type_fail(pop_value(values)?.try_into())?;
            g.to_y_coordinate().into()
        }
        Intrinsic::MappingGet
        | Intrinsic::MappingSet
        | Intrinsic::MappingGetOrUse
        | Intrinsic::MappingRemove
        | Intrinsic::MappingContains => {
            // Mapping operations cannot be evaluated at compile time.
            return Ok(None);
        }
        Intrinsic::GroupGen => Value::generator(),
        // AleoGenerator must NOT be constant-folded. The compile-time value (Edwards generator G')
        // differs from the runtime value (account generator H = hash_to_curve). The bytecode must
        // emit the symbolic `aleo::GENERATOR` opcode for the VM to resolve at runtime.
        Intrinsic::AleoGenerator => {
            return Ok(None);
        }
        Intrinsic::OptionalUnwrap | Intrinsic::OptionalUnwrapOr => {
            return Ok(None);
        }
        Intrinsic::AleoGeneratorPowers | Intrinsic::SnarkVerify | Intrinsic::SnarkVerifyBatch => {
            // Cannot evaluate at compile time.
            return Ok(None);
        }
        Intrinsic::VectorPush
        | Intrinsic::VectorLen
        | Intrinsic::VectorClear
        | Intrinsic::VectorPop
        | Intrinsic::VectorGet
        | Intrinsic::VectorSet
        | Intrinsic::VectorSwapRemove
        | Intrinsic::SelfAddress
        | Intrinsic::SelfCaller
        | Intrinsic::SelfChecksum
        | Intrinsic::SelfEdition
        | Intrinsic::SelfId
        | Intrinsic::SelfProgramOwner
        | Intrinsic::SelfSigner
        | Intrinsic::BlockHeight
        | Intrinsic::BlockTimestamp
        | Intrinsic::NetworkId => {
            return Ok(None);
        }
        Intrinsic::FinalRun => panic!("await must be handled elsewhere"),
        Intrinsic::ProgramChecksum
        | Intrinsic::ProgramEdition
        | Intrinsic::ProgramOwner
        | Intrinsic::FunctionChecksum => {
            return Ok(None);
        }
        // Dynamic dispatch cannot be evaluated at compile time.
        Intrinsic::DynamicCall | Intrinsic::DynamicContains | Intrinsic::DynamicGet | Intrinsic::DynamicGetOrUse => {
            return Ok(None);
        }
    };

    Ok(Some(value))
}

#[cfg(test)]
mod tests {
    use super::*;
    use snarkvm::{
        console::algorithms::{ECDSASignature, Keccak256},
        prelude::{PrivateKey, TestRng, ToFields},
        utilities::ToBytes,
    };
    use std::str::FromStr;

    #[test]
    fn schnorr_constant_evaluation_preserves_argument_order() {
        let mut rng = TestRng::fixed(63);
        let private_key = PrivateKey::<CurrentNetwork>::new(&mut rng).expect("valid test private key");
        let address = Address::try_from(&private_key).expect("valid test address");
        let field_message = SvmValue::from(SvmPlaintext::from(SvmLiteral::Field(Field::from_u8(5))));
        let signature_message =
            Signature::sign(&private_key, &field_message.to_fields().expect("valid test message"), &mut rng)
                .expect("valid test signature");
        let signature_message = SvmValue::from(SvmPlaintext::from(SvmLiteral::Signature(Box::new(signature_message))));

        for message in [signature_message, field_message] {
            let signature = Signature::sign(&private_key, &message.to_fields().expect("valid test message"), &mut rng)
                .expect("valid test signature");
            let expected = snarkvm::synthesizer::program::evaluate_schnorr_verification(&signature, &address, &message)
                .expect("valid test operands");
            assert!(expected);
            let mut values = vec![signature.into(), address.into(), message.clone().into()];
            assert_eq!(
                evaluate_intrinsic_inner(&mut values, Intrinsic::SignatureVerify, &[]),
                Ok(Some(Boolean::new(expected).into())),
            );
            assert!(values.is_empty());

            let other_key = PrivateKey::<CurrentNetwork>::new(&mut rng).expect("valid test private key");
            let other_address = Address::try_from(&other_key).expect("valid test address");
            let mut values = vec![signature.into(), other_address.into(), message.into()];
            assert_eq!(
                evaluate_intrinsic_inner(&mut values, Intrinsic::SignatureVerify, &[]),
                Ok(Some(Boolean::new(false).into())),
            );
        }
    }

    #[test]
    fn ecdsa_constant_evaluation_preserves_argument_order() {
        use snarkvm::synthesizer::program::ECDSAVerifyVariant;

        let signature = ECDSASignature::from_str(concat!(
            "ab5373ec68978e102a9084d6d07aa1e328174d12337e0a028ec3b0c63abdb89e7",
            "a906d9de841006143de25cab83b380618972c4803bf978c5b02d4e863465b8a1b",
        ))
        .expect("valid test signature");
        let message: SvmValue = Value::from(5u8).try_into().expect("valid test message");
        let public_key = signature
            .recover_public_key(&Keccak256::default(), &message.to_bits_raw_le())
            .expect("valid test public key");
        let signature =
            Value::make_array(signature.to_bytes_le().expect("valid signature bytes").into_iter().map(Value::from));
        let compressed_key = public_key.to_sec1_point(true);
        let address = ECDSASignature::ethereum_address_from_public_key(&public_key).expect("valid test address");

        for (variant, key) in [
            (ECDSAVerifyVariant::HashKeccak256Raw, compressed_key.as_bytes()),
            (ECDSAVerifyVariant::HashKeccak256Eth, address.as_slice()),
        ] {
            let public_key = Value::make_array(key.iter().copied().map(Value::from));
            for (message, expected) in [(5u8, true), (6u8, false)] {
                let mut values = vec![signature.clone(), public_key.clone(), message.into()];
                assert_eq!(
                    evaluate_intrinsic_inner(&mut values, Intrinsic::ECDSAVerify(variant.clone()), &[]),
                    Ok(Some(Boolean::new(expected).into())),
                );
                assert!(values.is_empty());
            }
        }
    }
}
