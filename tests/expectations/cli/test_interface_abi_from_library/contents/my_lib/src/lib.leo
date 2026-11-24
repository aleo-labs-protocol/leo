const WIDTH: u32 = 2u32;

export struct Tag::[N: u32] { amount: u8 }

export struct Hidden { amount: u32 }

export struct Wrapper { hidden: Hidden }

export struct Bytes::[N: u32] {
    data: [u8; N],
    empty: [[u8; N]; 0u32],
    wrappers: [Wrapper; 0u32],
    tags: [Tag::[3u32]; 0u32],
}

export struct Packet::[N: u32] { bytes: Bytes::[N] }

export interface Greeter {
    fn greet(who: address) -> u64;
    fn encode(input: Tag::[WIDTH]) -> Tag::[3u32];
    fn packet(input: Packet::[WIDTH + 1u32]) -> u8;
}

export fn sum::[N: u32](items: [u8; N]) -> u8 {
    let total: u8 = 0u8;
    for i: u32 in 0u32..N {
        total += items[i];
    }
    return total;
}
