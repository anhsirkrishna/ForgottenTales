--[[
    Class for handling small text elements on the GUI

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

TextPanel = Class{}

function TextPanel:init(x, y, width, height, text, txtColor)
    self.x = x + 2
    self.y = y + (height/3)
    self.width = width - 4
    self.height = height - 4
    self.text = text
    self.panel = Panel(x, y, width, height, 'Red')
    self.visible = true
    self.txtColor = txtColor or {255, 255, 255, 255}
end

function TextPanel:update(dt)

end

function TextPanel:render()
    if self.visible then
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        self.panel:render()
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(self.txtColor[1]/255, self.txtColor[2]/255, self.txtColor[3]/255, self.txtColor[4]/255)
        love.graphics.printf(self.text,  self.x + 2, self.y + 2, self.width - 4, 'center')
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    end
end

function TextPanel:toggle()
    self.visible = not self.visible
end