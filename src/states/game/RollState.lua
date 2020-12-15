--[[
    Rolling for an action

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

RollState = Class{__includes = BaseState}

function RollState:init(entity, camera, level)
    self.entity = entity
    self.level = level
    self.camera = camera
    self.roll = nil
    self.roll = rollD20()
    self.d20 = d20Roller(self.roll)
    self.entity.currentRoll = self.roll
    self.popped = false
end

function RollState:update(dt)
    self.d20:update(dt)
    if self.d20.animation.timesPlayed == 1 then
        if self.popped == false then
            self.popped = true
            Timer.after(1.5,
                function()
                    gStateStack:pop()
                end
            )
        end
    end
end

function RollState:render()    
    self.d20:render()
end
