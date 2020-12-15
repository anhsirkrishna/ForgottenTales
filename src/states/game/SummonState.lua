--[[
    Battle state

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

SummonState = Class{__includes = BaseState}

function SummonState:init(character, camera, level, summon)
    self.character = character
    self.level = level
    self.camera = camera
    self.summon = summon
    self.character.currentRoll = nil
    self.hasAttacked = false
    self.popped = false
    self.spell = spell or nil
    local spellStats = false
    self.battleTerrain = BattleTerrain(1)

    self.currentSequence = 'summon'

    self.battleDisplayLeft = BattleDisplay(self.character, 'left', true, spellStats)
    self.battleDisplayRight = BattleDisplay(self.summon, 'right', false, spellStats)
    self.displayDmgStr = nil
    self.displayDmgCoords = {}
    self.finishedAttacking = false
end

function SummonState:enter()
    self.character:refreshBattleAnimations()
    self.summon:refreshBattleAnimations()
    self.character:changeState('battle', 
    {
        ['stance'] = "attacker"
    })
    self.summon:changeState('battle', 
    {
        ['stance'] = "defender"
    })
    self.summon:changeBattleAnimation('unSummoned')
    gMusic['explore-music']:pause()
    gMusic['battle-music']:pause()
    if not gMusic['boss-music']:isPlaying() then
        gMusic['fight-music']:play()
    end
end

function SummonState:update(dt)
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
                            table.insert(self.character.activeSummons, self.summon)
                            self.character:changeState('idle')
                            self.summon:changeState('idle')
                            gStateStack:push(FadeState({
                                r = 255, g = 255, b = 255
                            }, 0.5, 255, 0,
                            function() end))
                        end))
                    end)
            end
        end
    end

    if not self.finishedAttacking then
        self:summonSequence()
    end

    self.character:update(dt, self.camera)
    self.summon:update(dt, self.camera)
    self.battleTerrain:update(dt)
    self.battleDisplayLeft:update(dt)
    self.battleDisplayRight:update(dt)
end

function SummonState:render()
    self.battleTerrain:render()
    self.battleDisplayLeft:render()
    self.battleDisplayRight:render()
    self.summon:render()
    self.character:render()
end


function SummonState:summonSequence()
    local animationTimeAtk = 0
    local animationTimeJump = 0
    if self.currentSequence == 'summon' and not self.engaged then
        self.engaged = true
        self.character:battleSummon(
            function()
                self.currentSequence = 'summonAppear'
                self.engaged = false
            end
        )
    end

    if self.currentSequence == 'summonAppear' and not self.engaged then
        self.engaged = true
        self.summon:battleAppear(
            function()
                self.engaged = false
                self.currentSequence = 'summonIdle'
                self.character:changeBattleAnimation('idle')
                self.summon:changeBattleAnimation('idle')
                self.finishedAttacking = true
            end
        )
    end
end
