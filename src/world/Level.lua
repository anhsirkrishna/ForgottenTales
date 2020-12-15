--[[
    The class for creating the level from the level tilemap

    Author : Krishna S Pillai (krishna_sp@outlook.com)
]]

Level = Class{}

function Level:init(level)
    self.levelDef = LEVEL_DEFS[level]
    self.width = self.levelDef["width"]
    self.height = self.levelDef["height"]
    self.baseLayer = self.levelDef["baseLayer"]
    self.topLayer = self.levelDef["topLayer"]
    self.charSpawnCoords = self.levelDef["charSpawnCoords"]
    self.cameraStartCoords = self.levelDef["cameraCoords"]
    self.entityLayer = {}
    self.enemyList = {}
    for i=1, self.height, 1 do
        self.entityLayer[i] = {}
        for j=1, self.width do
            self.entityLayer[i][j] = nil
        end
    end
    enemyList = self.levelDef["enemyList"]
    for i, enemy in pairs(enemyList) do
        enemyName = enemy["name"]
        enemyClass = enemy["class"]
        enemyEntity = enemy["entity"]
        enemyCoords = enemy["coords"]
        loot = enemy["loot"]
        combatDialogue = enemy["combatDialogue"] or nil
        deathDialogue = enemy["deathDialogue"] or nil
        newEnemy = Enemy({
            mapX = enemyCoords[1],
            mapY = enemyCoords[2],
            width = 32,
            height = 32,
            enemyClass = enemyClass,
            name = enemyName,
            entity = enemyEntity,
            loot = loot,
            combatDialogue = combatDialogue,
            deathDialogue = deathDialogue
        })
        self.entityLayer[enemyCoords[2]][enemyCoords[1]] = newEnemy
        table.insert(self.enemyList, newEnemy)
    end
    
    self.boss = Enemy({
        mapX =  self.levelDef["boss"]["coords"][1],
        mapY = self.levelDef["boss"]["coords"][2],
        width = 32,
        height = 32,
        enemyClass = self.levelDef["boss"]["class"],
        name = self.levelDef["boss"]["name"],
        entity = self.levelDef["boss"]["entity"],
        loot = nil,
    })
    self.entityLayer[self.boss.mapY][self.boss.mapX] = self.boss
end

function Level:update(dt, camera)
    for i, enemy in pairs(self.enemyList) do
        enemy:update(dt, camera)
    end
    self.boss:update(dt, camera)
end

function Level:render(camX, camY)
    --Render Base Layer
    for y=1, SCREEN_TILE_HEIGHT, 1 do
        for x=1, SCREEN_TILE_WIDTH, 1 do
            tileId = self.baseLayer[camY + (y-1)][camX + (x-1)]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tileId],
                (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
        end
    end

    --Render Top Layer
    for y=1, SCREEN_TILE_HEIGHT, 1 do
        for x=1, SCREEN_TILE_WIDTH, 1 do
            tileId = self.topLayer[camY + (y-1)][camX + (x-1)]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tileId],
                (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
        end
    end

    --Render all the enemies
    for i, enemy in pairs(self.enemyList) do
        enemy:render()
        for i, summon in pairs(enemy.activeSummons) do
            summon:render(dt, camera)
        end
    end

    self.boss:render()
    for i, summon in pairs(self.boss.activeSummons) do
        summon:render(dt, camera)
    end
end