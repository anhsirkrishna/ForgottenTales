--[[
    UI Element to display character spells
]]

SpellList = Class{}

function SpellList:init(character, onClick)
    self.x = TILE_SIZE * 2
    self.y = TILE_SIZE * 1
    self.character = character
    self.spellSheets = {}
    self.spellSlots = {}
    self.spellDescriptions = {}
    self.spellDmgDescriptions = {}
    self.spellMenu = MenuPanel(self.x, self.y, 17, 4*#self.character.spells)
    for i, spell in pairs(self.character.spells) do        
        table.insert(self.spellSheets, Sheet(self.x + 8 , self.y + 8 + (56*(i-1)), 16, 3))
        table.insert(self.spellSlots, SpellSlot(self.x + 16, self.y + 12 + (56*(i-1)) + 4, 
                                                spell, self.character, nil, nil, onClick))
        table.insert(self.spellDescriptions, spell.description)
        table.insert(self.spellDmgDescriptions, spell.dmgDescription)
    end
end

function SpellList:update(dt)
    for i, spellSlot in pairs(self.spellSlots) do
        if spellSlot.spell.cost > self.character.currentSpellPoints then
            spellSlot.clickable = false
        end
        spellSlot:update()
    end
end

function SpellList:render()
    self.spellMenu:render()
    for i=1, #self.character.spells, 1 do
        self.spellSheets[i]:render()
        self.spellSlots[i]:render()
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
        love.graphics.printf(self.spellDescriptions[i], self.spellSlots[i].x + 36, self.spellSheets[i].y+2, 7*TILE_SIZE, 'center')
        love.graphics.printf(self.spellDmgDescriptions[i], self.spellSlots[i].x + 36, self.spellSheets[i].y + 16, 7*TILE_SIZE, 'center')
        love.graphics.printf("Cost : "..self.spellSlots[i].spell.cost.." SP", self.spellSlots[i].x + 36, self.spellSheets[i].y + 32, 7*TILE_SIZE, 'center')
        if not self.spellSlots[i].clickable then
            love.graphics.setColor(0/255, 0/255, 0/255, 180/255)
            love.graphics.rectangle('fill', self.spellSheets[i].x, self.spellSheets[i].y, 
                                    self.spellSheets[i].width*16, self.spellSheets[i].height*16, 2, 2)
        end
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end
end
