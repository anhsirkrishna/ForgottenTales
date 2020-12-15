--[[
    State when an enemy has to attack

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

EnemySpellState = Class{__includes = BaseState}

function EnemySpellState:init(enemy, camera, level, character)
    self.enemy = enemy
    self.character = character
    self.camera = camera
    self.level = level
end

function EnemySpellState:enter()
    self:attack()
end

function EnemySpellState:update(dt)
end

function EnemySpellState:render()
end

function EnemySpellState:attack()
    local spellToCast = nil
    local castableSpells = {}
    for i, spell in pairs(self.enemy.spells) do
        if spell.cost <= self.enemy.currentSpellPoints and self:inRange(spell) then
            table.insert(castableSpells, spell)
        end
    end

    if #castableSpells > 0 then
        spellToCast =  castableSpells[math.random(#castableSpells)]
    end

    if spellToCast == nil then
        self.enemy.hasUsedSpell = true
        gStateStack:pop()
    else
        self.enemy.direction = self.enemy:relativeDirection({self.character.mapX, self.character.mapY})
        gStateStack:push(FadeState({
            r = 0, g = 0, b = 0
        },
        0.5, 0, 255,
        function()
            self.enemy.hasUsedSpell = true
            gStateStack:pop()
            gStateStack:push(FadeState({
                r = 0, g = 0, b = 0
            }, 0.5, 255, 220,
            function()
                gStateStack:push(BattleState(self.enemy, self.camera, self.level, self.character, true, spellToCast))
            end))
        end))
    end
end

--Function to check if the character is in the range of the given spell
function EnemySpellState:inRange(spell)
    local range = spell.range
    dX = self.character.mapX - self.enemy.mapX
    dY = self.character.mapY - self.enemy.mapY
    local distance = math.abs(dX) + math.abs(dY)
    if distance <= range then
        return true
    else
        return false
    end
end