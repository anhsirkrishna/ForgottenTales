--[[
    Highlighted Tile Class

    Author: Krishna S Pillai (krishnas_sp@outlook.com)
]]

HighlightedTile = Class{}

function HighlightedTile:init(mapX, mapY, camera, color, selectedColor, borderColor)
    self.mapX = mapX
    self.mapY = mapY
    self.x = (self.mapX - camera.x) * TILE_SIZE
    self.y = (self.mapY - camera.y) * TILE_SIZE
    self.selected = false
    if color == nil then
        self.color = {105/255, 220/255, 255/255, 180/255}
    else
        self.color = color
    end
    if selectedColor == nil then
        self.selectedColor = {120/255, 220/255, 255/255, 230/255}
    else
        self.selectedColor = selectedColor
    end
    if borderColor == nil then
        self.borderColor = {255/255, 255/255, 255/255, 255/255}
    else
        self.borderColor = borderColor
    end 
end

function HighlightedTile:update(dt)

end

function HighlightedTile:render()
    if self.selected then
        love.graphics.setColor(self.selectedColor[1], self.selectedColor[2], 
                               self.selectedColor[3], self.selectedColor[4])
    else
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    end
    love.graphics.rectangle('fill', self.x + 1, self.y + 1, TILE_SIZE - 2, TILE_SIZE - 2)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    if self.selected then
        love.graphics.setColor(self.borderColor[1], self.borderColor[2], 
                               self.borderColor[3], self.borderColor[4])
        love.graphics.rectangle('line', self.x, self.y, TILE_SIZE, TILE_SIZE, 2)
    end
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end
