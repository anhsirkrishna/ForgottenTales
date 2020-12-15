--[[
    The class for creating the battle terrain from the battle terrain tilemap

    Author : Krishna S Pillai (krishna_sp@outlook.com)
]]

BattleTerrain = Class{}

function BattleTerrain:init(type)
    self.layer = BATTLE_TERRAIN_DEFS[type].layer
end

function BattleTerrain:update(dt)
end

function BattleTerrain:render()
    --Darken the base layer i.e the overworld level
    love.graphics.setColor(0/255, 0/255, 0/255, 220/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    --Render the Layer
    for y, row in pairs(self.layer) do
        for x, tileId in pairs(row) do
            love.graphics.draw(gTextures['battleTerrainTiles'], gFrames['battleTerrainTiles'][tileId],
            (x - 1) * TILE_SIZE, (y+5 - 1) * TILE_SIZE)
        end
    end
end