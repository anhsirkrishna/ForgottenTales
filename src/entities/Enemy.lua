--[[
    Class for handling enemy haracters

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Enemy = Class{__includes = Entity}

function Enemy:init(def)
    self.name = def.name
    self.entity = def.entity
    def.animations = ENTITY_DEFS[self.entity].animations
    def.battleAnimations = ENTITY_DEFS[self.entity].battleAnimations
    if ENTITY_DEFS[self.entity].scaleX then
        def.scaleX = ENTITY_DEFS[self.entity].scaleX
    end
    if ENTITY_DEFS[self.entity].scaleY then
        def.scaleY = ENTITY_DEFS[self.entity].scaleY
    end
    def.portrait = ENTITY_DEFS[self.entity].portrait

    if ENTITY_DEFS[self.entity].battleDX then
        def.battleDX = ENTITY_DEFS[self.entity].battleDX
    end
    if ENTITY_DEFS[self.entity].battleDY then
        def.battleDY = ENTITY_DEFS[self.entity].battleDY
    end

    if ENTITY_DEFS[self.entity].dX then
        def.dX = ENTITY_DEFS[self.entity].dX
    end
    if ENTITY_DEFS[self.entity].dY then
        def.dY = ENTITY_DEFS[self.entity].dY
    end

    if ENTITY_DEFS[self.entity].retreatDX then
        def.retreatDX = ENTITY_DEFS[self.entity].retreatDX
    end
    if ENTITY_DEFS[self.entity].retreatDY then
        def.retreatDY = ENTITY_DEFS[self.entity].retreatDY
    end
    
    if ENTITY_DEFS[self.entity].battleRunDistance then
        self.battleRunDistance = ENTITY_DEFS[self.entity].battleRunDistance
    else
        self.battleRunDistance = 4
    end

    def.tintColor = ENTITY_DEFS[self.entity].tintColor
    Entity.init(self, def)

    if ENTITY_DEFS[self.entity].footstepSounds ~= nil then
        self.footstepSounds = ENTITY_DEFS[self.entity].footstepSounds
    else
        self.footstepSounds = true
    end

    self.enemyClass = def.enemyClass
    enemyClassDef = ENEMY_CLASS_DEFS[self.enemyClass]
    self.baseHp = enemyClassDef.baseHp
    self.spellPoints = enemyClassDef.spellPoints
    self.baseMoveSpeed = enemyClassDef.baseMoveSpeed
    self.atk = enemyClassDef.atk
    self.spell = enemyClassDef.spell
    self.def = enemyClassDef.def
    self.res = enemyClassDef.res
    self.atkRange = enemyClassDef.atkRange
    self.summons = enemyClassDef.summons
    
    self.hpMod = {}
    self.spMod = {}
    self.atkMod = {}
    self.spellMod = {}
    self.defMod = {}
    self.resMod = {}
    self.atkRangeMod = {}
    self.moveSpeedMod = {}

    self.currentHp = self.baseHp
    self.currentSpellPoints = self.spellPoints
    self.weapon = WEAPON_DEFS[enemyClassDef.defaultWeapon]

    if self.weapon.specialProperties then
        self.weapon.specialProperties.add(self)
    end

    self.attackable = true
    self.interactable = false
    self.spells = {}
    local newSpell = {}
    for i, spell in pairs(enemyClassDef.spells) do
        newSpell = SPELL_DEFS[spell]
        newSpell.animation = Animation(newSpell.animation)
        table.insert(self.spells, newSpell)
    end

    if self.summons == nil then
        self.summons = {}
    end

    self.loot = def.loot

    self.combatDialogue = def.combatDialogue or nil
    self.deathDialogue = def.deathDialogue or nil

    self.lootAnimation = false
    self.lootAnimationY = nil
    self.stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self) end,
        ['idle'] = function() return EntityIdleState(self) end,
        ['battle'] = function() return EntityBattleState(self) end,
        ['death'] = function() return EntityDeathState(self) end
    }
    self.direction = "down"
    self.stateMachine:change('idle')
    self:changeBattleAnimation('idle')
end

function Enemy:update(dt, camera)
    Entity.update(self, dt, camera)

    if self.displayedSpell then
        self.displayedSpell.animation:update(dt)
    end
end


function Enemy:render()
    Entity.render(self)
    if self.lootAnimation then
        love.graphics.draw(gTextures['icons'], gFrames['icons'][self.loot.icon], self.x, self.lootAnimationY)
    end

    if self.displayedSpell then
        love.graphics.draw(gTextures['spells'][self.displayedSpell.name], 
                           gFrames['spells'][self.displayedSpell.name][self.displayedSpell.animation:getCurrentFrame()],
                           self.displayedSpell.x, self.displayedSpell.y, 0, self.displayedSpell.scaleX, self.displayedSpell.scaleY)
    end
end

function Enemy:battleRun(onFinish)
    if self.currentRoll == 20 then
        onFinish()
        return
    end
    if self.footstepSounds then
        gSounds['footstep-grass']:play()
    end
    self:changeBattleAnimation('run')
        Timer.tween(1 ,{
            [self] = {battleX = self.battleX + (self.battleRunDistance * TILE_SIZE)}
        }):finish(
            function()
                gSounds['footstep-grass']:stop()
                onFinish()
            end
        )
end

function Enemy:battleAttack(onFinish)
    local animationTime = 0
    if self.currentRoll == 20 then
        self:changeBattleAnimation('critical')
        Timer.after(0.5,
            function()
                Timer.tween(1 ,{
                    [self] = {battleX = self.battleX + (4 * TILE_SIZE)}
                }):finish(
                    function()
                        gSounds['swing2']:play()
                    end
                )
            end
        )
    else
        self:changeBattleAnimation('attack')
        gSounds['swing2']:play()
    end
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Enemy:battleRetreat(onFinish)
    local animationTime = 0
    self.battleScaleX = self.battleScaleX * -1
    self.battleDX = self.battleDX + self.retreatDX
    self:changeBattleAnimation('retreat')
    if self.footstepSounds then
        gSounds['footstep-grass']:play()
    end
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime ,{
        [self] = {battleX = self.battleX - (4 * TILE_SIZE)},
    }):finish(
        function()
            self.battleDX = self.battleDX - self.retreatDX
            self.battleScaleX = self.battleScaleX * -1
            gSounds['footstep-grass']:stop()
            onFinish()
        end
    )
end

function Enemy:battleHit(dmg, onFinish)
    self:changeBattleAnimation('hit')
    gSounds['hit']:play()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime, {
        [self] = {currentHp = math.max(self.currentHp - dmg, 0)}
    }):finish(
        onFinish
    )
end

function Enemy:battleDodge(onFinish)
    self:changeBattleAnimation('dodge')
    gSounds['miss']:play()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Enemy:battleDeath(dmg, onFinish)
    self:changeBattleAnimation('death')
    gSounds['hit']:play()
    self:die()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime, {
        [self] = {currentHp = math.max(self.currentHp - dmg, 0)}
    }):finish(
        onFinish
    )
end

function Enemy:battleSpellAttack(spell, onFinish)
    local animationTime = 0
    self:changeBattleAnimation('spell')
    gSounds['spells'][spell.name]:play()
    self.currentSpellPoints = self.currentSpellPoints - spell.cost
    animationTime = 3 * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        function()
            self.displayedSpell = spell
            self.displayedSpell.x = spell.startX
            self.displayedSpell.y = spell.startY
            self.displayedSpell.scaleX = spell.scaleX
            self.displayedSpell.scaleY = spell.scaleY
            spellAnimationTime = (#self.displayedSpell.animation.frames + 1) * self.displayedSpell.animation.interval
            Timer.after(spellAnimationTime, 
                function()
                    self.displayedSpell.animation:refresh()
                    self.displayedSpell = nil
                    onFinish()
                end
            )
        end
    )
end

function Enemy:battleSummon(onFinish)
    local animationTime = 0
    self:changeBattleAnimation('summon')
    gSounds['summon']:play()
    animationTime = 3 * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Enemy:battleAppear(onFinish)
    local animationTime = 0
    self:changeBattleAnimation('appear')
    animationTime = #self.currentBattleAnimation.frames * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Enemy:getPathToChar(character, level)
    return GetPath(self.mapX, self.mapY, character.mapX, character.mapY, true, level)
end

function Enemy:getSurroundingEnemies(level)
    local surroundingList = {}
    for i, enemy in pairs(level.enemyList) do
        if enemy.mapX < self.mapX+5 and 
            enemy.mapX > self.mapX-5 and 
            enemy.mapY < self.mapY+5 and 
            enemy.mapY > self.mapY-5 then
        table.insert(surroundingList, enemy)
        end
    end
    return surroundingList
end

function Enemy:die()
    self.dead = true
    self.attackable = false
    self.interactable = true
    for i, summon in pairs(self.activeSummons) do
        summon:die()
    end
end

function Enemy:interact(character)
    if self.loot then
        gSounds['pickup']:play()
        self.lootAnimation = true
        self.lootAnimationY = self.y + 16
        table.insert(character.inventory, self.loot)
        Timer.tween(0.5, {
            [self] = {lootAnimationY = self.lootAnimationY - 32}
        }):finish(
            function()
                self.lootAnimation = false
                self.loot = nil
            end
        )
    end

    self.interactable = false
end
