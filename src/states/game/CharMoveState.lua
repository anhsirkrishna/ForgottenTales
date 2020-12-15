--[[
    State when a character has to move

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

CharMoveState = Class{__includes = BaseState}

function CharMoveState:init(character, camera, level)
    self.character = character
    self.camera = camera
    self.level = level
    self.moveQueue = Queue()
    self.hasMoved = false
    self.moveSpeed = math.max(0, self.character.baseMoveSpeed + self.character:getTotalMod('move'))
    self.moveMap = MapTileSelector(self.character, self.moveSpeed, 
                                   self.camera, self.level, 
                                   function(destinationTile, pathToTile)
                                        self.hasMoved = true
                                        self:onSelect(destinationTile, pathToTile)
                                   end, 
                                   false, true)
end

function CharMoveState:update(dt)
    if love.mouse.wasPressed(2) then
        gSounds['menu-backward']:play()
        gStateStack:pop()
        gStateStack:push(CharSelectState(self.character, self.camera, self.level))
    end

    if self.hasMoved then
        if self.moveQueue:length() == 0 then
            if self.character.canMove then
                self.character.hasMoved = true
                --Exit criteria
                gStateStack:pop()
            end
        end
    else
        self.moveMap:update(dt)
    end

    -- When a tile is selected character will start moving
    if self.moveQueue:length() > 0 then
        self.moveMap.visible = false
        if self.character.canMove then
            if not self.character.inCombat then
                self:checkEnemyInSight()
            end
            moveCoords = self.moveQueue:pop()
            direction = self.character:relativeDirection(moveCoords)
            self.character:move(direction)
        end
    end

    self.character:update(dt, self.camera)
end

function CharMoveState:render()    
    self.moveMap:render()
end

function CharMoveState:onSelect(selectedTile, pathToTile)
    for i, coords in pairs(pathToTile) do
        self.moveQueue:push(coords)
    end
    --Removing the first tile which is the same as starting tile
    self.moveQueue:pop()
end

function CharMoveState:checkEnemyInSight()
    for i, enemy in pairs(self.level.enemyList) do
        if not enemy.dead then
            if #enemy:getPathToChar(self.character, self.level) <= 5 then
                gStateStack:pop()
                gStateStack:push(CombatState(self.character, self.camera, self.level, enemy))
            end
        end
    end
end