--[[
    Utility functions for Forgotten Tales

    Author: Krishna Pillai(krishna_sp@outlook.com)
]]

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--[[
    Function to generate the GUI Menu Panel elements
]]
function GenerateMenuPanelQuads(atlas)
    local menuPanel = {
        ['topLeft']  = love.graphics.newQuad(0, 32, 16, 16, atlas:getDimensions()),
        ['topMid']   = love.graphics.newQuad(16, 32, 16, 16, atlas:getDimensions()),
        ['topRight'] = love.graphics.newQuad(32, 32, 16, 16, atlas:getDimensions()),
        ['midLeft']  = love.graphics.newQuad(0, 48, 16, 16, atlas:getDimensions()),
        ['midMid']   = love.graphics.newQuad(16, 48, 16, 16, atlas:getDimensions()),
        ['midRight'] = love.graphics.newQuad(32, 48, 16, 16, atlas:getDimensions()),
        ['botLeft']  = love.graphics.newQuad(0, 64, 16, 16, atlas:getDimensions()),
        ['botMid']   = love.graphics.newQuad(16, 64, 16, 16, atlas:getDimensions()),
        ['botRight'] = love.graphics.newQuad(32, 64, 16, 16, atlas:getDimensions())
    }
    return menuPanel
end

--[[
    Function to generate the GUI button elements
]]
function GenerateButtonQuads(atlas)
    local buttons = {
        ['smallUnclicked']  = love.graphics.newQuad(0, 80, 16, 16, atlas:getDimensions()),
        ['smallClicked']    = love.graphics.newQuad(16, 80, 16, 16, atlas:getDimensions()),
        ['smallGreyedOut']  = love.graphics.newQuad(32, 80, 16, 16, atlas:getDimensions()),
        ['mediumUnclicked'] = love.graphics.newQuad(112, 80, 32, 16, atlas:getDimensions()),
        ['mediumClicked']   = love.graphics.newQuad(112, 96, 32, 16, atlas:getDimensions()),
        ['mediumGreyedOut'] = love.graphics.newQuad(112, 112, 32, 16, atlas:getDimensions()),
        ['wideUnclicked']   = love.graphics.newQuad(144, 80, 64, 16, atlas:getDimensions()),
        ['wideClicked']     = love.graphics.newQuad(144, 96, 64, 16, atlas:getDimensions()),
        ['wideGreyedOut']   = love.graphics.newQuad(144, 112, 64, 16, atlas:getDimensions())
    }
    return buttons
end

--[[
    Function to generate the GUI wood panel elements
]]
function GenerateWoodPanelQuads(atlas)
    local woodPanel = {
        ['topLeft']  = love.graphics.newQuad(0, 96, 16, 16, atlas:getDimensions()),
        ['topMid']   = love.graphics.newQuad(16, 96, 16, 16, atlas:getDimensions()),
        ['topRight'] = love.graphics.newQuad(32, 96, 16, 16, atlas:getDimensions()),
        ['midLeft']  = love.graphics.newQuad(0, 104, 16, 16, atlas:getDimensions()),
        ['midMid']   = love.graphics.newQuad(16, 104, 16, 16, atlas:getDimensions()),
        ['midRight'] = love.graphics.newQuad(32, 104, 16, 16, atlas:getDimensions()),
        ['botLeft']  = love.graphics.newQuad(0, 112, 16, 16, atlas:getDimensions()),
        ['botMid']   = love.graphics.newQuad(16, 112, 16, 16, atlas:getDimensions()),
        ['botRight'] = love.graphics.newQuad(32, 112, 16, 16, atlas:getDimensions())
    }
    return woodPanel
end

function GenerateSheetQuads(atlas)
    local sheet = {
        ['topLeft']  = love.graphics.newQuad(48, 96, 16, 16, atlas:getDimensions()),
        ['topMid']   = love.graphics.newQuad(56, 96, 16, 16, atlas:getDimensions()),
        ['topRight'] = love.graphics.newQuad(64, 96, 16, 16, atlas:getDimensions()),
        ['midLeft']  = love.graphics.newQuad(48, 100, 16, 16, atlas:getDimensions()),
        ['midMid']   = love.graphics.newQuad(56, 100, 16, 16, atlas:getDimensions()),
        ['midRight'] = love.graphics.newQuad(64, 100, 16, 16, atlas:getDimensions()),
        ['botLeft']  = love.graphics.newQuad(48, 112, 16, 16, atlas:getDimensions()),
        ['botMid']   = love.graphics.newQuad(56, 112, 16, 16, atlas:getDimensions()),
        ['botRight'] = love.graphics.newQuad(64, 112, 16, 16, atlas:getDimensions())
    }
    return sheet
end

function GenerateStoneSheetQuads(atlas)
    local sheet = {
        ['topLeft']  = love.graphics.newQuad(48+32, 96, 16, 16, atlas:getDimensions()),
        ['topMid']   = love.graphics.newQuad(56+32, 96, 16, 16, atlas:getDimensions()),
        ['topRight'] = love.graphics.newQuad(64+32, 96, 16, 16, atlas:getDimensions()),
        ['midLeft']  = love.graphics.newQuad(48+32, 100, 16, 16, atlas:getDimensions()),
        ['midMid']   = love.graphics.newQuad(56+32, 100, 16, 16, atlas:getDimensions()),
        ['midRight'] = love.graphics.newQuad(64+32, 100, 16, 16, atlas:getDimensions()),
        ['botLeft']  = love.graphics.newQuad(48+32, 112, 16, 16, atlas:getDimensions()),
        ['botMid']   = love.graphics.newQuad(56+32, 112, 16, 16, atlas:getDimensions()),
        ['botRight'] = love.graphics.newQuad(64+32, 112, 16, 16, atlas:getDimensions())
    }
    return sheet
end

function GeneratePopupQuads(atlas)
    local sheet = {
        ['topLeft']  = love.graphics.newQuad(144, 64, 16, 8, atlas:getDimensions()),
        ['topMid']   = love.graphics.newQuad(144+16, 64, 16, 8, atlas:getDimensions()),
        ['topRight'] = love.graphics.newQuad(144+32, 64, 16, 8, atlas:getDimensions()),
        ['midLeft']  = love.graphics.newQuad(144, 64+4, 16, 8, atlas:getDimensions()),
        ['midMid']   = love.graphics.newQuad(144+16, 64+4, 16, 8, atlas:getDimensions()),
        ['midRight'] = love.graphics.newQuad(144+32, 64+4, 16, 8, atlas:getDimensions()),
        ['botLeft']  = love.graphics.newQuad(144, 64+8, 16, 8, atlas:getDimensions()),
        ['botMid']   = love.graphics.newQuad(144+16, 64+8, 16, 8, atlas:getDimensions()),
        ['botRight'] = love.graphics.newQuad(144+32, 64+8, 16, 8, atlas:getDimensions())
    }
    return sheet
end

--[[
    Function that returns the list of all the d20 roll textures
]]
function GetD20Textures()
    local d20Textures = {}
    for i=1, 20, 1 do
        iStr = tostring(i)
        if #iStr == 1 then
            iStr = "0"..iStr
        end
        d20Textures[i] = love.graphics.newImage('graphics/d20/r'..iStr..'.png')
    end
    return d20Textures
end

function GetD20Quads(d20Textures)
    local d20Quads = {}
    for i=1, 20, 1 do
        d20Quads[i] = GenerateQuads(d20Textures[i], 320, 180)
    end
    return d20Quads
end

function GeneratePortraitTextures()
    portrait_list = {'con4.png', 'con9.png', 'con11.png', 'con16.png', 'con22.png', 'con23.png', 'con26.png', 'con33.png', 'con34.png',}
    local textureList = {}
    for i, path in pairs(portrait_list) do
        fullPath = "graphics/portraits/"..path
        textureList[i] = love.graphics.newImage(fullPath)
    end
    return textureList
end

function GenerateHealthBarQuads(healthBarTexture)
    local offset = 0
    local healthBarQuads = {}
    for i=1, 8, 1 do 
        healthBarQuads[i] = love.graphics.newQuad(16+offset, 0, 10, 9, healthBarTexture:getDimensions())
        offset = offset + 9
    end
    offset = 0
    for i=9, 16, 1 do 
        healthBarQuads[i] = love.graphics.newQuad(16+offset, 9, 10, 9, healthBarTexture:getDimensions())
        offset = offset + 9
    end
    healthBarQuads[0] = love.graphics.newQuad(16, 27, 10, 9, healthBarTexture:getDimensions())
    return healthBarQuads
end

function GenerateSpellBarQuads(spellBarTexture)
    local offset = 0
    local spellBarQuads = {}
    for i=1, 8, 1 do 
        spellBarQuads[i] = love.graphics.newQuad(16+offset, 60, 10, 9, spellBarTexture:getDimensions())
        offset = offset + 9
    end
    offset = 0
    for i=9, 16, 1 do 
        spellBarQuads[i] = love.graphics.newQuad(16+offset, 69, 10, 9, spellBarTexture:getDimensions())
        offset = offset + 9
    end
    return spellBarQuads
end

function table.slice(tbl, first, last, step)
    local sliced = {}
  
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
  
    return sliced
end

--[[
    Recursive table printing function.
    https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
]]
function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end


function rollD20()
    return math.random(1,20)
end


function GetPath(startX, startY, destX, destY, returnPath, level)
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
    local visited = {}
    local previous = {}
    local coords = {}
    local visited = {}

    bfsQueue:push({startX, startY})
    if visited[startX] then
        visited[startX][startY] = true
    else
        visited[startX] = {}
        visited[startX][startY] = true
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
            if newX > level.width or newY > level.height then goto continue end 

            if level.topLayer[newY][newX] == EMPTY_SPACE then
                if level.entityLayer[newY][newX] == nil or level.entityLayer[newY][newX].dead then
                    --Check if location is already visited
                    if visited[newX] then
                        if visited[newX][newY] then goto continue end
                    else
                        visited[newX] = {}
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
        end
    end
    if reachedDest then
        if returnPath then
            return ReconstructPath(previous, destX, destY)
        else
            return stepsTaken
        end
    end

    return nil
end

--[[
    Function to construct the path from the output of getPath()
]]
function ReconstructPath(previousVisited, destX, destY)
    local prev = previousVisited[destX][destY]
    local path = {}
    local revPath = {{destX, destY}}
    --construct the path from the last node backwards
    while prev ~= nil do
        table.insert(revPath, {prev[1], prev[2]})
        prev = previousVisited[prev[1]][prev[2]]
    end

    --reverse the list to get the path from the start
    for i=#revPath, 1, -1 do
        table.insert(path, revPath[i])
    end

    return path
end

function generateTable(size)
    local newTable = {}
    for i=1, size, 1 do
        newTable[i] = i
    end
    return newTable
end