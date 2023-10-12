local pd <const> = playdate
local gfx <const> = playdate.graphics


class("NPC").extends(gfx.sprite)

function NPC:init(lData, cData)
    NPC.super.init(self)
    self.type = TYPE_NPC
    self.id = cData.id
    self.speed = 2;
    
    local image = gfx.image.new(cData.source)
    self:setImage(image)
    local w,h = image:getSize()

    self:setZIndex(99)
    self:setCollideRect(0,0, 32,32)

    self:moveTo(lData.position.x,lData.position.y)
    self:add()
end