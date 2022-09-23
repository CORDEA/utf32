import string as s
import utf32 as u

m = module()

def encode(points)
    var result = []
    for i : 0..size(points)-1
        var point = points[i]
        assert(classname(point) == 'CodePoint')
        var c = point.value
        if c <= 0x7f
            result.push(c)
        elif c <= 0x7ff
            result.push(c >> 6 | 0xc0)
            result.push(c & 0x3f | 0x80)
        elif c <= 0xffff
            result.push(c >> 12 | 0xe0)
            result.push(c >> 6 & 0x3f | 0x80)
            result.push(c & 0x3f | 0x80)
        elif c <= 0x10ffff
            result.push(c >> 18 | 0xf0)
            result.push(c >> 12 & 0x3f | 0x80)
            result.push(c >> 6 & 0x3f | 0x80)
            result.push(c & 0x3f | 0x80)
        else
            raise 'Invalid code point'
        end
    end
    return result
end
m.encode = encode

def decode(str)
    var i = 0
    var points = []
    while i < size(str)
        var c = s.byte(str[i])
        var l = 0
        if c <= 0x7f
        elif (c & 0xe0) == 0xc0
            c &= 0x1f
            l = 1
        elif (c & 0xf0) == 0xe0
            c &= 0xf
            l = 2
        elif (c & 0xf8) == 0xf0
            c &= 0x7
            l = 3
        else
            raise 'Invalid character'
        end

        if l <= 0
            points.push(u.CodePoint(c))
            i += 1
            continue
        end

        for j : 1..l
            c <<= 6
            nc = s.byte(str[i + j])
            c |= nc & 0x3f
        end

        if c > 0x10ffff
            raise 'Invalid character'
        end
        points.push(u.CodePoint(c))
        i += l + 1
    end
    return points
end
m.decode = decode

return m
