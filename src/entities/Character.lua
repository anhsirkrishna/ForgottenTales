--[[
    Class for handling Characters

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

Character = Class{__includes = Entity}

function Character:init(def)
    self.name = def.name
    def.animations = ENTITY_DEFS[self.name].animations
    def.battleAnimations = ENTITY_DEFS[self.name].battleAnimations
    def.portrait = ENTITY_DEFS[self.name].portrait
    Entity.init(self, def)

    self.charClass = def.charClass
    charClassDef = CHAR_CLASS_DEFS[self.charClass]
    self.baseHp = charClassDef.baseHp
    self.spellPoints = charClassDef.spellPoints
    self.baseMoveSpeed = charClassDef.baseMoveSpeed
    self.atk = charClassDef.atk
    self.spell = charClassDef.spell
    self.def = charClassDef.def
    self.res = charClassDef.res
    self.atkRange = charClassDef.atkRange
    self.spells = {}
    local newSpell = {}
    for i, spell in pairs(charClassDef.spells) do
        newSpell = SPELL_DEFS[spell]
        newSpell.animation = Animation(newSpell.animation)
        table.insert(self.spells, newSpell)
    end
    self.currentRoll = nil

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
    self.weapon = WEAPON_DEFS[charClassDef.defaultWeapon]
    self.armour = nil
    self.inventory = {POTION_DEFS['hpPotion']}

    self.displayedSpell = nil
    self.debuffs = {}
    self.stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self) end,
        ['idle'] = function() return EntityIdleState(self) end,
        ['battle'] = function() return EntityBattleState(self) end
    }
    self.stateMachine:change('idle')
    self:changeBattleAnimation('idle')
end

function Character:update(dt, camera)
    Entity.update(self, dt, camera)

    if self.displayedSpell then
        self.displayedSpell.animation:update(dt)
    end

end

function Character:render()
    Entity.render(self)

    if self.displayedSpell then
        love.graphics.draw(gTextures['spells'][self.displayedSpell.name], 
                           gFrames['spells'][self.displayedSpell.name][self.displayedSpell.animation:getCurrentFrame()],
                           self.displayedSpell.x, self.displayedSpell.y, 0, self.displayedSpell.scaleX, self.displayedSpell.scaleY)
    end
end

function Character:battleRun(onFinish)
    if self.currentRoll == 20 then
        onFinish()
        return
    end
    gSounds['footstep-grass']:play()
    self:changeBattleAnimation('run')
        Timer.tween(1 ,{
            [self] = {battleX = self.battleX + (4 * TILE_SIZE)}
        }):finish(
            function()
                gSounds['footstep-grass']:stop()
                onFinish()
            end
        )
end

function Character:battleAttack(onFinish)
    local animationTime = 0
    if self.currentRoll == 20 then
        self:changeBattleAnimation('critical')
        Timer.after(0.5,
            function()
                Timer.tween(1 ,{
                    [self] = {battleX = self.battleX + (4 * TILE_SIZE)}
                }):finish(
                    function()
                        self:playAttackSounds()
                    end
                )
            end
        )
    else
        self:changeBattleAnimation('attack')
        self:playAttackSounds()
    end
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Character:battleSpellAttack(spell, onFinish)
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

function Character:battleRetreat(onFinish)
    local animationTime = 0
    self.battleScaleX = self.battleScaleX * -1
    self.battleDX = self.battleDX + 50
    self:changeBattleAnimation('retreat')
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime ,{
        [self] = {battleX = self.battleX - (4 * TILE_SIZE)},
    }):finish(
        function()
            self.battleDX = self.battleDX - 50
            self.battleScaleX = self.battleScaleX * -1
            onFinish()
        end
    )
end

function Character:battleHit(dmg, onFinish)
    self:changeBattleAnimation('hit')
    gSounds['hit']:play()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime, {
        [self] = {currentHp = math.max(self.currentHp - dmg, 0)}
    }):finish(
        onFinish
    )
end

function Character:battleDodge(onFinish)
    self:changeBattleAnimation('dodge')
    gSounds['miss']:play()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.after(animationTime,
        onFinish
    )
end

function Character:battleDeath(dmg, onFinish)
    self:changeBattleAnimation('death')
    gSounds['hit']:play()
    animationTime = (#self.currentBattleAnimation.frames + 1) * self.currentBattleAnimation.interval
    Timer.tween(animationTime, {
        [self] = {currentHp = math.max(self.currentHp - dmg, 0)}
    }):finish(
        function()
            self.dead = true
            Timer.after(1,
                    function()
                        gStateStack:push(FadeState({
                                         r = 0, g = 0, b = 0},
                                         2, 0, 255,
                                         function()
                                            gStateStack:push(GameOverState())
                                         end)
                                        )
                    end
            )
        end
    )
end

function Character:removeItem(itemName)
    local newInventory = {}
    local removed = false
    for i, item in pairs(self.inventory) do
        if item.name == itemName and not removed then
            removed = true
        else
            table.insert(newInventory, item)
        end
    end
    self.inventory = newInventory
end

function Character:equipWeapon(weaponName)
    gSounds['equip']:play()
    self:removeItem(weaponName)
    self:unequipWeapon()
    self.weapon = WEAPON_DEFS[weaponName]
    if self.weapon.specialProperties then
        self.weapon.specialProperties.add(self)
    end
end

function Character:equipArmour(armourName)
    gSounds['equip']:play()
    self:removeItem(armourName)
    self:unequipArmour()
    self.armour = ARMOUR_DEFS[armourName]
    self.baseHp = self.baseHp + self.armour.hpAdd
    if self.armour.specialProperties then
        self.armour.specialProperties.add(self)
    end
end

function Character:unequipWeapon()
    if self.weapon == nil then
        return
    end
    local oldWeapon = self.weapon
    if self.weapon.specialProperties then
        self.weapon.specialProperties.remove(self)
    end
    table.insert(self.inventory, oldWeapon)
end

function Character:unequipArmour()
    if self.armour == nil then
        return
    end
    local oldArmour = self.armour
    if self.armour.specialProperties then
        self.armour.specialProperties.remove(self)
    end
    self.baseHp = self.baseHp - oldArmour.hpAdd
    table.insert(self.inventory, oldArmour)
end

function Character:playAttackSounds()
    gSounds['swing1']:play()
        Timer.after(0.5,
            function()
                gSounds['swing1']:stop()
                gSounds['swing1']:play()
                Timer.after(0.5,
                    function()
                        gSounds['swing1']:stop()
                        gSounds['swing2']:play()
                    end
                )
            end
        )
end
