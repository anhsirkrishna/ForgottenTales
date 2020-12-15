--[[
    Sheet class 

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Sheet = Class{}

function Sheet:init(x, y, gridWidth, gridHeight)
    self.x = x
    self.y = y
    self.width = gridWidth
    self.height = gridHeight
    self.visible = true
end

function Sheet:update(dt)

end

function Sheet:render()
    --First render the corner peices
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['topLeft'], 
        self.x, self.y)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['topRight'], 
        self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y, 0)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['botLeft'], 
        self.x, self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE), 0)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['botRight'], 
        self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE))

    --Render the top row
    for i=1, self.width - 2 , 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['topMid'], 
        self.x + (i*SMALL_GUI_TILE_SIZE), self.y)
    end

    --Render the bot row
    for i=1, self.width - 2 , 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['botMid'], 
        self.x + (i*SMALL_GUI_TILE_SIZE), self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE))
    end

    -- Render the left column
    for i=1, self.height - 2, 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['midLeft'], 
        self.x, self.y + (i*SMALL_GUI_TILE_SIZE))
    end

    -- Render the right column
    for i=1, self.height - 2, 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['midRight'], 
        self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + (i*SMALL_GUI_TILE_SIZE))
    end

    -- Render all the middle blocks
    for i=1, self.width - 2, 1 do
        for j=1, self.height - 2 , 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['sheet']['midMid'], 
                self.x + (i*SMALL_GUI_TILE_SIZE), self.y + (j*SMALL_GUI_TILE_SIZE))
        end
    end
end

function Sheet:toggle()
    self.visible = not self.visible
end