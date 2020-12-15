--[[
    Start state for Forgotten Tales

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gMusic['intro-music']:play()

end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeState({
            r = 255, g = 255, b = 255
        },
        1, 0, 255,
        function()
            gMusic['intro-music']:stop()

            gStateStack:pop()

            gStateStack:push(FadeState({
                r = 255, g = 255, b = 255
            }, 1, 255, 0,
            function() 
                gStateStack:push(PlayState(1))
            end))
        end))
    end
end

function StartState:render()    
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setColor(52/255, 100/255, 235/255, 255/255)
    love.graphics.setFont(gFonts['largeFancy'])
    love.graphics.printf('Forgotten Tales', 0, VIRTUAL_HEIGHT / 2 - 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['mediumFancy'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['smallFancy'])
end