--[[
    Health Bar

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

HealthBar = Class{}

function HealthBar:init(x, y, character, scaleX, scaleY, spell)
    self.x = x
    self.y = y
    self.character = character
    self.spell = spell
    if self.spell then
        self.totalHp = character.spellPoints
        self.currentHp = character.currentSpellPoints
        self.texture = 'spellBar'
    else
        self.totalHp = character.baseHp
        self.currentHp = character.currentHp
        self.texture = 'healthBar'
    end
    self.scaleX = scaleX
    self.scaleY = scaleY
    self.animation = Animation({
        frames = {0, 8},
        interval = 0.5,
        texture = self.texture
    })
end

function HealthBar:update(dt)
    if self.spell then
        self.totalHp = self.character.spellPoints
        self.currentHp = math.floor(self.character.currentSpellPoints)
    else
        self.totalHp = self.character.baseHp
        self.currentHp = math.floor(self.character.currentHp)
    end
    self.animation:update(dt)
end

function HealthBar:render()
    local yOffset = 0
    local xOffset = 0
    for i=1, self.currentHp, 1 do
        if i == 16 then
            yOffset = 10
            xOffset = 0
        elseif i == 31 then 
            yOffset = 20
            xOffset = 0
        end
        --1 + (xOffset/8) + self.animation:getCurrentFrame()
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][(i%8) + 1 + self.animation:getCurrentFrame()], 
                           self.x + xOffset, self.y + yOffset, 0 , self.scaleX, self.scaleY)
        xOffset = xOffset + 9
    end

    for i=self.currentHp+1, self.totalHp, 1 do
        if i == 16 then
            yOffset = 10
            xOffset = 0
        elseif i == 31 then 
            yOffset = 20
            xOffset = 0
        end
        --1 + (xOffset/8) + self.animation:getCurrentFrame()
        love.graphics.draw(gTextures['healthBar'], gFrames['healthBar'][0], 
                           self.x + xOffset, self.y + yOffset, 0 , self.scaleX, self.scaleY)
        xOffset = xOffset + 9
    end
end

function HealthBar:toggle()
    self.visible = not self.visible
end