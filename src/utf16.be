m = module()

def encode(points)
    var result = []
    for i : 0..size(points)-1
        var point = points[i]
        assert(classname(point) == 'CodePoint')
        var c = point.value
        if c > 0x10ffff
            raise 'Invalid code point'
        end
        if c < 0xd800 || c > 0xdfff && c < 0x10000
            result.push(c)
            continue
        end
        result.push(0xd800 + (c - 0x10000 >> 10))
        result.push((c & 0x3ff) + 0xdc00)
    end
    return result
end
m.encode = encode

def decode(chars)
    var i = 0
    var points = []
    while i < size(chars)
        var c = chars[i]
        var l = 0
        if c >= 0x10000
            raise 'Invalid character'
        end

        if c < 0xd800 || c > 0xdfff
            points.push(utf32.CodePoint(c))
            i += 1
            continue
        end
        var nc = chars[i+1]
        var p = 0x10000 + (c - 0xd800 << 10) + nc - 0xdc00
        points.push(utf32.CodePoint(p))
        i += 2
    end
    return points
end
m.decode = decode

return m
