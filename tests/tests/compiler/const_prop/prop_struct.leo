export struct S {
    x: u8,
    y: u8,
}

struct Nested {
    inner: S,
}

program test.aleo {
    fn main() -> u8 {
        const s: S = S { x: 1u8, y: 2u8 };
        return s.x;
    }

    fn projections(x: u8) -> (bool, bool) {
        const s: S = S { x: 1u8, y: 2u8 };
        const nested: Nested = Nested { inner: s };
        if [s, s][1u32] == s {
            assert_eq(x, 3u8);
        }
        return (nested.inner != s, nested.inner != S { x: 1u8, y: 3u8 });
    }

    @noupgrade
    constructor() {}
}
