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

return m
