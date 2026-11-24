/*
execution_networks = ["mainnet", "testnet", "canary"]

[case]
program = "example.aleo"
function = "read_network"
input = []
*/

program example.aleo {
    fn dummy(x: u32) -> u32 {
        return x;
    }

    view fn read_network() -> u16 {
        return std::ctx::network_id();
    }

    @noupgrade
    constructor() {}
}
