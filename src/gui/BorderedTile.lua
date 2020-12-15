--[[
    Bordered Tile Class

    Author: Krishna S Pillai (krishnas_sp@outlook.com)
]]

HighlightedTile = Class{}

function HighlightedTile:init(mapX, mapY, camera)
    self.mapX = mapX
    self.mapY = mapY
    self.x = (self.mapX - camera.x) * TILE_SIZE
    self.y = (self.mapY - camera.y) * TILE_SIZE
end

function HighlightedTile:update(dt)

end

function HighlightedTile:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.rectangle('line', self.x, self.y, TILE_SIZE, TILE_SIZE, 10)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    
end
