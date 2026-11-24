// Regression: a different specialization is rejected in function signatures, record
// fields, mapping values, and storage.

// --- library: generic_shapes --- //

const LENGTH: u32 = 8u32;

export struct Slot::[N: u32] {
    amount: u32,
}

export interface Storer {
    record Token {
        owner: address,
        slot: Slot::[8u32],
        ..
    }

    mapping slots: address => Slot::[8u32];
    storage current: Slot::[8u32];

    fn take_array(x: [u32; LENGTH]) -> u32;
    fn store(input: Slot::[8u32]) -> Slot::[8u32];
}

// --- Next Program --- //

program consumer.aleo: generic_shapes::Storer {
    record Token {
        owner: address,
        slot: generic_shapes::Slot::[16u32],
    }

    mapping slots: address => generic_shapes::Slot::[16u32];
    storage current: generic_shapes::Slot::[16u32];

    fn store(input: generic_shapes::Slot::[16u32]) -> generic_shapes::Slot::[16u32] {
        return input;
    }

    fn take_array(x: [u32; 9u32]) -> u32 {
        return x[0u32];
    }

    @noupgrade
    constructor() {}
}
