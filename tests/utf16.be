import '../src/utf32' as utf32
import '../src/utf16' as utf16

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
var chars = [
    0x00,

    0x30,

    0x61,

    0x661f,

    0xd83c,
    0xdf15,

    0xdbff,
    0xdfff
]

# encode
assert(utf16.encode(points) == chars)

var haserror = false
try
    utf16.encode([utf32.CodePoint(0x10ffff + 1)])
except ..
    haserror = true
end
assert(haserror)

# decode
assert(utf16.decode(chars) == points)

var haserror = false
try
    utf16.decode([0xffff + 1])
except ..
    haserror = true
end
assert(haserror)
