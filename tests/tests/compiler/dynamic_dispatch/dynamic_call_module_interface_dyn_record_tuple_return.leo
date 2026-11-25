// --- library: types_lib --- //

// --- Next Module: algorithms/nested.leo --- //

export struct Token {
    amount: u32,
}

// --- Next Program --- //

// --- library: ops_lib --- //

// --- Next Module: sibling.leo --- //

export struct Token {
    amount: u64,
}

// --- Next Module: algorithms/nested.leo --- //

export struct Receipt {
    accepted: bool,
}

export interface Processor {
    record Token;

    fn process(
        token: Token,
        local: Receipt,
        sibling: ops_lib::sibling::Token,
        external: types_lib::algorithms::nested::Token,
    ) -> (Token, Receipt, ops_lib::sibling::Token, types_lib::algorithms::nested::Token, u64);
}

// --- Next Program --- //

program foo.aleo {
    fn main(
        target: identifier,
        token: dyn record,
        local: ops_lib::algorithms::nested::Receipt,
        sibling: ops_lib::sibling::Token,
        external: types_lib::algorithms::nested::Token,
    ) -> (
        dyn record,
        ops_lib::algorithms::nested::Receipt,
        ops_lib::sibling::Token,
        types_lib::algorithms::nested::Token,
        u64,
    ) {
        return ops_lib::algorithms::nested::Processor@(target)::process(token, local, sibling, external);
    }

    @noupgrade
    constructor() {}
}
