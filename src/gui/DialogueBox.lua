--[[
    UI Element to display relevant info during battle state
]]

DialogueBox = Class{}

function DialogueBox:init(character, text, font)
    self.text = text
    self.font = font or gFonts['small']
    _, self.textChunks = self.font:getWrap(self.text, VIRTUAL_WIDTH - 88)

    self.chunkCounter = 1
    self.endOfText = false
    self.closed = false
    self.visible = true
    self:next()

    self.woodPanel = WoodPanel(0, VIRTUAL_HEIGHT - (TILE_SIZE*3), 26, 5)
    self.portrait = Portrait(8, VIRTUAL_HEIGHT - (TILE_SIZE*3) + 8, character, 1, 1)
    self.sheet = Sheet(self.woodPanel.x + 64 + 12, self.woodPanel.y + 8, 19, 4)
    
end

function DialogueBox:update(dt)
    if self.visible then
        if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            self:next()
        end
    end
end

function DialogueBox:render()
    if self.visible then
        self.woodPanel:render()
        self.portrait:render()
        self.sheet:render()

        love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
        love.graphics.setFont(self.font)
        for i = 1, #self.displayingChunks do
            love.graphics.print(self.displayingChunks[i], self.sheet.x + 4, self.sheet.y + 4 + (i - 1) * 16)
        end
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end
end

--[[
    Goes to the next page of text if there is any, otherwise toggles the textbox.
]]
function DialogueBox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 2 do
        table.insert(chunks, self.textChunks[i])

        -- if we've reached the number of total chunks, we can return
        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function DialogueBox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end