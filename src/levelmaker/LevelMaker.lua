--[[
    Sub feature to quickly and easily make levels through a UI

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

LevelMaker = Class{__includes = BaseState}

function LevelMaker:init()
    self.uiPanel = Panel(0, VIRTUAL_HEIGHT*0.80, VIRTUAL_WIDTH, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT*0.80))
    buttonList = {}
    self.mapXSize = 20
    self.mapySize = 20

    self.menuTitle = TextPanel(self.uiPanel.x + 4, self.uiPanel + 4, 30, 15, "Map Size")
    self.xSizeDisplay = TextPanel(self.uiPanel.x + 8, self.uiPanel + 12, 8, 8, tostring(self.mapXSize))
    self.xSizeDecButton = Button(
        self.uiPanel.x + 4, self.uiPanel + 12, 8, 8, "<", 
        onClick = function() 
                    self.mapXSize = math.max(self.mapXSize - 1, 20)
                    self.xSizeDisplay.text = tostring(math.max(tonumber(self.xSizeDisplay.text) - 1, 20))
                end)
    self.xSizeIncButton = Button(self.uiPanel.x + 12, self.uiPanel + 12, 8, 8, ">", 
        onClick = function()
                    self.mapXSize = math.max(self.mapXSize - 1, 20)
                    self.xSizeDisplay.text = tostring(math.max(tonumber(self.xSizeDisplay.text) - 1, 20))
                end)

    self.tileSelectorLeft = Button()
    self.tileSelectorRight = Button()
    self.addLayerButton = Button()
    self.generateLevelButton = Button()
    table.insert(buttonList, self.xSizeDecButton)
    table.insert(buttonList, self.xSizeIncButton)
    table.insert(buttonList, self.tileSelectorLeft)
    table.insert(buttonList, self.tileSelectorRight)
    table.insert(buttonList, self.addLayerButton)

    self.ySizeDecButton = Button()
    self.ySizeDisplay = TextPanel()
    self.ySizeIncButton = Button()
    table.insert(buttonList, self.ySizeDecButton)
    table.insert(buttonList, self.ySizeIncButton)
    table.insert(buttonList, self.tileSelectorLeft)
    table.insert(buttonList, self.tileSelectorRight)
    table.insert(buttonList, self.generateLevelButton)

    self.mainButtonMatrix = ButtonMatrix(5, 2, buttonList)

end

function LevelMaker:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeState({
            r = 255, g = 255, b = 255
        },
        1, 0, 255,
        function()
            gSounds['intro-music']:stop()

            gStateStack:pop()

            gStateStack:push(FadeState({
                r = 255, g = 255, b = 255
            }, 1, 255, 0,
            function() love.event.quit() end))
        end))
    end
end

function LevelMaker:render()    
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setColor(52/255, 100/255, 235/255, 255/255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Forgotten Tales', 0, VIRTUAL_HEIGHT / 2 - 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
end