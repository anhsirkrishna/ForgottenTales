--[[
    State when an enemy has to move

    Author: Krishna Pillai (krishna_sp@outlook.com)
]]

EnemyMoveState = Class{__includes = BaseState}

function EnemyMoveState:init(enemy, camera, level, character)
    self.enemy = enemy
    self.camera = camera
    self.level = level
    self.character = character
    self.moveQueue = Queue()
    self.hasMoved = false
end

function EnemyMoveState:enter()
    self:move()
end

function EnemyMoveState:update(dt)

    if self.moveQueue:length() == 0 then
        if self.enemy.canMove then
            self.enemy.hasMoved = true
            self.level.entityLayer[self.oldY][self.oldX] = nil
            self.level.entityLayer[self.enemy.mapY][self.enemy.mapX] = self.enemy
            --Exit criteria
            gStateStack:pop()
        end
    end

    if self.moveQueue:length() > 0 then
        if self.enemy.canMove then
            moveCoords = self.moveQueue:pop()
            direction = self.enemy:relativeDirection(moveCoords)
            self.enemy:move(direction)
        end
    end

    self.enemy:update(dt, self.camera)
end

function EnemyMoveState:render()
end

function EnemyMoveState:move()
    self.oldX = self.enemy.mapX
    self.oldY = self.enemy.mapY
    pathToTile = self.enemy:getPathToChar(self.character, self.level)
    for i, coords in pairs(pathToTile) do
        if i > self.enemy.baseMoveSpeed then
            break
        end
        if coords[1] == self.character.mapX and coords[2] == self.character.mapY then
            break
        end
        if self:inAtkRange(coords) then
            self.moveQueue:push(coords)
            break
        end
        self.moveQueue:push(coords)
    end
    --Removing the first tile which is the same as starting tile
    self.moveQueue:pop()
end

function EnemyMoveState:inAtkRange(coords)
    local distance = math.abs(coords[1] - self.character.mapX) + math.abs(coords[2] - self.character.mapY)
    if distance <= self.enemy.atkRange then
        return true
    end
    return false
end