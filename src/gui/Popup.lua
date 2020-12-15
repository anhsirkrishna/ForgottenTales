--[[
    Popup class 

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Popup = Class{}

function Popup:init(x, y, gridWidth, gridHeight, text)
    self.x = x
    self.y = y
    self.width = gridWidth
    self.height = gridHeight
    self.text = text    
    self.visible = true
end

function Popup:update(dt)

end

function Popup:render()
    --First render the corner peices
    if self.visible then
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['topLeft'], 
            self.x, self.y)
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midLeft'], 
            self.x, self.y+8)
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['topRight'], 
            self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y, 0)
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midRight'], 
            self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + 8, 0)
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['botLeft'], 
            self.x, self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE), 0)
        love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['botRight'], 
            self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE))

        --Render the top row
        for i=1, self.width - 1 , 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['topMid'], 
            self.x + (i*SMALL_GUI_TILE_SIZE), self.y)
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midMid'], 
            self.x + (i*SMALL_GUI_TILE_SIZE), self.y + 8)
        end

        --Render the bot row
        for i=1, self.width - 1 , 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['botMid'], 
            self.x + (i*SMALL_GUI_TILE_SIZE), self.y + ((self.height-1)*SMALL_GUI_TILE_SIZE))
        end

        -- Render the left column
        for i=1, self.height - 2, 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midLeft'], 
            self.x, self.y + (i*SMALL_GUI_TILE_SIZE))
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midLeft'], 
            self.x, self.y + (i*SMALL_GUI_TILE_SIZE) + 8)
        end

        -- Render the right column
        for i=1, self.height - 2, 1 do
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midRight'], 
            self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + (i*SMALL_GUI_TILE_SIZE))
            love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midRight'], 
            self.x + ((self.width-1)*SMALL_GUI_TILE_SIZE), self.y + (i*SMALL_GUI_TILE_SIZE) + 8)
        end

        -- Render all the middle blocks
        for i=1, self.width - 1, 1 do
            for j=1, self.height - 2 , 1 do
                love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midMid'], 
                    self.x + (i*SMALL_GUI_TILE_SIZE), self.y + (j*SMALL_GUI_TILE_SIZE))
                love.graphics.draw(gTextures['GUI'], gFrames['GUI']['popup']['midMid'], 
                    self.x + (i*SMALL_GUI_TILE_SIZE), self.y + (j*SMALL_GUI_TILE_SIZE) + 8)
            end
        end

        love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
        love.graphics.setFont(gFonts['smallName'])
        love.graphics.printf(self.text, self.x+2, self.y+2, self.width*16, 'center')
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end
end

function Popup:toggle()
    self.visible = not self.visible
end