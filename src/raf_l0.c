/*
 * RAFCODEΦ L0 — bounded freestanding data primitive.
 * Original implementation in this repository; no imported Firebird code.
 * No headers, libc, heap, syscalls, Android APIs, or dynamic allocation.
 * This is NOT a Firebird server, crypto function, linked executable, or APK.
 */
#if !defined(__SIZEOF_INT__) || (__SIZEOF_INT__ != 4)
#error "L0 requires 32-bit unsigned int; unsupported toolchain"
#endif
#if !defined(__SIZEOF_CHAR__) || (__SIZEOF_CHAR__ != 1)
#error "L0 requires 8-bit char; unsupported toolchain"
#endif

typedef unsigned int raf_u32;
typedef unsigned char raf_u8;

/* Typed, non-semantic observations. Never infer meaning from text. */
#define RAF_L0_NULL_EMPTY  1u
#define RAF_L0_EMPTY       2u
#define RAF_L0_FOUR_SPACES 3u
#define RAF_L0_BYTES       4u
#define RAF_L0_INVALID     5u

#define RAF_L0_OK          0u
#define RAF_L0_BAD_INPUT   1u
#define RAF_L0_TOO_LARGE   2u

raf_u32 raf_l0_token_kind(const raf_u8 *bytes, raf_u32 length)
{
    if (bytes == (const raf_u8 *)0) {
        return length == 0u ? RAF_L0_NULL_EMPTY : RAF_L0_INVALID;
    }
    if (length == 0u) {
        return RAF_L0_EMPTY;
    }
    if (length == 4u &&
        bytes[0] == 32u && bytes[1] == 32u &&
        bytes[2] == 32u && bytes[3] == 32u) {
        return RAF_L0_FOUR_SPACES;
    }
    return RAF_L0_BYTES;
}

/* Non-cryptographic checksum only; callers prove buffer extent separately. */
raf_u32 raf_l0_fold32(const raf_u8 *bytes, raf_u32 length, raf_u32 *output)
{
    if (output == (raf_u32 *)0 ||
        (length != 0u && bytes == (const raf_u8 *)0)) {
        return RAF_L0_BAD_INPUT;
    }
    if (length > 4096u) {
        return RAF_L0_TOO_LARGE;
    }
    raf_u32 state = 2166136261u;
    for (raf_u32 i = 0u; i < length; ++i) {
        state = (state ^ (raf_u32)bytes[i]) * 16777619u;
    }
    *output = state;
    return RAF_L0_OK;
}

/* Compile-time ABI tag; not runtime detection and not an OS probe. */
raf_u32 raf_l0_compiled_abi(void)
{
#if defined(__aarch64__)
    return 64u;
#elif defined(__arm__)
    return 32u;
#elif defined(__x86_64__)
    return 86u;
#else
    return 0u;
#endif
}
