--[[
    Button class

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Button = Class{}

HEIGHTS = {
    ['small'] = 16,
    ['medium'] = 16,
    ['wide'] = 16
}

WIDTHS = {
    ['small'] = 16,
    ['medium'] = 32,
    ['wide'] = 48
}

function Button:init(x, y, type, text, onClick, width, height)
    self.x = x
    self.y = y
    self.type = type
    self.height = HEIGHTS[self.type]
    self.width = WIDTHS[self.type]
    self.onClick = onClick
    self.visible = true
    self.enabled = true
    if width then
        self.scaleX = width / self.width
        self.width = width
    else
        self.scaleX = 1
    end

    if height then
        self.scaleY = height / self.height
        self.height = height
    else
        self.scaleY = 1
    end
    self.text = text or nil
    self.clickedFrames = 20
    self.clicked = "Unclicked"
    self.textXoffset = 2
    self.textYoffset = 0
end

function Button:update(dt)
    local coords = love.mouse.wasPressed(1)
    if coords then
        if self:coordsMatch(coords[1], coords[2]) then
            if self.enabled then
                gSounds['menu-forward']:play()
                self.clicked = "Clicked"
                self.textYoffset = self.textYoffset + 2
                Timer.after(0.25, function()
                    self.clicked = "Unclicked"
                    self.textYoffset = 0
                    self.onClick()
                end)
            else
                gSounds['error']:play()
            end
        end
    end
end

function Button:render()
    if self.visible then
        if self.enabled then
            love.graphics.draw(gTextures["GUI"],gFrames["GUI"]["buttons"][self.type..self.clicked],
                self.x, self.y, 0, self.scaleX, self.scaleY)
        else
            love.graphics.draw(gTextures["GUI"],gFrames["GUI"]["buttons"][self.type.."GreyedOut"],
                self.x, self.y, 0, self.scaleX, self.scaleY)
        end

        if self.text then
            if self.enabled then
                love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
            else
                love.graphics.setColor(102/255, 96/255, 97/255, 255/255)
            end
            love.graphics.setFont(gFonts['smallName'])
            love.graphics.printf(self.text,  self.x + self.textXoffset, self.y + self.textYoffset, self.width - 4, 'center')
            love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        end
    end
end

function Button:toggle()
    self.visible = not self.visible
end

--Function to check if the given coordinates are over the button
function Button:coordsMatch(x, y)
    if self.x < x and (self.x + self.width) > x and self.y < y and (self.y + self.height) > y then
        return true
    end

    return false
end