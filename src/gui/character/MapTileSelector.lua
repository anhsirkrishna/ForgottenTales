--[[
    Map Tile selector class 
    Common UI to display selectable Tiles and return the selected tile

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

MapTileSelector = Class{}

function MapTileSelector:init(character, radius, camera, level, onSelect, includeCharTile, 
                              removeUnreachableTiles, includeEnemyTile, tileColors)
    self.mapX = character.mapX
    self.mapY = character.mapY
    self.level = level
    self.selectableTiles = {}
    self.camera = camera
    self.character = character
    self.radius = radius
    self.selectedTile = nil
    self.visible = true
    self.onSelect = onSelect
    if includeCharTile == nil then
        includeCharTile = false
    end
    if removeUnreachableTiles == nil then
        removeUnreachableTiles = false
    end
    self.includeEnemyTile = includeEnemyTile
    if self.includeEnemyTile == nil then
        self.includeEnemyTile = false
    end

    if tileColors == nil then
        tileColors = {nil, nil, nil}
    end

    local counter = 1
    for i=(-1*radius), radius, 1 do
        startJ = radius - math.abs(i)
        j = (-1*startJ)
        while j <= startJ do
            tileX = self.mapX + i 
            tileY = self.mapY + j
            if tileX > 0 and tileY > 0 and tileX < self.level.width+1 
                and tileY < self.level.height+1 then
                if self.level.topLayer[tileY][tileX] == EMPTY_SPACE then
                    if includeEnemyTile or (self.level.entityLayer[tileY][tileX] == nil) or (self.level.entityLayer[tileY][tileX].dead) then
                        newTile = HighlightedTile(tileX, tileY, camera, 
                                                  tileColors[1], tileColors[2], tileColors[3])
                        if self.selectableTiles[tileX] then
                            self.selectableTiles[tileX][tileY] = newTile
                        else
                            self.selectableTiles[tileX] = {}
                            self.selectableTiles[tileX][tileY] = newTile
                        end
                    end
                end
            end
            j = j + 1
        end
    end

    -- Remove the unreachable tiles for cases like character movement
    if removeUnreachableTiles then
        for k, tileRow in pairs(self.selectableTiles) do
            for l, tile in pairs(tileRow) do
                if self:getPath(tile.mapX, tile.mapY, false) == nil then
                    self.selectableTiles[tile.mapX][tile.mapY] = nil
                end
            end
        end
    end

    if includeCharTile == false then
        self.selectableTiles[self.mapX][self.mapY] = nil
    end
end

function MapTileSelector:update(dt)
    if love.mouse.wasPressed(1) then
        if self.selectedTile then
            self.onSelect(self.selectedTile, self:getPath(self.selectedTile.mapX, self.selectedTile.mapY))
        end
    end

    if self.selectedTile then
        self.selectedTile.selected = false
    end
    local newSelectedTile = self:mousedOverTile()
    if newSelectedTile then
        if self.selectedTile then
            if newSelectedTile.mapX ~= self.selectedTile.mapX or newSelectedTile.mapY ~= self.selectedTile.mapY  then
                gSounds['select-blip']:play()
            end
        else
            gSounds['select-blip']:play()
        end
        self.selectedTile = newSelectedTile
        self.selectedTile.selected = true
    else
        self.selectedTile = nil
    end

    for i, ytable in pairs(self.selectableTiles) do
        for j, tile in pairs(ytable) do
            tile:update(dt)
        end
    end

end

function MapTileSelector:render()
    if self.visible then
        for i, ytable in pairs(self.selectableTiles) do
            for j, tile in pairs(ytable) do
                tile:render(dt)
            end
        end
    end
end

function MapTileSelector:mousedOverTile()
    local tileX = self.camera.x + love.mouse.gridX
    local tileY = self.camera.y + love.mouse.gridY

    if self.selectableTiles[tileX] then
        if self.selectableTiles[tileX][tileY] then
            return self.selectableTiles[tileX][tileY]
        end
    end
    
    return nil
end

--[[
    Function to calculate whether a path exists between the centre and the 
    selected tile.
    Uses BFS algorithm. 
    If returnPath is true then also returns the path of tiles between centre and 
    selected tile
]]
function MapTileSelector:getPath(destX, destY, returnPath)
    if returnPath == nil then
        returnPath = true
    end

    bfsQueue = Queue()
    local stepsTaken = 0
    local numNodesAdjacent = 1
    local numNodesRemain = 0
    local dX = {1, -1, 0, 0}
    local dY = {0, 0, 1, -1}
    local newX = nil
    local newY = nil
    local reachedDest = false
    local visited = self:getEmptyTableSameSize()
    local previous = {}
    local coords = {}

    bfsQueue:push({self.mapX, self.mapY})
    if visited[self.mapX] then
        visited[self.mapX][self.mapY] = true
    else
        visited[self.mapX] = {}
        visited[self.mapX][self.mapY] = true
    end

    while bfsQueue:length() > 0 do
        local coord = bfsQueue:pop()
        xCoord = coord[1]
        yCoord = coord[2]
        if xCoord == destX and yCoord == destY then
            reachedDest = true
            break
        end

        --Check if the adjacent nodes can be travelled to
        for i=1, 4, 1 do
            newX = xCoord + dX[i]
            newY = yCoord + dY[i]
            
            --Check OOB conditions
            if newX < 1 or newY < 1 then goto continue end 
            if newX > self.level.width or newY > self.level.height then goto continue end 

            if self.level.topLayer[newY][newX] == EMPTY_SPACE then
                if self.includeEnemyTile or (self.level.entityLayer[newY][newX] == nil) or (self.level.entityLayer[newY][newX].dead) then
                    --Check if location is already visited
                    if visited[newX] then
                        if visited[newX][newY] then goto continue end
                    else
                        goto continue
                    end
                    bfsQueue:push({newX, newY})
                    visited[newX][newY] = true
                    if returnPath then
                        if previous[newX] then
                            previous[newX][newY] = {xCoord, yCoord}
                        else
                            previous[newX] = {}
                            previous[newX][newY] = {xCoord, yCoord}
                        end
                    end
                    numNodesRemain = numNodesRemain + 1
                end
            end
            ::continue::
        end
        numNodesAdjacent = numNodesAdjacent - 1
        if numNodesAdjacent == 0 then
            numNodesAdjacent = numNodesRemain
            numNodesRemain = 0
            stepsTaken = stepsTaken + 1
            --If length of path is longer than radius then destination is unreachable 
            if stepsTaken > self.radius then
                return nil
            end
        end
    end
    if reachedDest then
        if returnPath then
            return self:reconstructPath(previous, destX, destY)
        else
            return stepsTaken
        end
    end

    return nil
end

--[[
    Function to construct the path from the output of getPath()
]]
function MapTileSelector:reconstructPath(previousVisited, destX, destY)
    local prev = previousVisited[destX][destY]
    local path = {}
    local revPath = {{destX, destY}}
    --construct the path from the last node backwards
    while prev ~= nil do
        table.insert(revPath, {prev[1], prev[2]})
        if previousVisited[prev[1]] then
            prev = previousVisited[prev[1]][prev[2]]
        else
            prev = nil
        end
    end

    --reverse the list to get the path from the start
    for i=#revPath, 1, -1 do
        table.insert(path, revPath[i])
    end

    return path
end

--[[
    Function to generate an empty table which has the same dimensions and indexes as
    the table of selectable tiles. 
]]
function MapTileSelector:getEmptyTableSameSize()
    local emptyTable = {}
    
    for k, tileRow in pairs(self.selectableTiles) do
        for l, tile in pairs(tileRow) do
            if emptyTable[tile.mapX] then
                emptyTable[tile.mapX][tile.mapY] = false
            else
                emptyTable[tile.mapX] = {}
                emptyTable[tile.mapX][tile.mapY] = false
            end
        end
    end
    return emptyTable
end
