// --- library: hidden --- //

struct Hidden {
    x: u32,
}

export fn make(x: u32) -> Hidden {
    return Hidden { x };
}

export fn consume(item: Hidden) -> u32 {
    return item.x;
}

// --- Next Program --- //

fn noop() {}

program test.aleo {
    fn inferred_return(value: u32) -> u32 {
        let result = hidden::make(value);
        return result.x;
    }

    fn inferred_unit_tuple(value: u32) -> u32 {
        let result = (noop(), value + 1u32);
        return result.1;
    }

    fn inferred_record_field(item: dyn record) -> u32 {
        return hidden::consume(item.payload);
    }

    fn optional_record_field(item: dyn record) -> u64 {
        let result: u64? = item.payload;
        return result.unwrap_or(0u64);
    }

    @noupgrade
    constructor() {}
}
