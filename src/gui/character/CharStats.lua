--[[
    UI Element to display character inventory and stats
]]

CharStats = Class{}

function CharStats:init(character)
    self.x = TILE_SIZE * 1
    self.y = TILE_SIZE * 1
    self.character = character
    self.woodPanel = WoodPanel(self.x, self.y, 20, 10)
    self.portrait = Portrait(self.x + 8, self.y + 8, character)
    self.sheet = Sheet(self.x + 82, self.y + 6 , 14, 5)
    self.weaponSheet = StoneSheet(self.x + 7, self.y + 84, 4, 2)
    self.armorSheet = StoneSheet(self.x + 7, self.y + 124, 4, 2)
    self.inventorySlots = MenuPanel(self.x + 82, self.y + 88, 14, 4)
    self.inventoryItems = {}
    self.weaponSlot = nil
    self.armourSlot = nil

    self.statModHighlight = true

    Timer.every(0.5, 
        function()
            self.statModHighlight = not self.statModHighlight
        end
    )
end

function CharStats:update(dt)
    self.inventoryItems = {}
    for i, item in pairs(self.character.inventory) do
        table.insert(self.inventoryItems, ItemSlot(self.inventorySlots.x+16+((i-1)*48), self.inventorySlots.y + 22, item, self.character, 'iconsBg'))
    end

    if self.character.weapon then
        self.weaponSlot = ItemSlot(self.weaponSheet.x, self.weaponSheet.y, self.character.weapon, self.character, nil, 30, 30)
        self.weaponSlot.clickable = false
        self.weaponSlot:update(dt)
    end
    
    if self.character.armour then
        self.armourSlot = ItemSlot(self.armorSheet.x, self.armorSheet.y, self.character.armour, self.character, nil, 30, 30)
        self.armourSlot.clickable = false
        self.armourSlot:update(dt)
    end    
    for i, item in pairs(self.inventoryItems) do
        item:update()
    end
end

function CharStats:render()
    self.woodPanel:render()
    self.portrait:render()
    self.sheet:render()
    self.weaponSheet:render()
    self.armorSheet:render()
    self.inventorySlots:render()
    love.graphics.setFont(gFonts['smallName'])
    --love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
    love.graphics.printf("Weapon", self.weaponSheet.x, self.weaponSheet.y - 11, 4*16, 'center')
    love.graphics.setFont(gFonts['smallName'])
    love.graphics.printf("Armour", self.armorSheet.x, self.armorSheet.y - 11, 4*16, 'center')

    love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
    love.graphics.setFont(gFonts['smallNum'])
    love.graphics.printf(self.character.name, self.sheet.x+4, self.sheet.y+4, 4*16, 'center')
    love.graphics.printf(self.character.charClass, self.sheet.x+100, self.sheet.y+4, 8*16, 'center')
    love.graphics.printf("HP : "..self.character.currentHp.."/"..self.character.baseHp,
                        self.sheet.x+6, self.sheet.y+20, 4*16, 'center')
    love.graphics.printf("SP : "..self.character.currentSpellPoints.."/"..self.character.spellPoints,
                        self.sheet.x+100, self.sheet.y+20, 4*16, 'center')
    love.graphics.printf("Atk : "..self.character.atk,
                        self.sheet.x+6, self.sheet.y+36, 4*16, 'center')
    love.graphics.printf("Def : "..self.character.def,
                        self.sheet.x+6, self.sheet.y+52, 4*16, 'center')
    love.graphics.printf("Spl : "..self.character.spell,
                        self.sheet.x+100, self.sheet.y+36, 4*16, 'center')
    love.graphics.printf("Res : "..self.character.res,
                        self.sheet.x+100, self.sheet.y+52, 4*16, 'center')
    
    
    self:printStatModAdd()

    self:printStatModNeg()

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    love.graphics.setFont(gFonts['smallName'])
    love.graphics.printf("Inventory", self.inventorySlots.x+16, self.inventorySlots.y+4, 4*16, 'center')

    if self.weaponSlot then
        self.weaponSlot:render()
        self.weaponSlot.popup:render()
    end

    if self.armourSlot then
        self.armourSlot:render()
        self.armourSlot.popup:render()
    end

    for i, item in pairs(self.inventoryItems) do
        item:render()
    end
    for i, item in pairs(self.inventoryItems) do
        item.popup:render()
    end
    if self.weaponSlot then
        self.weaponSlot.popup:render()
    end

    if self.armourSlot then
        self.armourSlot.popup:render()
    end
end

function CharStats:printStatModAdd()
    --love.graphics.setFont(gFonts['smallMain'])
    if self.statModHighlight then
        love.graphics.setColor(23/255, 89/255, 189/255, 255/255)
    else
        love.graphics.setColor(9/255, 56/255, 99/255, 255/255)
    end

    local atkMod = self.character:getTotalMod('atk')
    if atkMod > 0 then
        love.graphics.printf("+"..atkMod,
                            self.sheet.x+34, self.sheet.y+35, 4*16, 'center')
    end

    local defMod = self.character:getTotalMod('def')
    if defMod > 0 then
        love.graphics.printf("+"..defMod,
                            self.sheet.x+34, self.sheet.y+51, 4*16, 'center')
    end
    
    local spellMod = self.character:getTotalMod('spell')
    if spellMod > 0 then
        love.graphics.printf("+"..spellMod,
                            self.sheet.x+128, self.sheet.y+35, 4*16, 'center')
    end
    
    local resMod = self.character:getTotalMod('res')
    if resMod > 0 then
        love.graphics.printf("+"..resMod,
                            self.sheet.x+128, self.sheet.y+51, 4*16, 'center')
    end
end

function CharStats:printStatModNeg()
    --love.graphics.setFont(gFonts['smallMain'])
    if self.statModHighlight then
        love.graphics.setColor(189/255, 23/255, 23/255, 255/255)
    else
        love.graphics.setColor(99/255, 9/255, 9/255, 255/255)
    end

    local atkMod = self.character:getTotalMod('atk')
    if atkMod < 0 then
        love.graphics.printf(""..atkMod,
                            self.sheet.x+34, self.sheet.y+35, 4*16, 'center')
    end

    local defMod = self.character:getTotalMod('def')
    if defMod < 0 then
        love.graphics.printf(""..defMod,
                            self.sheet.x+34, self.sheet.y+51, 4*16, 'center')
    end
    
    local spellMod = self.character:getTotalMod('spell')
    if spellMod < 0 then
        love.graphics.printf(""..spellMod,
                            self.sheet.x+128, self.sheet.y+35, 4*16, 'center')
    end
    
    local resMod = self.character:getTotalMod('res')
    if resMod < 0 then
        love.graphics.printf(""..resMod,
                            self.sheet.x+128, self.sheet.y+51, 4*16, 'center')
    end
end