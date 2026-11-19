// --- library: math_lib --- //

// --- Next Module: orders.leo --- //

export fn check(x: u32) -> u32 {
    return x + 1u32;
}

// --- Next Module: outer.leo --- //

export fn evaluate(x: u32) -> u32 {
    return math_lib::orders::check(x) + orders::check(x);
}

// --- Next Module: outer/orders.leo --- //

export fn check(x: u32) -> u32 {
    return x + 10u32;
}

// --- Next Program --- //

program caller.aleo {
    fn main(x: u32) -> u32 {
        return outer::evaluate(x);
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: outer.leo --- //

export fn evaluate(x: u32) -> u32 {
    return math_lib::outer::evaluate(x) + orders::check(x);
}

// --- Next Module: outer/orders.leo --- //

export fn check(x: u32) -> u32 {
    return x + 100u32;
}
