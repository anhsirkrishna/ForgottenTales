--[[
    Data structure to hold all the buttons in the current scene to make them easily navigatable

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

ButtonMatrix = Class{}

function ButtonMatrix:init(width, height, buttonList)
    self.width = width
    self.height = height
    self.matrix = buttonList
    self.matrix[1].highlighted = true
    self.buttonCount = len(self.matrix)
end

function ButtonMatrix:moveUp()
    highlightedButton = self:getHighlightedButton()
    newHighlight = highlightedButton - self.width
    if newHighlight < 1 then
        newHighlight = self.buttonCount + newHighlight
    end

    self.matrix[highlightedButton].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ButtonMatrix:moveDown()
    highlightedButton = self:getHighlightedButton()
    newHighlight = highlightedButton + self.width
    if newHighlight > self.buttonCount then
        newHighlight =  newHighlight - self.buttonCount
    end

    self.matrix[highlightedButton].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ButtonMatrix:moveRight()
    highlightedButton = self:getHighlightedButton()
    newHighlight = highlightedButton + 1
    if newHighlight > self.buttonCount then
        newHighlight =  1
    end

    self.matrix[highlightedButton].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ButtonMatrix:moveLeft()
    highlightedButton = self:getHighlightedButton()
    newHighlight = highlightedButton - 1
    if newHighlight < 1 then
        newHighlight = self.buttonCount 
    end
    self.matrix[highlightedButton].highlighted = false
    self.matrix[newHighlight].highlighted = true
end

function ButtonMatrix:getHighlightedButton()
    for k, button in pairs(self.matrix) do
        if button.highlighted then
            return k
        end
    end
end