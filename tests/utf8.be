import '../src/utf32' as utf32
import '../src/utf8' as utf8

var points = [
    # 0
    utf32.CodePoint(0x30),
    # a
    utf32.CodePoint(0x61),
    # 星
    utf32.CodePoint(0x661f),
    # 🌕
    utf32.CodePoint(0x1f315)
]
assert(utf8.encode(points) == [
    0x30,

    0x61,

    0xe6,
    0x98,
    0x9f,

    0xf0,
    0x9f,
    0x8c,
    0x95
])
