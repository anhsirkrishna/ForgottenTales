-- Queue taken from "Lua Game Development Cookbook" by Mario Kasuba
Queue = Class{}

function Queue:init()
    self.out = {}
    self.first = 0
    self.last = -1
end

function Queue:push(item)
    self.last = self.last + 1
    self.out[self.last] = item
end

function Queue:pop()
    if self.first <= self.last then
        value = self.out[self.first]
        self.out[self.first] = nil
        self.first = self.first + 1
        return value
    end
end

function Queue:iterator()
    return function()
        return self:pop()
    end
end

function Queue:length()
    return (self.last-self.first+1)
end