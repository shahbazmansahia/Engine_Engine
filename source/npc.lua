local pd <const> = playdate
local gfx <const> = playdate.graphics


class("NPC").extends(gfx.sprite)

function NPC:init(lData, cData)
    NPC.super.init(self)
    self.speed = 2;
    
    local image = gfx.image.new(cData.source)
    self:setImage(image)
    local w,h = image:getSize()

    self:setCollideRect(4,8, 8,8)

    self:moveTo(lData.position.x,lData.position.y)
    self:add()
end