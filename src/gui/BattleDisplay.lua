--[[
    UI Element to display relevant info during battle state
]]

BattleDisplay = Class{}

function BattleDisplay:init(character, side, attacker, spell)
    self.charName = character.name
    self.side = side
    local addValue = 0
    if attacker then
        if spell then
            self.text = "SPL : "..(character.spell + character:getTotalMod('spell'))
        else
            self.text = "ATK : "..(character.atk + character:getTotalMod('atk'))
        end
    else
        if spell then
            self.text = "RES : "..(character.res + character:getTotalMod('res'))
        else
            self.text = "DEF : "..(character.def + character:getTotalMod('def'))
        end
    end

    self.woodPanel = WoodPanel(-8, 32, 9, 3)
    self.portrait = Portrait(8, 40, character, 0.5, 0.5)
    self.sheet = Sheet(42, 40 , 5, 2)
    if character.baseHp > 15 then
        hpPanelHeight = 4
    else
        hpPanelHeight = 3
    end
    self.hpPanel = MenuPanel(-8, 72, 10, hpPanelHeight)
    self.healthBar = HealthBar(5, self.hpPanel.y + 8, character, scaleX, scaleY)
    self.spellBar = HealthBar(5, self.hpPanel.y + (16*(hpPanelHeight-1)) - 4, character, scaleX, scaleY, true)
    
end

function BattleDisplay:update(dt)
    self.healthBar:update(dt)
    self.spellBar:update(dt)
end

function BattleDisplay:render()
    if self.side == 'right' then
        love.graphics.push()
        love.graphics.translate(VIRTUAL_WIDTH, 0)
        love.graphics.scale(-1, 1)
    end
    self.hpPanel:render()
    self.woodPanel:render()
    self.portrait:render()
    self.sheet:render()
    self.healthBar:render()
    self.spellBar:render()
    if self.side == 'right' then
        love.graphics.pop()
    end

    if self.side == 'right' then
        love.graphics.push()
        love.graphics.translate(VIRTUAL_WIDTH - 172, 0)
    end
    love.graphics.setFont(gFonts['smallName'])
    love.graphics.setColor(0/255, 0/255, 0/255, 255/255)
    love.graphics.printf(self.charName, 46, 42, 80, self.side)
    love.graphics.setFont(gFonts['smallNum'])
    love.graphics.printf(self.text,  46, 54, 80, self.side)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    if self.side == 'right' then
        love.graphics.pop()
    end
end