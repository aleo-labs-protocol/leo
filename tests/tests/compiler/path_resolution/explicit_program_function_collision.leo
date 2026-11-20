export fn check(x: u32) -> u32 {
    return x + 2u32;
}

program provider.aleo {
    fn entry(x: u32) -> u32 {
        return x;
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: orders.leo --- //

export fn check(x: u32) -> u32 {
    return x + 1u32;
}

// --- Next Module: outer.leo --- //

export fn check(x: u32) -> u32 {
    return x + 200u32;
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
    return provider.aleo::orders::check(x) + provider.aleo::check(x);
}
