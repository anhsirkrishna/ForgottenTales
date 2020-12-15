--[[
    UI Component for a 2D selector 

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

ScrollableSelector = Class{}

function ScrollableSelector:init(width, height, itemList)
    self.width = width
    self.height = height
    self.fullItemList = itemList    
    self.itemCount = len(self.fullItemList)
    self.matrixSize = self.width * self.height
    self.startIndex = 1
    self.matrix = table.slice(self.fullItemList, self.startIndex, self.matrixSize)
    self.matrix[1].highlighted = true
end

function ScrollableSelector:scrollRight()
    self.startIndex = math.min(self.startIndex + self.matrixSize + 1, self.itemCount - self.matrixSize + 1)
    self.matrix = table.slice(self.fullItemList, self.startIndex, self.startIndex + self.matrixSize)
    self.matrix
end

function ScrollableSelector:moveUp()
    highlightedItem = self:gethighlightedItem()
    newHighlight = highlightedItem - self.width
    if newHighlight < 1 then
        newHighlight = self.buttonCount + newHighlight
    end

    self.matrix[highlightedItem].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ScrollableSelector:moveDown()
    highlightedItem = self:gethighlightedItem()
    newHighlight = highlightedItem + self.width
    if newHighlight > self.buttonCount then
        newHighlight =  newHighlight - self.buttonCount
    end

    self.matrix[highlightedItem].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ScrollableSelector:moveRight()
    highlightedItem = self:gethighlightedItem()
    newHighlight = highlightedItem + 1
    if newHighlight > self.buttonCount then
        newHighlight =  1
    end

    self.matrix[highlightedItem].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ScrollableSelector:moveLeft()
    highlightedItem = self:gethighlightedItem()
    newHighlight = highlightedItem - 1
    if newHighlight < 1 then
        newHighlight = self.buttonCount 
    end
    self.matrix[highlightedItem].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ScrollableSelector:gethighlightedItem()
    for k, button in pairs(self.matrix) do
        if button.highlighted then
            return k
        end
    end
end