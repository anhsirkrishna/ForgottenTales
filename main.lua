--[[
    Forgotten Tales
    RPG Game

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]--

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Forgotten Tales')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
    love.mouse.mousePressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'd' then
        DEBUG = true
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, button)
    gameX, gameY = push:toGame(x, y)
    
    love.mouse.mousePressed[button] = {gameX, gameY}
end

function love.mouse.wasPressed(button)
    return love.mouse.mousePressed[button]
end

function love.update(dt)
    love.mouse.mouseX, love.mouse.mouseY = push:toGame(
        love.mouse.getX(), love.mouse.getY())

    if love.mouse.mouseX == nil then
        love.mouse.mouseX = 0
    end

    if love.mouse.mouseY == nil then
        love.mouse.mouseY = 0
    end
    
    love.mouse.gridX = math.floor(love.mouse.mouseX / TILE_SIZE)
    love.mouse.gridY = math.floor(love.mouse.mouseY / TILE_SIZE)

    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.mousePressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end