program my_program.aleo : my_lib::Greeter {
    fn greet(who: address) -> u64 {
        return 1u64;
    }

    fn packet(input: my_lib::Packet::[3u32]) -> u8 {
        return my_lib::sum::[3u32](input.bytes.data);
    }

    fn encode(input: my_lib::Tag::[2u32]) -> my_lib::Tag::[3u32] {
        return my_lib::Tag::[3u32] { amount: input.amount };
    }

    @noupgrade
    constructor() {}
}
