--[[
    State when an enemy is summoning a creature

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

EnemySummonState = Class{__includes = BaseState}

function EnemySummonState:init(enemy, camera, level)
    self.enemy = enemy
    self.camera = camera
    self.level = level
end

function EnemySummonState:enter()
    self:summon()
end

function EnemySummonState:update(dt)
end

function EnemySummonState:render()
end

function EnemySummonState:summon()
    local summonToCast = nil
    local castableSummons = {}
    for i, summon in pairs(self.enemy.summons) do
        if summon.cost <= self.enemy.currentSpellPoints then
            table.insert(castableSummons, summon)
        end
    end

    if #castableSummons > 0 then
        summonToCast =  castableSummons[math.random(#castableSummons)]
    else
        self.enemy.hasSummoned = true
        gStateStack:pop()
        return
    end

    self.enemy.direction = 'down'
    newSummon = self:newSummon(summonToCast)
    self.enemy.currentSpellPoints = math.max(self.enemy.currentSpellPoints - summonToCast.cost, 0)
    gStateStack:push(FadeState({
        r = 0, g = 0, b = 0
    },
    0.5, 0, 255,
    function()
        self.enemy.hasAttacked = true
        self.enemy.hasSummoned = true
        gStateStack:pop()
        gStateStack:push(FadeState({
            r = 0, g = 0, b = 0
        }, 0.5, 255, 220,
        function()
            gStateStack:push(SummonState(self.enemy, self.camera, self.level, newSummon, true))
        end))
    end))
end

function EnemySummonState:newSummon(summon)
    local dX = {0, -1, 1, 0}
    local dY = {1, 0, 0, -1}
    local summonCoords = {nil, nil}
    for i=1, 4, 1 do
        summonCoords[1] = self.enemy.mapX + dX[i]
        summonCoords[2] = self.enemy.mapY + dY[i] 
        if self.level.entityLayer[summonCoords[2]][summonCoords[1]] == nil and self.level.topLayer[summonCoords[2]][summonCoords[1]] == EMPTY_SPACE then
            break
        end
        if i == 4 then
            return nil
        end
    end

    newSummon = Enemy({
            mapX = summonCoords[1],
            mapY = summonCoords[2],
            width = 32,
            height = 32,
            enemyClass = summon.class,
            name = summon.name,
            entity = summon.entity,
            loot = summon.loot,
        })
    self.level.entityLayer[summonCoords[2]][summonCoords[1]] = newSummon
    return newSummon
end