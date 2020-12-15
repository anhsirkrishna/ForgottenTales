--[[
    State when a character is selected

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharSpellState = Class{__includes = BaseState}

function CharSpellState:init(character, camera, level)
    self.character = character
    self.level = level
    self.camera = camera
    self.spellList = SpellList(self.character,
                                function(spell)
                                    gStateStack:pop()
                                    gStateStack:push(CharAttackState(self.character, self.camera, self.level, spell))
                                end    
                            )
end

function CharSpellState:update(dt)
    if love.mouse.wasPressed(2) then
        gSounds['menu-backward']:play()
        gStateStack:pop()
    end
    self.spellList:update(dt)
end

function CharSpellState:render()    
    self.spellList:render()
end
