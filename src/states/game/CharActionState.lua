--[[
    State when a character action is selected

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharActionState = Class{__includes = BaseState}

function CharActionState:init(character, camera, level)
    self.character = character
    self.level = level
    self.camera = camera
    self.attackMap = nil
    self.menu = CharSelectMenu(
                    self.character, 
                    {
                        { 
                            "Attack",
                            function()
                                gStateStack:pop()
                                gStateStack:push(CharAttackState(self.character, self.camera, self.level))
                            end,
                            not self.character.hasAttacked
                        },
                        {
                            "Spells",
                            function()
                                gStateStack:pop()
                                gStateStack:push(CharSpellState(self.character, self.camera, self.level, self.character.spells[1]))
                            end,
                            true
                        },
                        {
                            "Check",
                            function()
                                gStateStack:pop()
                                gStateStack:push(CharInteractState(self.character, self.camera, self.level))
                            end,
                            true
                        }
                })
end

function CharActionState:update(dt)
    if love.mouse.wasPressed(2) then
        gStateStack:pop()
        gSounds['menu-backward']:play()
        gStateStack:push(CharSelectState(self.character, self.camera, self.level))
    end
    self.menu:update(dt)
end

function CharActionState:render()    
    self.menu:render()
end
