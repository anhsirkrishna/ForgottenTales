--[[
    State when a character has to move

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharAttackState = Class{__includes = BaseState}

function CharAttackState:init(character, camera, level, spell)
    self.character = character
    self.camera = camera
    self.level = level
    self.spell = spell or nil
    attackTileColors = {
        {236/255, 64/255, 52/255, 180/255},
        {156/255, 13/255, 3/255, 230/255},
        {0/255, 0/255, 0/255, 255/255}
    }
    local range = nil
    if self.spell then
        range = self.spell.range
    else
        range = self.character.atkRange
    end
    self.attackMap = MapTileSelector(self.character, range, 
                                     self.camera, self.level, 
                                     function(destinationTile, pathToTile)
                                        self:onSelect(destinationTile, pathToTile)
                                     end, 
                                     false, true, true, attackTileColors)
    self.textPanel = TextPanel(self.character.x, self.character.y-40, 220, 60, "There's nothing to attack !", {0,0,0,255})
    self.textPanel.visible = false
end

function CharAttackState:update(dt)
    if self.textPanel.visible == true then
        if love.mouse.wasPressed(2) or love.mouse.wasPressed(1) then
            gSounds['menu-backward']:play()
            self.textPanel.visible = false
        end
        goto continue    
    end
    if love.mouse.wasPressed(2) then
        gSounds['menu-backward']:play()
        gStateStack:pop()
    end

    self.attackMap:update()
    self.character:update(dt, self.camera)
    ::continue::
end

function CharAttackState:render()    
    self.attackMap:render()
    self.textPanel:render()
    for i, entity in pairs(self.level.enemyList) do
        entity:render()
    end
end

function CharAttackState:onSelect(selectedTile, pathToTile)
    atkX = selectedTile.mapX
    atkY = selectedTile.mapY
    entity = self.level.entityLayer[atkY][atkX]
    if entity then
        if entity.attackable then
            gStateStack:push(FadeState({
                r = 0, g = 0, b = 0
            },
            0.5, 0, 255,
            function()
                if self.spell == nil then
                    self.character.hasAttacked = true
                end
                self.character.direction = self.character:relativeDirection({atkX, atkY})
                gStateStack:pop()
                gStateStack:push(FadeState({
                    r = 0, g = 0, b = 0
                }, 0.5, 255, 220,
                function()
                    gStateStack:push(BattleState(self.character, self.camera, self.level, entity, nil, self.spell))
                end))
            end))
        else
            self.textPanel.visible = true
            gSounds['error']:play()
        end
    else
        self.textPanel.visible = true
        gSounds['error']:play()
    end
end