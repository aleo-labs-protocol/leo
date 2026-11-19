/*
seed = 123456789
start_height = 20

[case]
program = "context_parent.aleo"
function = "check_identity"
input = ["1u32"]

[case]
program = "context_parent.aleo"
function = "check_metadata"
input = []
*/

// --- library: context_lib --- //

export fn addr() -> address {
    return std::ctx::addr();
}

export fn nested_id() -> address {
    return std::ctx::id();
}

export fn id() -> address {
    return nested_id();
}

// --- Next Program --- //

export fn no_args() -> address {
    return context_lib::addr();
}

export fn single_use(value: u32) -> (address, u32) {
    return (context_lib::id(), value);
}

export fn caller_value(value: address) -> address {
    return value;
}

export fn caller_and_signer() -> (address, address) {
    return (std::ctx::caller(), std::ctx::signer());
}

export fn empty_args(value: [u32; 0]) -> address {
    return std::ctx::id();
}

@no_inline
export fn retained(value: u32) -> (address, u32) {
    return (std::ctx::addr(), value);
}

fn optional_arg(value: u32?) -> address {
    assert(value.unwrap() > 0u32);
    return std::ctx::id();
}

export fn optional_wrapper(value: u32) -> address {
    return optional_arg(value);
}

export final fn metadata() -> ([u8; 32], u16, address, address) {
    return (std::ctx::checksum(), std::ctx::edition(), std::ctx::program_owner(), context_lib::id());
}

program context_dep.aleo {
    fn anchor(value: u32) -> u32 {
        return value;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: inner.leo --- //

export fn module_addr() -> address {
    return std::ctx::addr();
}

// --- Next Program --- //

import context_dep.aleo;

export fn nested(value: u32) -> (address, address, u32) {
    return (context_lib::addr(), context_dep.aleo::no_args(), value);
}

program context_mid.aleo {
    fn check_call(expected_caller: address, expected_signer: address) {
        let (caller, signer) = context_dep.aleo::caller_and_signer();
        assert_eq(caller, expected_caller);
        assert_eq(signer, expected_signer);
        assert_neq(caller, signer);
    }

    @noupgrade
    constructor() {}
}

// --- Next Program --- //

import context_dep.aleo;
import context_mid.aleo;

program context_parent.aleo {
    fn check_identity(value: u32) {
        assert_eq(context_dep.aleo::no_args(), context_dep.aleo);
        let (single, single_value) = context_dep.aleo::single_use(value);
        assert_eq(single, context_dep.aleo);
        assert_eq(single_value, value);
        assert_eq(context_dep.aleo::caller_value(std::ctx::addr()), context_parent.aleo);
        assert_eq(context_dep.aleo::empty_args([0u32; 0]), context_dep.aleo);
        assert_eq(context_dep.aleo::empty_args([0u32; 0]), context_dep.aleo);
        let (first, first_value) = context_dep.aleo::retained(value);
        let (second, second_value) = context_dep.aleo::retained(value + 1u32);
        assert_eq(first, context_dep.aleo);
        assert_eq(second, context_dep.aleo);
        assert_eq(first_value, value);
        assert_eq(second_value, value + 1u32);
        assert_eq(context_dep.aleo::optional_wrapper(value), context_dep.aleo);
        assert_eq(context_dep.aleo::inner::module_addr(), context_dep.aleo);
        let (mid, dep, nested_value) = context_mid.aleo::nested(value);
        assert_eq(mid, context_mid.aleo);
        assert_eq(dep, context_dep.aleo);
        assert_eq(nested_value, value);
        assert_eq(context_lib::addr(), context_parent.aleo);
        assert_eq(context_lib::id(), context_parent.aleo);
        assert_eq(std::ctx::addr(), context_parent.aleo);
        assert_eq(std::ctx::id(), context_parent.aleo);
        context_mid.aleo::check_call(context_parent.aleo, std::ctx::signer());
    }

    fn check_metadata() -> Final {
        return final {
            let (checksum, edition, owner, id) = context_dep.aleo::metadata();
            assert_eq(checksum, std::prog::checksum::[context_dep.aleo]());
            assert_eq(edition, std::prog::edition::[context_dep.aleo]());
            assert_eq(owner, std::prog::program_owner::[context_dep.aleo]());
            assert_eq(id, context_dep.aleo);
            assert_eq(std::ctx::checksum(), std::prog::checksum::[context_parent.aleo]());
            assert_eq(std::ctx::edition(), std::prog::edition::[context_parent.aleo]());
            assert_eq(std::ctx::program_owner(), std::prog::program_owner::[context_parent.aleo]());
        };
    }

    @noupgrade
    constructor() {}
}
