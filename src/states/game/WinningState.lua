--[[
    State for beating Forgotten Tales 

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

WinningState = Class{__includes = BaseState}

function WinningState:init()
end

function WinningState:enter()
    gMusic['battle-music']:stop()
    gMusic['fight-music']:stop()
    gMusic['explore-music']:stop()
    gMusic['boss-music']:stop()
    gMusic['win-music']:play()
end

function WinningState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:clear()
        gMusic['win-music']:stop()
        gStateStack:push(StartState())
    end
end

function WinningState:render()    
    love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(235/255, 210/255, 52/255, 255/255)
    love.graphics.setFont(gFonts['largeFancy'])
    love.graphics.printf('You Win !', 0, VIRTUAL_HEIGHT / 2 - 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['mediumFancy'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['smallFancy'])
end