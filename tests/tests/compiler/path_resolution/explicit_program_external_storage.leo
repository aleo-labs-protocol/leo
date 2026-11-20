program provider.aleo {
    storage count: u64;

    fn initialize() -> Final {
        return final {
            count = 7u64;
        };
    }

    @noupgrade
    constructor() {}
}

// --- Next Program --- //

import provider.aleo;

program caller.aleo {
    fn main() -> Final {
        return final {
            assert_eq(outer::read(), 7u64);
        };
    }

    @noupgrade
    constructor() {}
}

// --- Next Module: outer.leo --- //

export final fn read() -> u64 {
    return provider.aleo::count.unwrap();
}
