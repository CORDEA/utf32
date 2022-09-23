import '../src/utf32' as utf32
import '../src/utf8' as utf8

var points = [
    # First character
    utf32.CodePoint(0x00),
    # 0
    utf32.CodePoint(0x30),
    # a
    utf32.CodePoint(0x61),
    # 星
    utf32.CodePoint(0x661f),
    # 🌕
    utf32.CodePoint(0x1f315),
    # Last character
    utf32.CodePoint(0x10ffff)
]
assert(utf8.encode(points) == [
    0x00,

    0x30,

    0x61,

    0xe6,
    0x98,
    0x9f,

    0xf0,
    0x9f,
    0x8c,
    0x95,

    0xf4,
    0x8f,
    0xbf,
    0xbf
])

points = [0x10ffff + 1]
var haserror = false
try
    utf8.encode(points)
except ..
    haserror = true
end
assert(haserror)
