--[[
    SpellSlot class 
    An interactable UI element to represent a Spell

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

SpellSlot = Class{}

function SpellSlot:init(x, y, spell, character, width, height, onClick)
    self.x = x
    self.y = y
    self.visible = true
    self.spell = spell
    self.character = character
    self.onClick = onClick
    if width ~= nil then
        self.width = width
    else
        self.width = 32
    end

    if height ~= nil then
        self.height = height
    else
        self.height = 32
    end

    self.imgScaleX = self.width/32
    self.imgScaleY = self.height/32
    self.clickable = true

end

function SpellSlot:update(dt)
    if self:containCoords(love.mouse.mouseX, love.mouse.mouseY) then
        if self.clickable then
            if love.mouse.wasPressed(1) then
                self.onClick(self.spell)
                self.clickable = false
                Timer.after(1,
                    function()
                        self.clickable = true
                    end
                )
            end
        else
            if love.mouse.wasPressed(1) then
                gSounds['error']:play()
            end
        end
    end
end

function SpellSlot:render()
    if self.visible then
        love.graphics.draw(gTextures['spellicons'][self.spell.name], self.x, self.y, 0, self.imgScaleX, self.imgScaleY)
    end
end

function SpellSlot:toggle()
    self.visible = not self.visible
end

function SpellSlot:containCoords(x, y)
    if (self.x < x) and (self.x + self.width > x) and (self.y < y) and (self.y + self.height > y) then
        return true
    end
    return false
end