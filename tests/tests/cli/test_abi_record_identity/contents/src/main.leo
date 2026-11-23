import bytecode_dep.aleo;
import interface_dep.aleo;
import record_dep.aleo;

export interface CompositeKinds {
    record Token;

    fn echo_record(token: Token) -> Token;
    fn echo_struct(value: types::Token) -> types::Token;
}

export interface PrototypeOnly {
    record PrototypeToken;

    fn echo_prototype(token: PrototypeToken) -> PrototypeToken;
    fn echo_struct_prototype(value: types::PrototypeToken) -> types::PrototypeToken;
}

program foo.aleo : CompositeKinds + interface_dep.aleo::ExternalRecords {
    record Token {
        owner: address,
        amount: u32,
    }

    fn echo_record(token: Token) -> Token {
        return token;
    }

    fn echo_struct(value: types::Token) -> types::Token {
        return value;
    }

    fn echo_external(token: record_dep.aleo::Token) -> record_dep.aleo::Token {
        return token;
    }

    fn echo_sibling(value: sibling::Token) -> sibling::Token {
        return value;
    }

    fn echo_leo_module(value: record_dep.aleo::types::Token) -> record_dep.aleo::types::Token {
        return value;
    }

    fn echo_other_program(value: interface_dep.aleo::types::Token) -> interface_dep.aleo::types::Token {
        return value;
    }

    fn echo_library_root(value: shapes_lib::Token) -> shapes_lib::Token {
        return value;
    }

    fn echo_library_module(value: shapes_lib::types::Token) -> shapes_lib::types::Token {
        return value;
    }

    fn echo_bytecode(value: bytecode_dep.aleo::Token) -> bytecode_dep.aleo::Token {
        return value;
    }

    @noupgrade
    constructor() {}
}
