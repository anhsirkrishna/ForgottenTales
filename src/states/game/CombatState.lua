--[[
    Combat state

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

CombatState = Class{__includes = BaseState}

function CombatState:init(character, camera, level, enemy, isBoss)
    self.level = level
    self.character = character
    self.camera = camera
    if isBoss ~= nil then
        self.bossBattle = isBoss
    else
        self.bossBattle = false
    end
    self.combatEnemyList = enemy:getSurroundingEnemies(level)
    table.insert(self.combatEnemyList, enemy)
    self.turn = 'Player'
    self.prevTurn = 'Enemy'
    self.endTurnButton = Button(VIRTUAL_WIDTH/2-16, VIRTUAL_HEIGHT-32, 'wide', "End", 
                                    function()
                                        self.prevTurn = 'Player'
                                        self.turn = 'Enemy'
                                    end
                                )

    self.displayTurnText = false
    self.displayTurnTextY = 0

end

function CombatState:enter()
    gMusic['explore-music']:pause()
    gMusic['fight-music']:stop()
    if self.bossBattle then
        gMusic['boss-music']:play()
    else
        gMusic['battle-music']:play()
    end
    self.character.inCombat = true
    for i, enemy in pairs(self.combatEnemyList) do
        enemy.inCombat = true
        if enemy.combatDialogue then
            gStateStack:push(DialogueState(self.level, self.character, enemy.combatDialogue))
        end
    end
end

function CombatState:update(dt)
    for i, enemy in pairs(self.combatEnemyList) do
        if not enemy.dead then
            break
        end
        
        if i == #self.combatEnemyList then
            if self.bossBattle then
                gMusic['boss-music']:stop()
            else
                gMusic['battle-music']:stop()
            end
            gMusic['explore-music']:play()
            self.character.inCombat = false
            for i, enemy in pairs(self.combatEnemyList) do
                enemy.inCombat = false
            end
            gStateStack:pop()
        end
    end

    if self.turn ~= self.prevTurn then
        self.displayTurnText = true
        Timer.tween(0.5,{
            [self] = {displayTurnTextY = VIRTUAL_HEIGHT/2}
        }):finish(
            function()
                Timer.after(1,
                    function()
                        self.displayTurnTextY = 0
                        self.displayTurnText = false
                    end
                )
            end
        )
    end

    self.prevTurn = self.turn

    self.character:update(dt, self.camera)
    self.level:update(dt, self.camera)
    self.camera:update(dt)
    if self.displayTurnText then
        self:trackCamera(self.character)

        for i, enemy in pairs(self.combatEnemyList) do
            self:trackCamera(enemy)
        end
    end

    if self.displayTurnText then
        return
    end

    if self.turn == 'Player' then
        self:checkCharacterSelected()
        self.prevTurn = 'Player'
        self.endTurnButton:update(dt)
    elseif self.turn == 'Enemy' then
        nextState = self:enemyTurn()
        if nextState ~= nil then
            gStateStack:push(nextState)
        else
            self.prevTurn = 'Enemy'
            self.turn = 'Player'
            self.character:refresh()
            for i, enemy in pairs(self.combatEnemyList) do
                enemy:refresh()
            end
        end
    end
end

function CombatState:render()
    if self.displayTurnText then
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        love.graphics.rectangle('fill', 0, self.displayTurnTextY, VIRTUAL_WIDTH, VIRTUAL_HEIGHT/5)
        if self.turn == 'Player' then
            love.graphics.setColor(8/255, 50/255, 117/255, 255/255)
        else
            love.graphics.setColor(117/255, 8/255, 26/255, 255/255)
        end
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf(self.turn.." turn",  0, self.displayTurnTextY - 4, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end

    if self.turn == 'Player' then
        self.endTurnButton:render()
    end
end

function CombatState:checkCharacterSelected()
    local coords = love.mouse.wasPressed(1)
    if coords then
        if self.character:containCoords(coords[1], coords[2]) then
            gStateStack:push(CharSelectState(self.character, self.camera, self.level))
        end
    end
end

function CombatState:enemyTurn()
    for i, enemy in pairs(self.combatEnemyList) do
        if not enemy.dead then
            if #enemy.summons > 0 and not enemy.hasAttacked and not enemy:inAtkRange({self.character.mapX, self.character.mapY}) 
                and not enemy.hasSummoned then
                return EnemySummonState(enemy, self.camera, self.level)
            end

            if not enemy.hasMoved then
                return EnemyMoveState(enemy, self.camera, self.level, self.character)
            end

            if #enemy.spells > 0 and not enemy.hasUsedSpell then
                return EnemySpellState(enemy, self.camera, self.level, self.character)
            end
            
            if not enemy.hasAttacked then
                return EnemyAttackState(enemy, self.camera, self.level, self.character)
            end
        end

        for i, summon in pairs(enemy.activeSummons) do
            if not summon.dead then
                if not summon.hasMoved then
                    return EnemyMoveState(summon, self.camera, self.level, self.character)
                end

                if #summon.spells > 0 and not enemy.hasUsedSpell then
                    return EnemySpellState(summon, self.camera, self.level, self.character)
                end
                
                if not summon.hasAttacked then
                    return EnemyAttackState(summon, self.camera, self.level, self.character)
                end
            end
        end
    end
    return nil
end

function CombatState:trackCamera(entity)
    if entity.mapX < self.camera.x then
        self.camera:moveLeft()
    end

    if entity.mapX > (self.camera.x + SCREEN_TILE_WIDTH) then
        self.camera:moveRight()
    end

    if entity.mapY < self.camera.y then
        self.camera:moveUp()
    end

    if entity.mapY > (self.camera.y + SCREEN_TILE_HEIGHT) then
        self.camera:moveDown()
    end

end
