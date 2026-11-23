program provider.aleo {
    fn entry(x: u32) -> u32 {
        return x;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: orders.leo --- //

export const OFFSET: u32 = 1u32;

export struct Receipt {
    amount: u32,
}

// --- Next Module: outer/orders.leo --- //

export const OFFSET: u32 = 100u32;

export struct Receipt {
    amount: u32,
}

// --- Next Program --- //

import provider.aleo;

program caller.aleo {
    fn main(x: u32) -> u32 {
        return outer::evaluate(x).amount;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: outer.leo --- //

export fn evaluate(x: u32) -> provider.aleo::orders::Receipt {
    let receipt: provider.aleo::orders::Receipt = provider.aleo::orders::Receipt {
        amount: x + provider.aleo::orders::OFFSET,
    };
    return receipt;
}
