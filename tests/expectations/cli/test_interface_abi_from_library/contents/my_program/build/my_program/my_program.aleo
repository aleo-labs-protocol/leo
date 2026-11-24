program my_program.aleo;

struct Bytes__FrRQui86N3b:
    data as [u8; 3u32];

struct Packet__6UJa9lioecI:
    bytes as Bytes__FrRQui86N3b;

struct Tag__FprkXI3s1ZN:
    amount as u8;

struct Tag__3ZEPyZe9LaE:
    amount as u8;

struct Tag__5DdftQQkmaw:
    amount as u8;

function greet:
    input r0 as address.private;
    output 1u64 as u64.private;

function packet:
    input r0 as Packet__6UJa9lioecI.private;
    add r0.bytes.data[0u32] r0.bytes.data[1u32] into r1;
    add r1 r0.bytes.data[2u32] into r2;
    output r2 as u8.private;

function encode:
    input r0 as Tag__FprkXI3s1ZN.private;
    cast r0.amount into r1 as Tag__3ZEPyZe9LaE;
    output r1 as Tag__3ZEPyZe9LaE.private;

constructor:
    assert.eq edition 0u16;
