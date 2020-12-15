--[[
    State when a character is selected

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharStatsState = Class{__includes = BaseState}

function CharStatsState:init(character, camera, level)
    self.character = character
    self.level = level
    self.camera = camera
    self.statsUI = CharStats(self.character)
end

function CharStatsState:update(dt)
    if love.mouse.wasPressed(2) then
        gStateStack:pop()
    end
    self.statsUI:update(dt)
end

function CharStatsState:render()    
    self.statsUI:render()
end
