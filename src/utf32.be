import string as s

m = module()

class CodePoint
    var value
    def init(value)
        assert(type(value) == 'int')
        self.value = value
    end

    def ==(other)
        return classname(other) == 'CodePoint' && other.value == self.value
    end

    def tostring()
        return s.format('CodePoint(0x%s)', s.hex(self.value))
    end
end
m.CodePoint = CodePoint

return m
