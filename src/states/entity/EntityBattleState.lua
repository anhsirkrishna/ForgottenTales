--[[
    Class to deal with entity behaviour in battles

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

EntityBattleState = Class{__includes = EntityBaseState}

function EntityBattleState:init(entity)
    self.entity = entity
end

function EntityBattleState:enter(def) 
    self.entity:changeBattleAnimation('idle')
    self.stance = def.stance
    if def.stance == 'attacker' then
        self.entity.battleX = 2 * TILE_SIZE
        self.entity.battleY = 4 * TILE_SIZE
        self.entity.battleScaleX = 1
        self.entity.battleScaleY = 1
    else
        self.entity.battleX = 8 * TILE_SIZE
        self.entity.battleY = 4 * TILE_SIZE
        self.entity.battleScaleX = -1
        self.entity.battleScaleY = 1
        self.entity.battleDX = self.entity.battleDX * -1
    end
end

function EntityBattleState:update(dt) 
end

function EntityBattleState:exit()
    if self.stance == 'defender' then
        self.entity.battleDX = self.entity.battleDX * -1
    end
end

function EntityBattleState:render()
    local anim = self.entity.currentBattleAnimation
    love.graphics.push()
    love.graphics.translate(self.entity.battleDX + anim.dX, self.entity.battleDY + anim.dY)
    love.graphics.setColor(self.entity.tintColor)
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.battleX), math.floor(self.entity.battleY), 0, 
        self.entity.battleScaleX, self.entity.battleScaleY)
    love.graphics.pop()
end