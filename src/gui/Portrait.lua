--[[
    Class that defines a character portrait
]]

Portrait = Class{}

function Portrait:init(x, y, character, scaleX, scaleY)
    self.id = character.portraitId
    self.x = x
    self.y = y
    self.scaleX = scaleX
    self.scaleY = scaleY
end

function Portrait:render()
    love.graphics.draw(gTextures['portraits'][self.id], self.x, self.y, 0, self.scaleX, self.scaleY)
end