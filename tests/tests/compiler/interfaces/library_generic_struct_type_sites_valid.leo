// Regression: imported interface types are reconstructed before conformance checking.
// Function signatures, record fields, mapping values, and storage use the same
// concrete specialization.

// --- library: shapes --- //

export struct Array::[N: u32] {
    values: [u8; N],
}

export struct Slot::[N: u32] { amount: u32 }
export interface Read { storage entry: Slot::[2u32]; }

// --- Next Program --- //

// --- library: inventory --- //

export struct Boxed::[N: u32] { data: [u8; N] }
export struct Outer::[N: u32] { item: Boxed::[N] }
export interface Items { fn read() -> Outer::[3u32]; }

// --- Next Program --- //

// --- library: generic_shapes --- //

const WIDTH: u32 = 4u32;

export struct Slot::[N: u32] {
    amount: u32,
}

export interface Storer {
    record Token {
        owner: address,
        slot: Slot::[8u32],
        padding: [u8; WIDTH],
        ..
    }

    mapping slots: address => Slot::[8u32];
    storage current: Slot::[8u32];

    fn store(input: Slot::[WIDTH + WIDTH]) -> Slot::[WIDTH * 2u32];
}

// Earlier compilers emitted the template name for this layout and skipped its empty field.
export struct Legacy::[N: u32] {
    amount: u32,
    empty: [[u8; N]; 0u32],
}

// These specializations occur only in interface prototypes.
// The consumer does not call this member, so its specialization is ABI-only.
export interface Unused {
    fn unused() -> Legacy::[23u32];
    fn unused_array() -> shapes::Array::[29u32];
}

export interface RootOnly {
    fn root() -> Legacy::[13u32];
}

// --- Next Module: nested.leo --- //

export interface ModuleOnly {
    fn nested() -> shapes::Array::[5u32];
}

// --- Next Program --- //

// Request the external Items ABI as well as its bytecode types.
interface NestedItems: inventory::Items {}

program consumer.aleo: generic_shapes::Storer {
    record Token {
        owner: address,
        slot: generic_shapes::Slot::[8u32],
        padding: [u8; 4u32],
    }

    mapping slots: address => generic_shapes::Slot::[8u32];
    storage current: generic_shapes::Slot::[8u32];

    fn store(input: generic_shapes::Slot::[8u32]) -> generic_shapes::Slot::[8u32] {
        return input;
    }

    fn read_item(target: identifier) -> u8 {
        return inventory::Items@(target)::read().item.data[2u32];
    }

    fn read_root(target: identifier) -> u32 {
        return generic_shapes::RootOnly@(target)::root().amount;
    }

    fn read_nested(target: identifier) -> u8 {
        return generic_shapes::nested::ModuleOnly@(target)::nested().values[0u32];
    }

    fn check_current(target: identifier) -> Final {
        return final { check_storage(target); };
    }

    @noupgrade
    constructor() {}
}

export final fn check_storage(target: identifier) {
    assert_eq((generic_shapes::Storer@(target)::current).unwrap().amount, 8u32);
    assert_eq(shapes::Read@(target)::entry, shapes::Read@(target)::entry);
}
