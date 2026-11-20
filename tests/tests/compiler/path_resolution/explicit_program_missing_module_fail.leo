program provider.aleo {
    fn entry(x: u32) -> u32 {
        return x;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: outer/orders.leo --- //

export fn check(x: u32) -> u32 {
    return x + 100u32;
}

// --- Next Program --- //

import provider.aleo;

program caller.aleo {
    fn main(x: u32) -> u32 {
        return outer::evaluate(x);
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: outer.leo --- //

export fn evaluate(x: u32) -> u32 {
    return provider.aleo::orders::check(x);
}
