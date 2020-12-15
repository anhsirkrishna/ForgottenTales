--[[
    Character Select class 
    A menu that pops up when a character is selected

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

CharSelectMenu = Class{}

MENU_WIDTH = 4
MENU_HEIGHT = 5
TEXT_COLOR = {255, 255, 255, 255}

function CharSelectMenu:init(character, itemList)
    self.x = math.min(character.x + 32, VIRTUAL_WIDTH - MENU_WIDTH*16)
    self.y = math.max(character.y - 64, 0)
    self.menuPanel = MenuPanel(self.x, self.y, MENU_WIDTH, MENU_HEIGHT)
    self.character = character
    self.visible = true
    self.buttonList = {}
    for i, item in pairs(itemList) do
        name = item[1]
        action = item[2]
        if item[3] ~= nil then
            enabled = item[3]
        else
            enabled = true
        end
        local newButton = Button(self.x + 8, self.y + 8 + ((i-1)*20), "medium", name, action, 48, 16)
        newButton.enabled = enabled
        table.insert(self.buttonList, newButton)
    end
    --self.moveButton = Button(self.x + 8, self.y + 8, "medium", "Move", moveAction, 48, 16)
    --self.actionButton = Button(self.x + 8, self.y + 8 + 40, "medium", "Action", actionAction, 48, 16)
    --self.statsButton = Button(self.x + 8, self.y + 8 + 40 + 40, "medium", "Stats", statsAction, 48, 16)

end

function CharSelectMenu:update(dt)
    self.menuPanel:update(dt)
    for i, button in pairs(self.buttonList) do
        button:update(dt)
    end
end

function CharSelectMenu:render()
    if self.visible then
        self.menuPanel:render()
        for i, button in pairs(self.buttonList) do
            button:render(dt)
        end
    end
end
