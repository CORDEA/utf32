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

return m
