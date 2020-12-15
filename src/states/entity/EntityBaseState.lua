--[[
    Forgotten Tales

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

EntityBaseState = Class{}

function EntityBaseState:init(entity)
    self.entity = entity
end

function EntityBaseState:update(dt) end
function EntityBaseState:enter() end
function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end

function EntityBaseState:render()
    local anim = self.entity.currentAnimation
    love.graphics.push()
    love.graphics.translate(self.entity.dX, self.entity.dY)
    love.graphics.setColor(self.entity.tintColor)
    if anim.tintColor then
        love.graphics.setColor(anim.tintColor)
    end 
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y), 0, self.entity.scaleX, self.entity.scaleY)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.pop()
end