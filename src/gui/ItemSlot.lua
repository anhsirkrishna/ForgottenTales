--[[
    ItemSlot class 
    An interactable UI element to represent an item

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ItemSlot = Class{}

function ItemSlot:init(x, y, item, character, bgType, width, height)
    self.x = x
    self.y = y
    self.visible = true
    self.item = item
    self.character = character
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

    if bgType ~= nil then
        self.bgType = bgType
    else
        self.bgType = 'icons'
    end
    self.imgScaleX = self.width/32
    self.imgScaleY = self.height/32
    self.clickable = true
    local txtwidth = #self.item.description

    self.popup = Popup(self.x-32, self.y-16, txtwidth/3, 3, self.item.description)
end

function ItemSlot:update(dt)
    if self:containCoords(love.mouse.mouseX, love.mouse.mouseY) then
        if self.clickable then
            if love.mouse.wasPressed(1) then
                self.item.use(self.character)
                self.clickable = false
                Timer.after(1,
                    function()
                        self.clickable = true
                    end
                )
            end
        end
        self.popup.visible = true
    else
        self.popup.visible = false
    end
end

function ItemSlot:render()
    if self.visible then
        love.graphics.draw(gTextures[self.bgType], gFrames[self.bgType][self.item.icon], self.x, self.y, 0, self.imgScaleX, self.imgScaleY)
    end
end

function ItemSlot:toggle()
    self.visible = not self.visible
end

function ItemSlot:containCoords(x, y)
    if (self.x < x) and (self.x + self.width > x) and (self.y < y) and (self.y + self.height > y) then
        return true
    end
    return false
end