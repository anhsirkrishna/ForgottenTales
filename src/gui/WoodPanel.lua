--[[
    Wood Panel class 

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

WoodPanel = Class{}

function WoodPanel:init(x, y, gridWidth, gridHeight)
    self.x = x
    self.y = y
    self.width = gridWidth
    self.height = gridHeight
    self.visible = true
end

function WoodPanel:update(dt)

end

function WoodPanel:render()
    --First render the corner peices
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['topLeft'], 
        self.x, self.y)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['topRight'], 
        self.x + ((self.width-1)*GUI_TILE_SIZE), self.y, 0)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['botLeft'], 
        self.x, self.y + ((self.height-1)*GUI_TILE_SIZE), 0)
    love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['botRight'], 
        self.x + ((self.width-1)*GUI_TILE_SIZE), self.y + ((self.height-1)*GUI_TILE_SIZE))

    --Render the top row
    for i=1, self.width - 2 , 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['topMid'], 
        self.x + (i*GUI_TILE_SIZE), self.y)
    end

    --Render the bot row
    for i=1, self.width - 2 , 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['botMid'], 
        self.x + (i*GUI_TILE_SIZE), self.y + ((self.height-1)*GUI_TILE_SIZE))
    end

    -- Render the left column
    for i=1, self.height - 2, 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['midLeft'], 
        self.x, self.y + (i*GUI_TILE_SIZE))
    end

    -- Render the right column
    for i=1, self.height - 2, 1 do
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['midRight'], 
        self.x + ((self.width-1)*GUI_TILE_SIZE), self.y + (i*GUI_TILE_SIZE))
    end

    -- Render all the middle blocks
    for i=1, self.width - 2, 1 do
        for j=1, self.height - 2 , 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['woodPanel']['midMid'], 
                self.x + (i*GUI_TILE_SIZE), self.y + (j*GUI_TILE_SIZE))
        end
    end
end

function WoodPanel:toggle()
    self.visible = not self.visible
end