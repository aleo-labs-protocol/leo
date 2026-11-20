/*
seed = 123456789
start_height = 20

[case]
program = "constant_ecdsa.aleo"
function = "main"
input = ["[43u8, 204u8, 92u8, 231u8, 0u8, 0u8, 0u8, 1u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 15u8, 66u8, 64u8, 0u8, 0u8, 39u8, 18u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 160u8, 184u8, 106u8, 51u8, 230u8, 248u8, 236u8, 97u8, 204u8, 98u8, 241u8, 176u8, 203u8, 42u8, 214u8, 223u8, 227u8, 193u8, 14u8, 139u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 116u8, 45u8, 53u8, 204u8, 110u8, 76u8, 110u8, 66u8, 226u8, 166u8, 225u8, 182u8, 214u8, 225u8, 157u8, 59u8, 177u8, 77u8, 61u8, 26u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 160u8, 184u8, 105u8, 145u8, 198u8, 33u8, 139u8, 54u8, 193u8, 209u8, 157u8, 74u8, 46u8, 158u8, 176u8, 206u8, 54u8, 6u8, 235u8, 72u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 195u8, 80u8, 191u8, 171u8, 9u8, 64u8, 213u8, 162u8, 65u8, 12u8, 0u8, 126u8, 6u8, 200u8, 177u8, 187u8, 36u8, 227u8, 67u8, 145u8, 221u8, 197u8, 41u8, 142u8, 24u8, 132u8, 13u8, 244u8, 56u8, 232u8, 224u8, 91u8, 154u8, 200u8, 0u8, 0u8, 0u8, 0u8]"]

[case]
program = "constant_ecdsa.aleo"
function = "check_digest"
input = ["[94u8, 76u8, 213u8, 97u8, 97u8, 101u8, 51u8, 51u8, 21u8, 86u8, 52u8, 204u8, 133u8, 101u8, 203u8, 175u8, 248u8, 37u8, 79u8, 157u8, 236u8, 41u8, 189u8, 155u8, 31u8, 248u8, 200u8, 100u8, 170u8, 197u8, 105u8, 252u8]"]
*/

const SIGNATURE: [u8; 65] = [
    171u8, 83u8, 115u8, 236u8, 104u8, 151u8, 142u8, 16u8, 42u8, 144u8, 132u8, 214u8,
    208u8, 122u8, 161u8, 227u8, 40u8, 23u8, 77u8, 18u8, 51u8, 126u8, 10u8, 2u8,
    142u8, 195u8, 176u8, 198u8, 58u8, 189u8, 184u8, 158u8, 122u8, 144u8, 109u8, 157u8,
    232u8, 65u8, 0u8, 97u8, 67u8, 222u8, 37u8, 202u8, 184u8, 59u8, 56u8, 6u8,
    24u8, 151u8, 44u8, 72u8, 3u8, 191u8, 151u8, 140u8, 91u8, 2u8, 212u8, 232u8,
    99u8, 70u8, 91u8, 138u8, 27u8,
];

const ADDRESS: [u8; 20] = [
    27u8, 227u8, 26u8, 148u8, 54u8, 26u8, 57u8, 27u8, 186u8, 251u8, 42u8, 76u8,
    205u8, 112u8, 79u8, 87u8, 220u8, 4u8, 212u8, 187u8,
];

const MESSAGE: [u8; 240] = [
    43u8, 204u8, 92u8, 231u8, 0u8, 0u8, 0u8, 1u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 15u8, 66u8, 64u8, 0u8, 0u8, 39u8, 18u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 160u8, 184u8, 106u8, 51u8,
    230u8, 248u8, 236u8, 97u8, 204u8, 98u8, 241u8, 176u8, 203u8, 42u8, 214u8, 223u8,
    227u8, 193u8, 14u8, 139u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 116u8, 45u8, 53u8, 204u8, 110u8, 76u8, 110u8, 66u8,
    226u8, 166u8, 225u8, 182u8, 214u8, 225u8, 157u8, 59u8, 177u8, 77u8, 61u8, 26u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    160u8, 184u8, 105u8, 145u8, 198u8, 33u8, 139u8, 54u8, 193u8, 209u8, 157u8, 74u8,
    46u8, 158u8, 176u8, 206u8, 54u8, 6u8, 235u8, 72u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 34u8, 34u8, 34u8, 34u8,
    34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8, 34u8,
    34u8, 34u8, 34u8, 34u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8,
    0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 195u8, 80u8,
    191u8, 171u8, 9u8, 64u8, 213u8, 162u8, 65u8, 12u8, 0u8, 126u8, 6u8, 200u8,
    177u8, 187u8, 36u8, 227u8, 67u8, 145u8, 221u8, 197u8, 41u8, 142u8, 24u8, 132u8,
    13u8, 244u8, 56u8, 232u8, 224u8, 91u8, 154u8, 200u8, 0u8, 0u8, 0u8, 0u8,
];

// These are the compressed signer key and the Keccak-256 digest for MESSAGE.
const PUBLIC_KEY: [u8; 33] = [
    2u8, 187u8, 80u8, 226u8, 216u8, 154u8, 78u8, 215u8, 6u8, 99u8, 208u8, 128u8,
    101u8, 159u8, 224u8, 173u8, 75u8, 155u8, 195u8, 224u8, 108u8, 23u8, 162u8, 39u8,
    67u8, 57u8, 102u8, 203u8, 89u8, 206u8, 238u8, 2u8, 13u8,
];

const DIGEST: [u8; 32] = [
    94u8, 76u8, 213u8, 97u8, 97u8, 101u8, 51u8, 51u8, 21u8, 86u8, 52u8, 204u8,
    133u8, 101u8, 203u8, 175u8, 248u8, 37u8, 79u8, 157u8, 236u8, 41u8, 189u8, 155u8,
    31u8, 248u8, 200u8, 100u8, 170u8, 197u8, 105u8, 252u8,
];

program constant_ecdsa.aleo {
    fn main(message: [u8; 240]) -> Final {
        return final {
            let folded = ECDSA::verify_keccak256_eth(SIGNATURE, ADDRESS, MESSAGE);
            assert(folded);
            assert_eq(folded, ECDSA::verify_keccak256_eth(SIGNATURE, ADDRESS, message));
            assert(!ECDSA::verify_keccak256_eth(SIGNATURE, [0u8; 20], MESSAGE));
        };
    }

    fn check_digest(digest: [u8; 32]) -> Final {
        return final {
            let folded = ECDSA::verify_digest(SIGNATURE, PUBLIC_KEY, DIGEST);
            assert(folded);
            assert_eq(folded, ECDSA::verify_digest(SIGNATURE, PUBLIC_KEY, digest));
            assert(!ECDSA::verify_digest(SIGNATURE, PUBLIC_KEY, [0u8; 32]));
        };
    }

    @noupgrade
    constructor() {}
}
