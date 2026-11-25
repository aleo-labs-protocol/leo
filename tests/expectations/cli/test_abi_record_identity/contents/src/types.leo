export struct Token {
    amount: u32,
}

export struct PrototypeToken {
    amount: u32,
}

export interface ModuleKinds {
    fn echo_local(value: Token) -> Token;
}

export interface ModuleRecords {
    record ModuleRecord {
        owner: address,
        amount: u32,
        empty: [u8; 0u32],
        ..
    }

    fn echo_module_record(value: ModuleRecord) -> ModuleRecord;
}
