--[[
    State when a character has to interact with an object

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharInteractState = Class{__includes = BaseState}

function CharInteractState:init(character, camera, level)
    self.character = character
    self.camera = camera
    self.level = level
    attackTileColors = {
        {114/255, 219/255, 72/255, 180/255},
        {77/255, 222/255, 20/255, 230/255},
        {255/255, 255/255, 255/255, 255/255}
    }
    self.attackMap = MapTileSelector(self.character, self.character.atkRange, 
                                     self.camera, self.level, 
                                     function(destinationTile, pathToTile)
                                        self:onSelect(destinationTile, pathToTile)
                                     end, 
                                     false, true, true, attackTileColors)
    self.textPanel = TextPanel(self.character.x, self.character.y-40, 260, 60, "There's nothing to interact with !", {0,0,0,255})
    self.textPanel.visible = false
end

function CharInteractState:update(dt)
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

    self.attackMap:update(dt)
    self.character:update(dt, self.camera)
    self.level:update(dt, self.camera)
    ::continue::
end

function CharInteractState:render()    
    self.attackMap:render()
    self.textPanel:render()
end

function CharInteractState:onSelect(selectedTile, pathToTile)
    atkX = selectedTile.mapX
    atkY = selectedTile.mapY
    entity = self.level.entityLayer[atkY][atkX]
    if entity then
        if entity.interactable then
            entity:interact(self.character)
            gStateStack:pop()
        else
            self.textPanel.visible = true
            gSounds['error']:play()
        end
    else
        self.textPanel.visible = true
        gSounds['error']:play()
    end
end