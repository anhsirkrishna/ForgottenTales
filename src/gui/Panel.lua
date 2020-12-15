--[[
    Panel class

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Panel = Class{}

function Panel:init(x, y, width, height, borderColor)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.panelType = "Panel" .. borderColor
    self.scaleX = width/gTextures[self.panelType]:getWidth()
    self.scaleY = height/gTextures[self.panelType]:getHeight()
    self.visible = true
end

function Panel:update(dt)

end

function Panel:render()
    love.graphics.draw(gTextures[self.panelType], self.x, self.y, 0, self.scaleX, self.scaleY)
end

function Panel:toggle()
    self.visible = not self.visible
end