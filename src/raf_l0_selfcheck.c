/* RAFCODEΦ L0: original in-binary sanity test. No headers, libc or syscalls.
 * A zero return means these scoped checks passed, NOT that the engine works.
 */
typedef unsigned int raf_u32;
typedef unsigned char raf_u8;
extern raf_u32 raf_l0_token_kind(const raf_u8 *, raf_u32);
extern raf_u32 raf_l0_fold32(const raf_u8 *, raf_u32, raf_u32 *);
extern raf_u32 raf_l0_compiled_abi(void);

raf_u32 raf_l0_selfcheck(void)
{
    const raf_u8 ascii_sp[4] = {32u, 32u, 32u, 32u};
    const raf_u8 null_octets[4] = {0u, 0u, 0u, 0u};
    const raf_u8 sequence[4] = {1u, 2u, 3u, 4u};
    raf_u32 v1 = 0u, v2 = 0u;
    if (raf_l0_token_kind((const raf_u8 *)0, 0u) != 1u) return 11u;
    if (raf_l0_token_kind((const raf_u8 *)0, 4u) != 5u) return 12u;
    if (raf_l0_token_kind(sequence, 0u) != 2u) return 13u;
    if (raf_l0_token_kind(ascii_sp, 4u) != 3u) return 14u;
    if (raf_l0_token_kind(null_octets, 4u) != 4u) return 15u;
    if (raf_l0_fold32(sequence, 4u, &v1) != 0u) return 16u;
    if (raf_l0_fold32(sequence, 4u, &v2) != 0u || v1 != v2) return 17u;
    if (raf_l0_fold32((const raf_u8 *)0, 0u, &v1) != 0u || v1 != 2166136261u) return 18u;
    if (raf_l0_fold32((const raf_u8 *)0, 1u, &v1) != 1u) return 19u;
    if (raf_l0_fold32(sequence, 4097u, &v1) != 2u) return 20u;
    if (raf_l0_compiled_abi() == 0u) return 21u;
    return 0u;
}
