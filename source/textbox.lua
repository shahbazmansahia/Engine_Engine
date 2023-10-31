import "camera"

class("Textbox").extends(gfx.sprite)

local choiceGrid = pd.ui.gridview.new(0,30)
--choiceGrid:setCellPadding(5,5,5,5)
choiceGrid:setContentInset(10,10,10,10)
local choices = {}
local width = 380
local height = 90
local selection = 0;

function Textbox:init()
    self.displayingChoices = false
    
    local img = gfx.image.new("sprites/ui/textBox_test")
    assert(img)
    self:setImage(img)
    self:setCenter(0,0)

    local xOffset, yOffset = camera.getCameraOffset()
    self:moveTo(xOffset + 0, yOffset + 130)
    self:setZIndex(1000)
    self:add()



    self.txtImg = gfx.image.new(width, height)

    self.textSprite = gfx.sprite.new(self.txtImg)
    self.textSprite:setCenter(0,0)
    self.textSprite:setZIndex(1001)
    self.textSprite:moveTo(self.x + 10, self.y + 10)
    self.textSprite:add()

    self.choiceGridSprite = gfx.sprite.new()
    self.choiceGridSprite:setCenter(0,0)
    self.choiceGridSprite:setZIndex(1002)
    self.choiceGridSprite:moveTo(self.x,self.y) -- x of 0 should left edge of textbox, but it isn't for some reason
    self.choiceGridSprite:add()
    

    self.currentText = ""
end

function Textbox:update()
    local xOffset, yOffset = camera.getCameraOffset()
    self:moveTo(xOffset + 0, yOffset + 130)

    if self.displayingChoices then
        if pd.buttonJustPressed(pd.kButtonUp) then
            choiceGrid:selectPreviousRow(true)
        elseif pd.buttonJustPressed(pd.kButtonDown) then
            choiceGrid:selectNextRow(true)
        end

        local gridImage = gfx.image.new(width,100)
        gfx.pushContext(gridImage)
            choiceGrid:drawInRect(0,0,width,100)
        gfx.popContext()
        self.choiceGridSprite:setImage(gridImage)

    end
end

function Textbox:setText(text)
    self.currentText = text

    self.txtImg:clear(playdate.graphics.kColorClear)
    gfx.pushContext(self.txtImg)
        gfx.drawTextInRect(self.currentText, 0,0, self.txtImg.width, self.txtImg.height)
    gfx.popContext()
    
end

function Textbox:displayChoices(choicesArray)
    choices = choicesArray
    self.displayingChoices = true
    self.txtImg:clear(playdate.graphics.kColorClear)
    choiceGrid:setNumberOfRows(#choices)
end

function Textbox:hideChoices()
    self.displayingChoices = false
    self.choiceGridSprite:setVisible(false)
    
end

function Textbox:getCurrentSelectedRow()
    return selection
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

function choiceGrid:drawCell(section, row, column, selected, x, y, width, height)
    
    if selected then
        gfx.fillRect(x,y, width, height)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        selection = row
   else
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end
    
    local cellText = choices[row]
    local fontHeight = gfx.getSystemFont():getHeight()
    gfx.drawTextInRect(cellText, x+5,y+5,width,height, nil, nil, kTextAlignment.left)
    
end