/*
[case]
program = "test.aleo"
function = "current_owner"
input = []

[case]
program = "test.aleo"
function = "current_owner"
input = []
seed_mapping = ["owner__", "false", "aleo1qnr4dkkvkgfqph0vzc3y6z2eu975wnpz2925ntjccd5cfqxtyu8s7pyjh9"]

[case]
program = "test.aleo"
function = "entry_count"
input = []
seed_mapping = ["entries__len__", "false", "3u32"]

[case]
program = "test.aleo"
function = "entry_at"
input = ["1u32"]
seed_mapping = ["entries__len__", "false", "3u32"]
seed_mapping = ["entries__", "0u32", "10u64"]
seed_mapping = ["entries__", "1u32", "20u64"]
seed_mapping = ["entries__", "2u32", "30u64"]

[case]
program = "test.aleo"
function = "entry_at_oob"
input = ["5u32"]
seed_mapping = ["entries__len__", "false", "3u32"]

[case]
program = "test.aleo"
function = "entry_at_or"
input = ["1u32", "77u64"]
seed_mapping = ["entries__len__", "false", "3u32"]
seed_mapping = ["entries__", "0u32", "10u64"]
seed_mapping = ["entries__", "1u32", "20u64"]
seed_mapping = ["entries__", "2u32", "30u64"]

[case]
program = "test.aleo"
function = "entry_at_or"
input = ["5u32", "77u64"]
seed_mapping = ["entries__len__", "false", "3u32"]

[case]
program = "test.aleo"
function = "choose_entries"
input = ["true", "0u32", "1u32"]
seed_mapping = ["entries__len__", "false", "1u32"]
seed_mapping = ["entries__", "0u32", "21u64"]

[case]
program = "test.aleo"
function = "choose_entries"
input = ["false", "0u32", "1u32"]
seed_mapping = ["entries__len__", "false", "1u32"]
seed_mapping = ["entries__", "0u32", "21u64"]

[case]
program = "test.aleo"
function = "nested_entry"
input = []
seed_mapping = ["details__", "false", "{ amounts: [9u64, 12u64] }"]
[case]
program = "test.aleo"
function = "eager_fallback"
input = ["0u32", "0u64"]
seed_mapping = ["entries__len__", "false", "1u32"]
seed_mapping = ["entries__", "0u32", "21u64"]

[case]
program = "test.aleo"
function = "eager_fallback"
input = ["0u32", "2u64"]
*/

// Views that read storage variables and vectors. Storage and vector reads
// lower to mapping reads with internal naming conventions
// (`<name>__` for the data, `<name>__len__` for vector lengths), so the
// `seed_mapping` entries below address the lowered mapping names directly.
export struct Details { amounts: [u64; 2] }

program test.aleo {
    storage details: Details;
    storage owner: address;
    storage entries: [u64];

    fn dummy(x: u32) -> u32 { return x; }

    // Returns the stored owner, or a sentinel zero-address if unset.
    view fn current_owner() -> address {
        return owner.unwrap_or(aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc);
    }

    view fn entry_count() -> u32 {
        return entries.len();
    }

    // Bounds-checked read: returns the entry at `idx`, or 0 if out-of-bounds.
    view fn entry_at(idx: u32) -> u64 {
        return entries.get(idx).unwrap_or(0u64);
    }

    // Same as entry_at but the index is intentionally past the end.
    // Demonstrates the optional-default fallback path.
    view fn entry_at_oob(idx: u32) -> u64 {
        return entries.get(idx).unwrap_or(99u64);
    }

    view fn entry_at_or(idx: u32, fallback: u64) -> u64 {
        return entries.get(idx).unwrap_or(fallback);
    }

    view fn choose_entries(first: bool, a: u32, b: u32) -> [u64; 3] {
        let left: u64? = entries.get(a);
        let right: u64? = entries.get(b);
        let chosen: u64? = first ? left : right;
        return [left.unwrap_or(3u64), right.unwrap_or(5u64), chosen.unwrap_or(7u64)];
    }

    view fn nested_entry() -> u64 {
        return details.unwrap().amounts[1u32];
    }

    view fn eager_fallback(idx: u32, divisor: u64) -> u64 {
        return entries.get(idx).unwrap_or(10u64 / divisor);
    }

    @noupgrade
    constructor() {}
}
