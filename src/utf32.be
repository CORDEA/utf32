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
end
m.CodePoint = CodePoint

return m
