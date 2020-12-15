--[[
    Class to Handle the various entities in the game

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Entity = Class{}

function Entity:init(def)
    self.direction = def.direction or 'up'

    self.animations = self:createAnimations(def.animations)
    self.battleAnimations = self:createAnimations(def.battleAnimations)
    self.portraitId = def.portrait
    self.mapX = def.mapX
    self.mapY = def.mapY

    self.battleX = 0
    self.battleY = 0

    self.battleScaleX = 1
    self.battleScaleY = 1

    self.width = def.width
    self.height = def.height

    self.x = 0
    self.y = 0

    if def.scaleX then
        self.scaleX = def.scaleX
    else
        self.scaleX = 1
    end

    if def.scaleY then
        self.scaleY = def.scaleY
    else
        self.scaleY = 1
    end

    if def.battleDX then
        self.battleDX = def.battleDX
    else
        self.battleDX = 0
    end

    if def.battleDY then
        self.battleDY = def.battleDY
    else
        self.battleDY = 0
    end

    if def.dX then
        self.dX = def.dX
    else
        self.dX = 0
    end

    if def.dY then
        self.dY = def.dY
    else
        self.dY = 0
    end

    if def.retreatDX then
        self.retreatDX = def.retreatDX
    else
        self.retreatDX = 0
    end

    if def.retreatDY then
        self.retreatDY = def.retreatDY
    else
        self.retreatDY = 0
    end

    if def.tintColor then
        self.tintColor = def.tintColor
    else
        self.tintColor = {255/255, 255/255, 255/255, 255/255}
    end

    self.canMove = true
    self.hasMoved = false
    self.hasAttacked = false
    self.hasUsedSpell = false
    self.hasSummoned = false
    self.footstepSounds = true
    self.dead = false
    self.debuffs = {}
    self.inCombat = false

    self.activeSummons = {}
end

function Entity:changeState(name, enterParams)
    self.stateMachine:change(name, enterParams)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:changeBattleAnimation(name)
    self.currentBattleAnimation = self.battleAnimations[name]
end

function Entity:refreshBattleAnimations()
    for k, animation in pairs(self.battleAnimations) do
        animation:refresh()
    end
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval,
            looping = animationDef.looping,
            dX = animationDef.dX,
            dY = animationDef.dY,
            tintColor = animationDef.tintColor,
        }
    end

    return animationsReturned
end

--[[
    Called when we interact with this entity, as by pressing enter.
]]
function Entity:onInteract()

end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt, camera)
    for i, summon in pairs(self.activeSummons) do
        summon:update(dt, camera)
    end
    self.x = (self.mapX - camera.x) * TILE_SIZE
    self.y = (self.mapY - camera.y) * TILE_SIZE
    self.currentAnimation:update(dt)
    self.currentBattleAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    self.stateMachine:render()
end

function Entity:containCoords(x, y)
    if x == nil or y == nil then
        return false
    end
    if (self.x < x) and (self.x + self.width > x) and (self.y < y) and (self.y + self.height > y) then
        return true
    end
    return false
end

function Entity:moveRight()
    self.direction = "right"
    self.canMove = false
    self:changeState('walk')
    if self.footstepSounds then
        gSounds['footstep']:play()
    end
    Timer.tween(CHAR_TWEEN_DURATION, {
        [self] = {mapX = self.mapX + 1}
    }):finish(
        function()
            gSounds['footstep']:stop()
            self.canMove = true
            self:changeState('idle')
        end
    )
end

function Entity:moveLeft()
    self.direction = "left"
    self.canMove = false
    self:changeState('walk')
    if self.footstepSounds then
        gSounds['footstep']:play()
    end
    Timer.tween(CHAR_TWEEN_DURATION, {
        [self] = {mapX = self.mapX - 1}
    }):finish(
        function()
            gSounds['footstep']:stop()
            self.canMove = true
            self:changeState('idle')
        end
    )
end

function Entity:moveUp()
    self.direction = "up"
    self.canMove = false
    self:changeState('walk')
    if self.footstepSounds then
        gSounds['footstep']:play()
    end
    Timer.tween(CHAR_TWEEN_DURATION, {
        [self] = {mapY = self.mapY - 1}
    }):finish(
        function()
            gSounds['footstep']:stop()
            self.canMove = true
            self:changeState('idle')
        end
    )
end

function Entity:moveDown()
    self.direction = "down"
    self.canMove = false
    self:changeState('walk')
    if self.footstepSounds then
        gSounds['footstep']:play()
    end
    Timer.tween(CHAR_TWEEN_DURATION, {
        [self] = {mapY = self.mapY +1}
    }):finish(
        function()
            gSounds['footstep']:stop()
            self.canMove = true
            self:changeState('idle')
        end
    )
end

function Entity:move(direction)
    if direction == 'up' then
        self:moveUp()
    elseif direction == 'down' then
        self:moveDown()
    elseif direction == 'left' then
        self:moveLeft()
    elseif direction == 'right' then
        self:moveRight()
    end
end

function Entity:relativeDirection(dest)
    local destX = dest[1]
    local destY = dest[2]
    local dX = self.mapX - destX
    local dY = self.mapY - destY

    if math.abs(dX) > math.abs(dY) then
        if dX/math.abs(dX) == 1 then
            return 'left'
        else
            return 'right'
        end
    else
        if dY/math.abs(dY) == 1 then
            return 'up'
        else
            return 'down'
        end
    end
end

function Entity:refresh()
    self.hasMoved = false
    self.hasAttacked = false
    self.hasUsedSpell = false
    self.hasSummoned = false
    if #self.debuffs > 0 then
        for i, debuff in pairs(self.debuffs) do
            debuff.duration = debuff.duration - 1
            if debuff.duration == 0 then
                table.remove(self.debuffs, i)
                debuff.remove(self)
            else
                debuff.action(self)
            end
        end
    end

    for i, summon in pairs(self.activeSummons) do
        summon:refresh()
    end
end

function Entity:applyDebuff(spellEffect)
    spellEffect.apply(self)
    newDebuff = {
        duration = spellEffect.duration,
        action = spellEffect.action,
        remove = spellEffect.remove
    }
    table.insert(self.debuffs, newDebuff)
end

function Entity:getTotalMod(stat)
    local addValue = 0

    if stat == 'atk' then
        for i, mod in pairs(self.atkMod) do
            addValue = addValue + mod
        end
    elseif stat == 'def' then
        for i, mod in pairs(self.defMod) do
            addValue = addValue + mod
        end
    elseif stat == 'spell' then
        for i, mod in pairs(self.spellMod) do
            addValue = addValue + mod
        end
    elseif stat == 'res' then
        for i, mod in pairs(self.resMod) do
            addValue = addValue + mod
        end
    elseif stat == 'hp' then
        for i, mod in pairs(self.hpMod) do
            addValue = addValue + mod
        end
    elseif stat == 'sp' then
        for i, mod in pairs(self.spMod) do
            addValue = addValue + mod
        end
    elseif stat == 'atkRange' then
        for i, mod in pairs(self.atkRangeMod) do
            addValue = addValue + mod
        end
    elseif stat == 'move' then
        for i, mod in pairs(self.moveSpeedMod) do
            addValue = addValue + mod
        end
    end

    return addValue
end

function Entity:inAtkRange(coords)
    local distance = math.abs(coords[1] - self.mapX) + math.abs(coords[2] - self.mapY)
    if distance <= self.atkRange then
        return true
    end
    return false
end

function Entity:enterCombat()
end