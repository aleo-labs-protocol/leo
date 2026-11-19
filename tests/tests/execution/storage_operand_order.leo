/*
seed = 987654321
start_height = 20

[case]
program = "operand_order.aleo"
function = "check_order"
input = ["0u32"]

[case]
program = "operand_order.aleo"
function = "check_option_order"
input = []

[case]
program = "operand_order.aleo"
function = "check_unit_order"
input = []

[case]
program = "operand_order.aleo"
function = "check_dynamic_singleton"
input = []

[case]
program = "operand_order.aleo"
function = "check_dynamic_vector"
input = []
*/

export struct Payout {
    recipient: u32,
    amount: u64,
}

export interface Ledger {
    storage ticket: u64;
    storage payouts: [Payout];
}

program operand_order.aleo: Ledger {
    storage ticket: u64;
    storage payouts: [Payout];
    storage target_calls: u32;
    storage network_calls: u32;
    mapping credits: u32 => u64;

    fn check_order(index: u32) -> Final {
        return final {
            payouts.clear();
            payouts.push(Payout { recipient: 1u32, amount: 10u64 });
            payouts.push(Payout { recipient: 2u32, amount: 20u64 });
            credits.set(payouts.get(index).unwrap().recipient, payouts.swap_remove(index).amount);
            assert_eq(credits.get(1u32), 10u64);
            assert(!credits.contains(2u32));
        };
    }

    fn check_option_order() -> Final {
        return final {
            ticket = 5u64;
            assert_eq(update_ticket(), ticket.unwrap());
            ticket = 5u64;
            assert_eq(ticket.unwrap(), update_ticket() - 2u64);
        };
    }

    fn check_dynamic_singleton() -> Final {
        return final {
            ticket = 7u64;
            target_calls = 0u32;
            network_calls = 0u32;
            let value = Ledger@(select_target(), select_network())::ticket;
            assert_eq(value.unwrap(), 7u64);
            assert_eq(target_calls.unwrap(), 1u32);
            assert_eq(network_calls.unwrap(), 1u32);
        };
    }

    fn check_unit_order() -> Final {
        return final {
            ticket = 5u64;
            assert_eq(unit_update_ticket(), unit_check_ticket(ticket.unwrap()));
            assert_eq(ticket.unwrap(), 7u64);
            ticket = 5u64;
            assert(unit_update_ticket() == unit_check_ticket(ticket.unwrap()));
        };
    }

    fn check_dynamic_vector() -> Final {
        return final {
            payouts.clear();
            payouts.push(Payout { recipient: 2u32, amount: 20u64 });
            target_calls = 0u32;
            network_calls = 0u32;
            let payout = Ledger@(select_target(), select_network())::payouts.get(0u32);
            assert_eq(payout.unwrap().recipient, 2u32);
            assert_eq(target_calls.unwrap(), 1u32);
            assert_eq(network_calls.unwrap(), 1u32);
        };
    }

    final fn update_ticket() -> u64 {
        ticket = 7u64;
        return 7u64;
    }

    final fn unit_update_ticket() {
        ticket = 7u64;
    }

    final fn unit_check_ticket(value: u64) {
        assert_eq(value, 7u64);
    }

    final fn select_target() -> field {
        target_calls = target_calls.unwrap() + 1u32;
        return target_calls.unwrap() == 1u32 ? 9063389945604293180140082786415field : 0field;
    }

    final fn select_network() -> identifier {
        network_calls = network_calls.unwrap() + 1u32;
        return 'aleo';
    }

    @noupgrade
    constructor() {}
}
