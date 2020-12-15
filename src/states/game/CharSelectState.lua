--[[
    State when a character is selected

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharSelectState = Class{__includes = BaseState}

function CharSelectState:init(character, camera, level)
    self.character = character
    self.level = level
    self.camera = camera
    self.menu = CharSelectMenu(
                    self.character, 
                    {
                        { 
                            "Move",
                            function()
                                gStateStack:pop() 
                                gStateStack:push(CharMoveState(self.character, self.camera, self.level)) 
                            end,
                            not self.character.hasMoved
                                
                        },
                        {
                            "Action",
                            function()
                                gStateStack:pop()
                                gStateStack:push(CharActionState(self.character, self.camera, self.level))
                            end,
                            true
                        },
                        {
                            "Stats",
                            function()
                                gStateStack:pop()
                                gStateStack:push(CharStatsState(self.character, self.camera, self.level))
                            end,
                            true
                        }
                })
end

function CharSelectState:update(dt)
    if love.mouse.wasPressed(2) then
        gSounds['menu-backward']:play()
        gStateStack:pop()
    end
    self.menu:update(dt)
end

function CharSelectState:render()    
    self.menu:render()
end
