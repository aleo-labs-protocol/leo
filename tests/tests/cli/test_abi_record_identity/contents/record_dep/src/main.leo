program record_dep.aleo : types::ModuleRecords {
    record Token {
        owner: address,
        amount: u32,
    }

    record ModuleRecord {
        owner: address,
        amount: u32,
    }

    fn echo_module_record(value: ModuleRecord) -> ModuleRecord {
        return value;
    }

    fn echo_token(token: Token) -> Token {
        return token;
    }

    @noupgrade
    constructor() {}
}
