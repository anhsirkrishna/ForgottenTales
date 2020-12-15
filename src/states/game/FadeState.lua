--[[
    State that fades in or out the current state

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

FadeState = Class{__includes = BaseState}

function FadeState:init(color, time, startOpacity, endOpacity, onFadeComplete)
    self.opacity = startOpacity
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.time = time

    Timer.tween(self.time, {
        [self] = {opacity = endOpacity}
    })
    :finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeState:update(dt)

end

function FadeState:render()
    love.graphics.setColor(self.r/255, self.g/255, self.b/255, self.opacity/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end