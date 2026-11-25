program test_network.aleo {
    @test
    fn mainnet_id() -> Final {
        return final { assert_eq(std::ctx::network_id(), 0u16); };
    }

    @test
    fn testnet_id() -> Final {
        return final { assert_eq(std::ctx::network_id(), 1u16); };
    }

    @noupgrade
    constructor() {}
}
