--[[
    Camera object 

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Camera = Class{}

function Camera:init(maxX, maxY, x, y, speed)
    self.maxX = maxX
    self.maxY = maxY
    self.x = x or 1
    self.y = y or 1
    self.speed = speed or 1
end

function Camera:update(dt)
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        self:moveLeft()
    end

    if love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        self:moveRight()
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        self:moveUp()
    end

    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        self:moveDown()
    end

end

function Camera:moveLeft()
    self.x = math.max((self.x - self.speed), 1)
end

function Camera:moveRight()
    self.x = math.min((self.x + self.speed), self.maxX - SCREEN_TILE_WIDTH + 1)
end

function Camera:moveUp()
    self.y = math.max((self.y - self.speed), 1)
end

function Camera:moveDown()
    self.y = math.min((self.y + self.speed), self.maxY - SCREEN_TILE_HEIGHT + 1)
end