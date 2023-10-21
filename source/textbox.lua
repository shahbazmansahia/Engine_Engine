import "camera"

class("Textbox").extends(gfx.sprite)

function Textbox:init()

    
    local img = gfx.image.new("sprites/ui/textBox_test")
    assert(img)
    self:setImage(img)
    self:setCenter(0,0)

    local xOffset, yOffset = camera.getCameraOffset()
    self:moveTo(xOffset + 0, yOffset + 130)
    --self:setZIndex(1000)
    self:add()

    local width = 380
    local height = 90

    self.txtImg = gfx.image.new(width, height)

    self.textSprite = gfx.sprite.new(self.txtImg)
    self.textSprite:setCenter(0,0)
    
    self.textSprite:moveTo(self.x + 10, self.y + 10)
    self.textSprite:add()

    self.currentText = ""
end

function Textbox:update()
    local xOffset, yOffset = camera.getCameraOffset()
    self:moveTo(xOffset + 0, yOffset + 130)
end

function Textbox:setText(text)
    self.currentText = text

    self.txtImg:clear(playdate.graphics.kColorClear)
    gfx.pushContext(self.txtImg)
        gfx.drawTextInRect(self.currentText, 0,0, self.txtImg.width, self.txtImg.height)
    gfx.popContext()
    
end

function Textbox:remove()
    self.txtImg:clear(playdate.graphics.kColorClear)
    Textbox.super.remove(self)
end

--[[

    function Textbox:draw() ----- not working :( make a small test project
        gfx.pushContext(self.textSprite)
		gfx.setColor(gfx.kColorBlack)
        gfx.drawTextInRect(self.currentText, self.textSprite.x , self.textSprite.y, self.textSprite.width, self.textSprite.height)
        gfx.popContext()
    end
]]