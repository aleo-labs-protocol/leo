// A whole array assigned from a variable can also have an element assigned.
// The generated array accesses need types before the second SSA pass.

struct Data {
    values: [u32; 2],
}

program test.aleo {
    fn struct_field(x: u32) -> u32 {
        let data = Data { values: [x, x] };
        let replacement = [x, 1u32];
        data.values = replacement;
        data.values[1u32] = 7u32;
        return data.values[0u32] + data.values[1u32];
    }

    fn nested_row(x: u32) -> u32 {
        let rows: [[u32; 2]; 2] = [[x, x], [x, x]];
        let replacement = [x, 1u32];
        rows[0u32] = replacement;
        rows[0u32][1u32] = 7u32;
        return rows[0u32][0u32] + rows[0u32][1u32];
    }

    @noupgrade
    constructor() {}
}
