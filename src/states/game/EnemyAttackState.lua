--[[
    State when an enemy has to attack

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

EnemyAttackState = Class{__includes = BaseState}

function EnemyAttackState:init(enemy, camera, level, character)
    self.enemy = enemy
    self.character = character
    self.camera = camera
    self.level = level
end

function EnemyAttackState:enter()
    self:attack()
end

function EnemyAttackState:update(dt)
end

function EnemyAttackState:render()
end

function EnemyAttackState:attack()
    local dX = {1, -1, 0, 0}
    local dY = {0, 0, 1, -1}
    atkCoords = nil
    if self.enemy:inAtkRange({self.character.mapX, self.character.mapY}) then
        atkCoords = {self.character.mapX, self.character.mapY}
    end

    if atkCoords == nil then
        self.enemy.hasAttacked = true
        gStateStack:pop()
    else
        self.enemy.direction = self.enemy:relativeDirection(atkCoords)
        gStateStack:push(FadeState({
            r = 0, g = 0, b = 0
        },
        0.5, 0, 255,
        function()
            self.enemy.hasAttacked = true
            gStateStack:pop()
            gStateStack:push(FadeState({
                r = 0, g = 0, b = 0
            }, 0.5, 255, 220,
            function()
                gStateStack:push(BattleState(self.enemy, self.camera, self.level, self.character, true))
            end))
        end))
    end
end