/* Hosted falsifiers, intentionally separate from freestanding source. */
typedef unsigned int raf_u32;
typedef unsigned char raf_u8;
extern raf_u32 raf_l0_token_kind(const raf_u8 *, raf_u32);
extern raf_u32 raf_l0_fold32(const raf_u8 *, raf_u32, raf_u32 *);
extern raf_u32 raf_l0_compiled_abi(void);

#define CHECK(expr) do { if (!(expr)) return __LINE__; } while (0)

int main(void)
{
    static const raf_u8 spaces[4] = {32u, 32u, 32u, 32u};
    static const raf_u8 zeros[4] = {0u, 0u, 0u, 0u};
    static const raf_u8 text[4] = {109u, 111u, 108u, 104u};
    static const raf_u8 other[4] = {109u, 111u, 108u, 105u};
    raf_u32 first = 0u;
    raf_u32 second = 0u;
    raf_u32 third = 0u;
    CHECK(raf_l0_token_kind((const raf_u8 *)0, 0u) == 1u);
    CHECK(raf_l0_token_kind((const raf_u8 *)0, 4u) == 5u);
    CHECK(raf_l0_token_kind(text, 0u) == 2u);
    CHECK(raf_l0_token_kind(spaces, 4u) == 3u);
    CHECK(raf_l0_token_kind(zeros, 4u) == 4u);
    CHECK(raf_l0_token_kind(text, 4u) == 4u);
    CHECK(raf_l0_fold32(text, 4u, &first) == 0u);
    CHECK(raf_l0_fold32(text, 4u, &second) == 0u);
    CHECK(raf_l0_fold32(other, 4u, &third) == 0u);
    CHECK(first == second);
    CHECK(first != third);
    CHECK(raf_l0_fold32((const raf_u8 *)0, 0u, &first) == 0u);
    CHECK(first == 2166136261u);
    CHECK(raf_l0_fold32((const raf_u8 *)0, 1u, &first) == 1u);
    CHECK(raf_l0_fold32(text, 4u, (raf_u32 *)0) == 1u);
    CHECK(raf_l0_fold32(text, 4097u, &first) == 2u);
    CHECK(raf_l0_compiled_abi() != 0u);
    return 0;
}
