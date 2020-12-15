--[[
    Class for the d20 roller

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

d20Roller = Class{}

function d20Roller:init(roll)
    self.animation = Animation {
        texture = 'd20Roll',
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
        interval = 0.2,
        looping = false
    }
    self.roll = roll
    self.x = 0
    self.y = 0
    self.scaleX = 1
    self.scaleY = 1
    self.text = nil
    self.textXoffset = 0
    self.textYoffset = 0
    self.height = nil
    self.width = nil
    self.visible = true
    self.rectY = 0
    Timer.tween(1,
        {[self] = {rectY = VIRTUAL_HEIGHT/3} }
    )
end

function d20Roller:update(dt)
    self.animation:update(dt)
end

function d20Roller:render()
    if self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        love.graphics.rectangle('fill',self.x, self.rectY, VIRTUAL_WIDTH, VIRTUAL_HEIGHT/3)
        love.graphics.draw(gTextures["d20Roll"][self.roll],gFrames["d20Roll"][self.roll][self.animation:getCurrentFrame()],
            self.x, self.y, 0, self.scaleX, self.scaleY)

        if self.text then
            love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
            love.graphics.setFont(gFonts['smallName'])
            love.graphics.printf(self.text,  self.x + self.textXoffset, self.y + self.textYoffset, self.width - 4, 'center')
        end
    end
end

function d20Roller:toggle()
    self.visible = not self.visible
end
