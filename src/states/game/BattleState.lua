--[[
    Battle state

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

BattleState = Class{__includes = BaseState}

function BattleState:init(character, camera, level, enemy, auto, spell, interruptable)
    self.character = character
    self.level = level
    self.camera = camera
    self.enemy = enemy
    self.character.currentRoll = nil
    self.hasAttacked = false
    self.popped = false
    self.spell = spell or nil
    local spellStats = false
    self.battleTerrain = BattleTerrain(1)
    if auto == nil then
        self.auto = false
    else
        self.auto = auto
    end

    self.rollButton = Button(VIRTUAL_WIDTH/2-16, 32, 'wide', "Roll!", 
                                function()
                                    gStateStack:push(RollState(self.character, self.camera, self.level))
                                end)    
    
    if self.spell ~= nil then
        spellStats = true
        self.currentSequence = 'spellattack'
    else
        self.currentSequence = 'run'
    end
    self.battleDisplayLeft = BattleDisplay(self.character, 'left', true, spellStats)
    self.battleDisplayRight = BattleDisplay(self.enemy, 'right', false, spellStats)
    self.displayDmgStr = nil
    self.displayDmgCoords = {}
    self.finishedAttacking = false
end

function BattleState:enter()
    self.character:refreshBattleAnimations()
    self.enemy:refreshBattleAnimations()
    self.character:changeState('battle', 
    {
        ['stance'] = "attacker"
    })
    self.enemy:changeState('battle', 
    {
        ['stance'] = "defender"
    })
    gMusic['explore-music']:pause()
    gMusic['battle-music']:pause()
    if not gMusic['boss-music']:isPlaying() then
        gMusic['fight-music']:play()
    end
    if self.auto then
        gStateStack:push(RollState(self.character, self.camera, self.level))
    end
end

function BattleState:update(dt)
    if self.finishedAttacking then
        if self.character.currentBattleAnimation.timesPlayed > 0 then
            if not self.popped then
                self.popped = true
                Timer.after(1,
                    function()
                        if gMusic['fight-music']:isPlaying() then
                            gMusic['fight-music']:stop()
                            gMusic['battle-music']:play()
                        end
                        gStateStack:push(FadeState({
                            r = 255, g = 255, b = 255
                        },
                        0.5, 0, 255,
                        function()
                            gStateStack:pop()
                            self.character:changeState('idle')
                            if self.enemy.dead then
                                if self.enemy.deathDialogue then
                                    gStateStack:push(DialogueState(self.level, self.character, self.enemy.deathDialogue))
                                end
                                self.enemy:changeState('death')
                            else
                                self.enemy:changeState('idle')
                            end
                            gStateStack:push(FadeState({
                                r = 255, g = 255, b = 255
                            }, 0.5, 255, 0,
                            function() end))
                        end))
                    end)
            end
        end
    else
        if not self.auto then
            self.rollButton:update(dt)
        end
    end

    if self.character.currentRoll ~= nil and not self.finishedAttacking then
        if self.spell then
            self:spellSequence()
        else
            self:attackSequence()
        end
    end

    self.character:update(dt, self.camera)
    self.enemy:update(dt, self.camera)
    self.battleTerrain:update(dt)
    self.battleDisplayLeft:update(dt)
    self.battleDisplayRight:update(dt)
end

function BattleState:render()
    self.battleTerrain:render()
    if not self.auto then
        self.rollButton:render()
    end
    self.battleDisplayLeft:render()
    self.battleDisplayRight:render()
    self.enemy:render()
    self.character:render()
    if self.displayDmgStr then
        love.graphics.setFont(gFonts['smallMain'])
        if self.character.currentRoll == 20 then
            love.graphics.setColor(191/255, 70/255, 0/255, 255/255)
        else
            love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        end
        love.graphics.printf(self.displayDmgStr, self.displayDmgCoords.x, self.displayDmgCoords.y, 78, 'center')
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end
end

function BattleState:getAttackDmg()
    if self.character.currentRoll == 20 then
        return 2*self.character.weapon.dmg
    end

    if (self.character.currentRoll + self.character.atk + self.character:getTotalMod('atk')) - (self.enemy.def + self.enemy:getTotalMod('def')) >= 10 then
        return self.character.weapon.dmg
    else
        return 0
    end
end

function BattleState:getSpellDmg()
    if self.character.currentRoll == 20 then
        return 2*self.spell.dmg
    end

    if (self.character.currentRoll + self.character.spell + self.character:getTotalMod('spell')) - (self.enemy.res + self.enemy:getTotalMod('res')) >= 10 then
        return self.spell.dmg
    else
        return 0
    end
end

function BattleState:attackSequence()
    local animationTimeAtk = 0
    local animationTimeJump = 0
    if self.currentSequence == 'run' and not self.engaged then
        self.engaged = true
        self.character:battleRun(
            function()
                self.currentSequence = 'attack'
                self.engaged = false
            end
        )
    end

    if self.currentSequence == 'attack' and not self.engaged then
        self.engaged = true
        dmgDealt = self:getAttackDmg()

        if dmgDealt > 0 then
            if self.enemy.currentHp - dmgDealt <= 0 then
                nextSequence = 'death'
            else
                nextSequence = 'hit'
            end
        else
            nextSequence = 'dodge'
        end
        self.character:battleAttack(
            function()
                self.engaged = false
                self.currentSequence = nextSequence
            end
        )
    end

    if self.currentSequence == 'dodge' and not self.engaged then
        self.engaged = true
        dmgDealt = self:getAttackDmg()
        self:displayDmg(dmgDealt)
        self.enemy:battleDodge(
            function()
                self.engaged = false
                self.currentSequence = 'retreat'
                self.enemy:changeBattleAnimation('idle')
            end
        )
    end

    if self.currentSequence == "hit" and not self.engaged then
        self.engaged = true
        dmgDealt = self:getAttackDmg()
        self:displayDmg(dmgDealt)
        self.enemy:battleHit(dmgDealt,
            function()
                self.engaged = false
                self.currentSequence = 'retreat'
                self.enemy:changeBattleAnimation('idle')
            end
        )
    end

    if self.currentSequence == "death" and not self.engaged then
        self.engaged = true
        dmgDealt = self:getAttackDmg()
        self:displayDmg(dmgDealt)
        self.enemy:battleDeath(dmgDealt,
            function()
                self.engaged = false
                self.currentSequence = 'retreat'
            end
        )
    end

    if self.currentSequence == 'retreat' and not self.engaged then
        self.engaged = true
        self.character:battleRetreat(
            function()
                self.engaged = false
                self.currentSequence = nil
                self.finishedAttacking = true
                self.character:changeBattleAnimation('idle')
            end
        )
    end
end

function BattleState:spellSequence()
    local animationTimeAtk = 0
    local animationTimeJump = 0

    if self.currentSequence == 'spellattack' and not self.engaged then
        self.engaged = true
        dmgDealt = self:getSpellDmg()

        if dmgDealt > 0 then
            if self.enemy.currentHp - dmgDealt <= 0 then
                nextSequence = 'death'
            else
                nextSequence = 'hit'
            end
        else
            nextSequence = 'dodge'
        end
        self.character:battleSpellAttack(
            self.spell,
            function()
                self.engaged = false
                self.currentSequence = nextSequence
            end
        )
    end

    if self.currentSequence == 'dodge' and not self.engaged then
        self.engaged = true
        dmgDealt = self:getSpellDmg()
        self:displayDmg(dmgDealt)
        self.enemy:battleDodge(
            function()
                self.engaged = false
                self.currentSequence = nil
                self.finishedAttacking = true
                self.enemy:changeBattleAnimation('idle')
            end
        )
    end

    if self.currentSequence == "hit" and not self.engaged then
        self.engaged = true
        dmgDealt = self:getSpellDmg()
        self:displayDmg(dmgDealt)
        self.enemy:applyDebuff(self.spell.effect)
        self.enemy:battleHit(dmgDealt,
            function()
                self.engaged = false
                self.currentSequence = nil
                self.finishedAttacking = true
                self.enemy:changeBattleAnimation('idle')
            end
        )
    end

    if self.currentSequence == "death" and not self.engaged then
        self.engaged = true
        dmgDealt = self:getSpellDmg()
        self:displayDmg(dmgDealt)
        self.enemy:battleDeath(dmgDealt,
            function()
                self.engaged = false
                self.currentSequence = nil
                self.finishedAttacking = true
            end
        )
    end

end

function BattleState:displayDmg(dmg)
    if dmg == 0 then
        if self.spell then
            self.displayDmgStr = "RESIST"
        else    
            self.displayDmgStr = "MISS"
        end
    else
        self.displayDmgStr = tostring(dmg)
    end
    self.displayDmgCoords = {
        x = self.enemy.battleX,
        y = self.enemy.battleY
    }
    Timer.tween(1, {
        [self.displayDmgCoords] = {
            x = self.enemy.battleX + 8,
            y = self.enemy.battleY - 16
        }
    }):finish(
        function()
            self.displayDmgStr = nil
        end
    )
end