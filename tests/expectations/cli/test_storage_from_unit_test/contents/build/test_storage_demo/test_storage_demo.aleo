import storage_demo.aleo;
program test_storage_demo.aleo;

struct Optional__ATAkdHctJwx:
    is_some as boolean;
    val as boolean;

struct Optional__DmN5CQ9hzeK:
    is_some as boolean;
    val as u64;

struct Optional__3aph2JMPtnA:
    is_some as boolean;
    val as u8;

struct Optional__GfbJUku6XoG:
    is_some as boolean;
    val as i64;

struct Optional__7o6su2Uhzht:
    is_some as boolean;
    val as field;

struct Optional__BnktEVOqVZ2:
    is_some as boolean;
    val as [u32; 4u32];

struct Optional__6wU7KHJhSvv:
    is_some as boolean;
    val as address;

struct Optional__9SsWRr2WG5s:
    is_some as boolean;
    val as group;

struct Optional__7G49nMxvEkY:
    is_some as boolean;
    val as storage_demo.aleo/Point;

struct Optional__JzunLORyB8U:
    is_some as boolean;
    val as u32;

function unset_singletons_default:
    async unset_singletons_default into r0;
    output r0 as test_storage_demo.aleo/unset_singletons_default.future;

finalize unset_singletons_default:
    contains storage_demo.aleo/flag__[false] into r0;
    get.or_use storage_demo.aleo/flag__[false] false into r1;
    cast true r1 into r2 as Optional__ATAkdHctJwx;
    cast false false into r3 as Optional__ATAkdHctJwx;
    ternary r0 r2 r3 into r4;
    ternary r4.is_some r4.val false into r5;
    is.eq r5 false into r6;
    assert.eq r6 true;
    contains storage_demo.aleo/counter__[false] into r7;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r8;
    cast true r8 into r9 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r10 as Optional__DmN5CQ9hzeK;
    ternary r7 r9 r10 into r11;
    ternary r11.is_some r11.val 0u64 into r12;
    is.eq r12 0u64 into r13;
    assert.eq r13 true;
    contains storage_demo.aleo/tiny__[false] into r14;
    get.or_use storage_demo.aleo/tiny__[false] 0u8 into r15;
    cast true r15 into r16 as Optional__3aph2JMPtnA;
    cast false 0u8 into r17 as Optional__3aph2JMPtnA;
    ternary r14 r16 r17 into r18;
    ternary r18.is_some r18.val 0u8 into r19;
    is.eq r19 0u8 into r20;
    assert.eq r20 true;
    contains storage_demo.aleo/signed__[false] into r21;
    get.or_use storage_demo.aleo/signed__[false] 0i64 into r22;
    cast true r22 into r23 as Optional__GfbJUku6XoG;
    cast false 0i64 into r24 as Optional__GfbJUku6XoG;
    ternary r21 r23 r24 into r25;
    ternary r25.is_some r25.val 0i64 into r26;
    is.eq r26 0i64 into r27;
    assert.eq r27 true;
    contains storage_demo.aleo/marker__[false] into r28;
    get.or_use storage_demo.aleo/marker__[false] 0field into r29;
    cast true r29 into r30 as Optional__7o6su2Uhzht;
    cast false 0field into r31 as Optional__7o6su2Uhzht;
    ternary r28 r30 r31 into r32;
    ternary r32.is_some r32.val 0field into r33;
    is.eq r33 0field into r34;
    assert.eq r34 true;
    contains storage_demo.aleo/quad__[false] into r35;
    cast 0u32 0u32 0u32 0u32 into r36 as [u32; 4u32];
    get.or_use storage_demo.aleo/quad__[false] r36 into r37;
    cast true r37 into r38 as Optional__BnktEVOqVZ2;
    cast false r36 into r39 as Optional__BnktEVOqVZ2;
    ternary r35 r38 r39 into r40;
    cast 0u32 0u32 0u32 0u32 into r41 as [u32; 4u32];
    ternary r40.is_some r40.val r41 into r42;
    is.eq r42 r41 into r43;
    assert.eq r43 true;

function set_and_read_flag:
    call storage_demo.aleo/set_flag true into r0;
    async set_and_read_flag r0 into r1;
    output r1 as test_storage_demo.aleo/set_and_read_flag.future;

finalize set_and_read_flag:
    input r0 as storage_demo.aleo/set_flag.future;
    await r0;
    contains storage_demo.aleo/flag__[false] into r1;
    get.or_use storage_demo.aleo/flag__[false] false into r2;
    cast true r2 into r3 as Optional__ATAkdHctJwx;
    cast false false into r4 as Optional__ATAkdHctJwx;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val true into r6;
    assert.eq r6 true;

function set_and_read_counter:
    call storage_demo.aleo/set_counter 42u64 into r0;
    async set_and_read_counter r0 into r1;
    output r1 as test_storage_demo.aleo/set_and_read_counter.future;

finalize set_and_read_counter:
    input r0 as storage_demo.aleo/set_counter.future;
    await r0;
    contains storage_demo.aleo/counter__[false] into r1;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r2;
    cast true r2 into r3 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r4 as Optional__DmN5CQ9hzeK;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val 42u64 into r6;
    assert.eq r6 true;
    contains storage_demo.aleo/counter__[false] into r7;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r8;
    cast true r8 into r9 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r10 as Optional__DmN5CQ9hzeK;
    ternary r7 r9 r10 into r11;
    ternary r11.is_some r11.val 0u64 into r12;
    is.eq r12 42u64 into r13;
    assert.eq r13 true;

function bump_counter_from_unset:
    call storage_demo.aleo/bump_counter into r0;
    async bump_counter_from_unset r0 into r1;
    output r1 as test_storage_demo.aleo/bump_counter_from_unset.future;

finalize bump_counter_from_unset:
    input r0 as storage_demo.aleo/bump_counter.future;
    await r0;
    contains storage_demo.aleo/counter__[false] into r1;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r2;
    cast true r2 into r3 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r4 as Optional__DmN5CQ9hzeK;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val 1u64 into r6;
    assert.eq r6 true;

function bump_counter_twice:
    call storage_demo.aleo/bump_counter into r0;
    call storage_demo.aleo/bump_counter into r1;
    async bump_counter_twice r0 r1 into r2;
    output r2 as test_storage_demo.aleo/bump_counter_twice.future;

finalize bump_counter_twice:
    input r0 as storage_demo.aleo/bump_counter.future;
    input r1 as storage_demo.aleo/bump_counter.future;
    await r0;
    await r1;
    contains storage_demo.aleo/counter__[false] into r2;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r3;
    cast true r3 into r4 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r5 as Optional__DmN5CQ9hzeK;
    ternary r2 r4 r5 into r6;
    assert.eq r6.is_some true;
    is.eq r6.val 2u64 into r7;
    assert.eq r7 true;

function clear_counter_resets_default:
    call storage_demo.aleo/set_counter 99u64 into r0;
    call storage_demo.aleo/clear_counter into r1;
    async clear_counter_resets_default r0 r1 into r2;
    output r2 as test_storage_demo.aleo/clear_counter_resets_default.future;

finalize clear_counter_resets_default:
    input r0 as storage_demo.aleo/set_counter.future;
    input r1 as storage_demo.aleo/clear_counter.future;
    await r0;
    await r1;
    contains storage_demo.aleo/counter__[false] into r2;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r3;
    cast true r3 into r4 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r5 as Optional__DmN5CQ9hzeK;
    ternary r2 r4 r5 into r6;
    ternary r6.is_some r6.val 0u64 into r7;
    is.eq r7 0u64 into r8;
    assert.eq r8 true;

function set_and_read_tiny:
    call storage_demo.aleo/set_tiny 255u8 into r0;
    async set_and_read_tiny r0 into r1;
    output r1 as test_storage_demo.aleo/set_and_read_tiny.future;

finalize set_and_read_tiny:
    input r0 as storage_demo.aleo/set_tiny.future;
    await r0;
    contains storage_demo.aleo/tiny__[false] into r1;
    get.or_use storage_demo.aleo/tiny__[false] 0u8 into r2;
    cast true r2 into r3 as Optional__3aph2JMPtnA;
    cast false 0u8 into r4 as Optional__3aph2JMPtnA;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val 255u8 into r6;
    assert.eq r6 true;

function set_and_read_signed:
    call storage_demo.aleo/set_signed -1234i64 into r0;
    async set_and_read_signed r0 into r1;
    output r1 as test_storage_demo.aleo/set_and_read_signed.future;

finalize set_and_read_signed:
    input r0 as storage_demo.aleo/set_signed.future;
    await r0;
    contains storage_demo.aleo/signed__[false] into r1;
    get.or_use storage_demo.aleo/signed__[false] 0i64 into r2;
    cast true r2 into r3 as Optional__GfbJUku6XoG;
    cast false 0i64 into r4 as Optional__GfbJUku6XoG;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val -1234i64 into r6;
    assert.eq r6 true;

function set_and_read_tag:
    call storage_demo.aleo/set_tag aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r0;
    async set_and_read_tag r0 aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px into r1;
    output r1 as test_storage_demo.aleo/set_and_read_tag.future;

finalize set_and_read_tag:
    input r0 as storage_demo.aleo/set_tag.future;
    input r1 as address.public;
    await r0;
    contains storage_demo.aleo/tag__[false] into r2;
    get.or_use storage_demo.aleo/tag__[false] aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r3;
    cast true r3 into r4 as Optional__6wU7KHJhSvv;
    cast false aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc into r5 as Optional__6wU7KHJhSvv;
    ternary r2 r4 r5 into r6;
    assert.eq r6.is_some true;
    is.eq r6.val r1 into r7;
    assert.eq r7 true;

function set_and_read_marker:
    call storage_demo.aleo/set_marker 7field into r0;
    async set_and_read_marker r0 into r1;
    output r1 as test_storage_demo.aleo/set_and_read_marker.future;

finalize set_and_read_marker:
    input r0 as storage_demo.aleo/set_marker.future;
    await r0;
    contains storage_demo.aleo/marker__[false] into r1;
    get.or_use storage_demo.aleo/marker__[false] 0field into r2;
    cast true r2 into r3 as Optional__7o6su2Uhzht;
    cast false 0field into r4 as Optional__7o6su2Uhzht;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val 7field into r6;
    assert.eq r6 true;

function set_and_read_pivot:
    call storage_demo.aleo/set_pivot 2group into r0;
    async set_and_read_pivot r0 2group into r1;
    output r1 as test_storage_demo.aleo/set_and_read_pivot.future;

finalize set_and_read_pivot:
    input r0 as storage_demo.aleo/set_pivot.future;
    input r1 as group.public;
    await r0;
    contains storage_demo.aleo/pivot__[false] into r2;
    get.or_use storage_demo.aleo/pivot__[false] 0group into r3;
    cast true r3 into r4 as Optional__9SsWRr2WG5s;
    cast false 0group into r5 as Optional__9SsWRr2WG5s;
    ternary r2 r4 r5 into r6;
    assert.eq r6.is_some true;
    is.eq r6.val r1 into r7;
    assert.eq r7 true;

function set_and_read_point:
    cast -5i64 9i64 into r0 as storage_demo.aleo/Point;
    call storage_demo.aleo/set_point r0 into r1;
    async set_and_read_point r1 into r2;
    output r2 as test_storage_demo.aleo/set_and_read_point.future;

finalize set_and_read_point:
    input r0 as storage_demo.aleo/set_point.future;
    await r0;
    contains storage_demo.aleo/point__[false] into r1;
    cast 0i64 0i64 into r2 as storage_demo.aleo/Point;
    get.or_use storage_demo.aleo/point__[false] r2 into r3;
    cast true r3 into r4 as Optional__7G49nMxvEkY;
    cast 0i64 0i64 into r5 as storage_demo.aleo/Point;
    cast false r5 into r6 as Optional__7G49nMxvEkY;
    ternary r1 r4 r6 into r7;
    assert.eq r7.is_some true;
    is.eq r7.val.x -5i64 into r8;
    assert.eq r8 true;
    is.eq r7.val.y 9i64 into r9;
    assert.eq r9 true;

function set_and_read_quad:
    cast 1u32 2u32 3u32 4u32 into r0 as [u32; 4u32];
    call storage_demo.aleo/set_quad r0 into r1;
    async set_and_read_quad r1 into r2;
    output r2 as test_storage_demo.aleo/set_and_read_quad.future;

finalize set_and_read_quad:
    input r0 as storage_demo.aleo/set_quad.future;
    await r0;
    contains storage_demo.aleo/quad__[false] into r1;
    cast 0u32 0u32 0u32 0u32 into r2 as [u32; 4u32];
    get.or_use storage_demo.aleo/quad__[false] r2 into r3;
    cast true r3 into r4 as Optional__BnktEVOqVZ2;
    cast false r2 into r5 as Optional__BnktEVOqVZ2;
    ternary r1 r4 r5 into r6;
    assert.eq r6.is_some true;
    is.eq r6.val[0u32] 1u32 into r7;
    assert.eq r7 true;
    is.eq r6.val[1u32] 2u32 into r8;
    assert.eq r8 true;
    is.eq r6.val[2u32] 3u32 into r9;
    assert.eq r9 true;
    is.eq r6.val[3u32] 4u32 into r10;
    assert.eq r10 true;

function vector_starts_empty:
    async vector_starts_empty into r0;
    output r0 as test_storage_demo.aleo/vector_starts_empty.future;

finalize vector_starts_empty:
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r0;
    is.eq r0 0u32 into r1;
    assert.eq r1 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r2;
    lt 0u32 r2 into r3;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r4;
    cast true r4 into r5 as Optional__JzunLORyB8U;
    cast false 0u32 into r6 as Optional__JzunLORyB8U;
    ternary r3 r5 r6 into r7;
    ternary r7.is_some r7.val 0u32 into r8;
    is.eq r8 0u32 into r9;
    assert.eq r9 true;

function push_then_len_and_get:
    call storage_demo.aleo/push_history 10u32 into r0;
    call storage_demo.aleo/push_history 20u32 into r1;
    call storage_demo.aleo/push_history 30u32 into r2;
    async push_then_len_and_get r0 r1 r2 into r3;
    output r3 as test_storage_demo.aleo/push_then_len_and_get.future;

finalize push_then_len_and_get:
    input r0 as storage_demo.aleo/push_history.future;
    input r1 as storage_demo.aleo/push_history.future;
    input r2 as storage_demo.aleo/push_history.future;
    await r0;
    await r1;
    await r2;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r3;
    is.eq r3 3u32 into r4;
    assert.eq r4 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r5;
    lt 0u32 r5 into r6;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r7;
    cast true r7 into r8 as Optional__JzunLORyB8U;
    cast false 0u32 into r9 as Optional__JzunLORyB8U;
    ternary r6 r8 r9 into r10;
    assert.eq r10.is_some true;
    is.eq r10.val 10u32 into r11;
    assert.eq r11 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r12;
    lt 1u32 r12 into r13;
    get.or_use storage_demo.aleo/history__[1u32] 0u32 into r14;
    cast true r14 into r15 as Optional__JzunLORyB8U;
    cast false 0u32 into r16 as Optional__JzunLORyB8U;
    ternary r13 r15 r16 into r17;
    assert.eq r17.is_some true;
    is.eq r17.val 20u32 into r18;
    assert.eq r18 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r19;
    lt 2u32 r19 into r20;
    get.or_use storage_demo.aleo/history__[2u32] 0u32 into r21;
    cast true r21 into r22 as Optional__JzunLORyB8U;
    cast false 0u32 into r23 as Optional__JzunLORyB8U;
    ternary r20 r22 r23 into r24;
    assert.eq r24.is_some true;
    is.eq r24.val 30u32 into r25;
    assert.eq r25 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r26;
    lt 3u32 r26 into r27;
    get.or_use storage_demo.aleo/history__[3u32] 0u32 into r28;
    cast true r28 into r29 as Optional__JzunLORyB8U;
    cast false 0u32 into r30 as Optional__JzunLORyB8U;
    ternary r27 r29 r30 into r31;
    ternary r31.is_some r31.val 0u32 into r32;
    is.eq r32 0u32 into r33;
    assert.eq r33 true;

function pop_drops_last_element:
    call storage_demo.aleo/push_history 7u32 into r0;
    call storage_demo.aleo/push_history 8u32 into r1;
    call storage_demo.aleo/pop_history into r2;
    async pop_drops_last_element r0 r1 r2 into r3;
    output r3 as test_storage_demo.aleo/pop_drops_last_element.future;

finalize pop_drops_last_element:
    input r0 as storage_demo.aleo/push_history.future;
    input r1 as storage_demo.aleo/push_history.future;
    input r2 as storage_demo.aleo/pop_history.future;
    await r0;
    await r1;
    await r2;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r3;
    is.eq r3 1u32 into r4;
    assert.eq r4 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r5;
    lt 0u32 r5 into r6;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r7;
    cast true r7 into r8 as Optional__JzunLORyB8U;
    cast false 0u32 into r9 as Optional__JzunLORyB8U;
    ternary r6 r8 r9 into r10;
    assert.eq r10.is_some true;
    is.eq r10.val 7u32 into r11;
    assert.eq r11 true;

function set_replaces_slot:
    call storage_demo.aleo/push_history 100u32 into r0;
    call storage_demo.aleo/push_history 200u32 into r1;
    call storage_demo.aleo/set_history 1u32 999u32 into r2;
    async set_replaces_slot r0 r1 r2 into r3;
    output r3 as test_storage_demo.aleo/set_replaces_slot.future;

finalize set_replaces_slot:
    input r0 as storage_demo.aleo/push_history.future;
    input r1 as storage_demo.aleo/push_history.future;
    input r2 as storage_demo.aleo/set_history.future;
    await r0;
    await r1;
    await r2;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r3;
    is.eq r3 2u32 into r4;
    assert.eq r4 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r5;
    lt 0u32 r5 into r6;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r7;
    cast true r7 into r8 as Optional__JzunLORyB8U;
    cast false 0u32 into r9 as Optional__JzunLORyB8U;
    ternary r6 r8 r9 into r10;
    assert.eq r10.is_some true;
    is.eq r10.val 100u32 into r11;
    assert.eq r11 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r12;
    lt 1u32 r12 into r13;
    get.or_use storage_demo.aleo/history__[1u32] 0u32 into r14;
    cast true r14 into r15 as Optional__JzunLORyB8U;
    cast false 0u32 into r16 as Optional__JzunLORyB8U;
    ternary r13 r15 r16 into r17;
    assert.eq r17.is_some true;
    is.eq r17.val 999u32 into r18;
    assert.eq r18 true;

function swap_remove_pulls_last:
    call storage_demo.aleo/push_history 1u32 into r0;
    call storage_demo.aleo/push_history 2u32 into r1;
    call storage_demo.aleo/push_history 3u32 into r2;
    call storage_demo.aleo/push_history 4u32 into r3;
    call storage_demo.aleo/swap_remove_history 1u32 into r4;
    async swap_remove_pulls_last r0 r1 r2 r3 r4 into r5;
    output r5 as test_storage_demo.aleo/swap_remove_pulls_last.future;

finalize swap_remove_pulls_last:
    input r0 as storage_demo.aleo/push_history.future;
    input r1 as storage_demo.aleo/push_history.future;
    input r2 as storage_demo.aleo/push_history.future;
    input r3 as storage_demo.aleo/push_history.future;
    input r4 as storage_demo.aleo/swap_remove_history.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r5;
    is.eq r5 3u32 into r6;
    assert.eq r6 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r7;
    lt 0u32 r7 into r8;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r9;
    cast true r9 into r10 as Optional__JzunLORyB8U;
    cast false 0u32 into r11 as Optional__JzunLORyB8U;
    ternary r8 r10 r11 into r12;
    assert.eq r12.is_some true;
    is.eq r12.val 1u32 into r13;
    assert.eq r13 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r14;
    lt 1u32 r14 into r15;
    get.or_use storage_demo.aleo/history__[1u32] 0u32 into r16;
    cast true r16 into r17 as Optional__JzunLORyB8U;
    cast false 0u32 into r18 as Optional__JzunLORyB8U;
    ternary r15 r17 r18 into r19;
    assert.eq r19.is_some true;
    is.eq r19.val 4u32 into r20;
    assert.eq r20 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r21;
    lt 2u32 r21 into r22;
    get.or_use storage_demo.aleo/history__[2u32] 0u32 into r23;
    cast true r23 into r24 as Optional__JzunLORyB8U;
    cast false 0u32 into r25 as Optional__JzunLORyB8U;
    ternary r22 r24 r25 into r26;
    assert.eq r26.is_some true;
    is.eq r26.val 3u32 into r27;
    assert.eq r27 true;

function clear_resets_length:
    call storage_demo.aleo/push_history 1u32 into r0;
    call storage_demo.aleo/push_history 2u32 into r1;
    call storage_demo.aleo/clear_history into r2;
    async clear_resets_length r0 r1 r2 into r3;
    output r3 as test_storage_demo.aleo/clear_resets_length.future;

finalize clear_resets_length:
    input r0 as storage_demo.aleo/push_history.future;
    input r1 as storage_demo.aleo/push_history.future;
    input r2 as storage_demo.aleo/clear_history.future;
    await r0;
    await r1;
    await r2;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r3;
    is.eq r3 0u32 into r4;
    assert.eq r4 true;
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r5;
    lt 0u32 r5 into r6;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r7;
    cast true r7 into r8 as Optional__JzunLORyB8U;
    cast false 0u32 into r9 as Optional__JzunLORyB8U;
    ternary r6 r8 r9 into r10;
    ternary r10.is_some r10.val 0u32 into r11;
    is.eq r11 0u32 into r12;
    assert.eq r12 true;

function unwrap_unset_singleton_halts:
    async unwrap_unset_singleton_halts into r0;
    output r0 as test_storage_demo.aleo/unwrap_unset_singleton_halts.future;

finalize unwrap_unset_singleton_halts:
    contains storage_demo.aleo/counter__[false] into r0;
    get.or_use storage_demo.aleo/counter__[false] 0u64 into r1;
    cast true r1 into r2 as Optional__DmN5CQ9hzeK;
    cast false 0u64 into r3 as Optional__DmN5CQ9hzeK;
    ternary r0 r2 r3 into r4;
    assert.eq r4.is_some true;
    is.eq r4.val 0u64 into r5;
    assert.eq r5 true;

function unwrap_oob_get_halts:
    async unwrap_oob_get_halts into r0;
    output r0 as test_storage_demo.aleo/unwrap_oob_get_halts.future;

finalize unwrap_oob_get_halts:
    get.or_use storage_demo.aleo/history__len__[false] 0u32 into r0;
    lt 0u32 r0 into r1;
    get.or_use storage_demo.aleo/history__[0u32] 0u32 into r2;
    cast true r2 into r3 as Optional__JzunLORyB8U;
    cast false 0u32 into r4 as Optional__JzunLORyB8U;
    ternary r1 r3 r4 into r5;
    assert.eq r5.is_some true;
    is.eq r5.val 0u32 into r6;
    assert.eq r6 true;

constructor:
    assert.eq edition 0u16;
