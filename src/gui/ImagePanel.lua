--[[
    Image Panel class 
    A Panel that has an image displayed on it

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ImagePanel = Class{}

function ImagePanel:init(x, y, width, height, image)
    self.x = x + 2
    self.y = y + 2
    self.width = width - 4
    self.height = height - 4
    self.panel = Panel(x, y, width, height)
    self.visible = true
    self.imgTexture = self.image[1]
    self.imgQuad = self.image[2]
    quadW, quadH = img_quad:getTextureDimensions()
    self.imgScaleX = quadW/(self.width - 4)
    self.imgScaleY = quadH/(self.height - 4)
end

function ImagePanel:update(dt)

end

function ImagePanel:render()
    if self.visible then
        self.panel:render()
        love.graphics.draw(self.imgTexture, self.imgQuad, self.x + 2, self.y - 2, 1, self.imgScaleX, self.imgScaleY)
    end
end

function ImagePanel:toggle()
    self.visible = not self.visible
end