program caller.aleo {
    fn main(x: u32) -> u32 {
        return outer::evaluate(x).amount;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: orders.leo --- //

export const OFFSET: u32 = 1u32;

export struct Receipt {
    amount: u32,
}

export fn check(x: u32) -> u32 {
    return x + OFFSET;
}

// --- Next Module: outer/orders.leo --- //

export const OFFSET: u32 = 100u32;

export struct Receipt {
    amount: u32,
}

export fn check(x: u32) -> u32 {
    return x + OFFSET;
}

// --- Next Module: outer.leo --- //

export fn evaluate(x: u32) -> caller.aleo::orders::Receipt {
    let receipt: caller.aleo::orders::Receipt = caller.aleo::orders::Receipt {
        amount: caller.aleo::orders::check(x) + caller.aleo::orders::OFFSET,
    };
    return receipt;
}
