--[[
    Game Over state for Forgotten Tales

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:enter()
    gMusic['battle-music']:stop()
    gMusic['fight-music']:stop()
    gMusic['explore-music']:stop()
    gMusic['boss-music']:stop()
    gMusic['gameOver-music']:play()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:clear()
        gMusic['gameOver-music']:stop()
        gStateStack:push(StartState())
    end
end

function GameOverState:render()    
    love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(191/255, 0/255, 32/255, 255/255)
    love.graphics.setFont(gFonts['largeFancy'])
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['mediumFancy'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['smallFancy'])
end