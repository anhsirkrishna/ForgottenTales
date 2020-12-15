--[[
    PlayState for Forgotten Tales

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

PlayState = Class{__includes = BaseState}

function PlayState:init(level)
    self.level = Level(level)
    self.camera = Camera(self.level.width, self.level.height, 
                         self.level.cameraStartCoords[1], self.level.cameraStartCoords[2], 
                         CAMERA_SPEED)
    gMusic['explore-music']:setLooping(true)
    gMusic['explore-music']:play()
    self.character = Character {
        mapX = self.level.charSpawnCoords[1],
        mapY = self.level.charSpawnCoords[2],
        width = 32,
        height = 32,
        charClass = "SharpSwordsman",
        name = "Hassle"
    }
    self.startingDialogue = true
end

function PlayState:update(dt)
    if self.startingDialogue then
        gStateStack:push(DialogueState(self.level, self.character, 1))
        self.startingDialogue = false
    end
    self.character:refresh()
    self.camera:update(dt)
    self.level:update(dt, self.camera)
    self.character:update(dt, self.camera)
    self:checkEnemyInSight()
    self:checkCharacterSelected()
    self:inBossZone()
    if self.level.boss.dead then
        gStateStack:push(WinningState())
    end
end

function PlayState:render()
    self.level:render(self.camera.x, self.camera.y)
    self.character:render()
end

function PlayState:checkCharacterSelected()
    local coords = love.mouse.wasPressed(1)
    if coords then
        if self.character:containCoords(coords[1], coords[2]) then
            gStateStack:push(CharSelectState(self.character, self.camera, self.level))
        end
    end
end

function PlayState:checkEnemyInSight()
    for i, enemy in pairs(self.level.enemyList) do
        if not enemy.dead then
            if #enemy:getPathToChar(self.character, self.level) <= 5 then
                gStateStack:push(CombatState(self.character, self.camera, self.level, enemy))
            end
        end
    end
end

function PlayState:inBossZone()
    if #self.level.boss:getPathToChar(self.character, self.level) <= 10 then
        gStateStack:push(CombatState(self.character, self.camera, self.level, self.level.boss, true))
    end
end