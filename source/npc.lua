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
    self.triggerSize = 40
    --self:setBounds(self.x-(self.triggerSize/2), self.y-(self.triggerSize/2), self.triggerSize, self.triggerSize)
    local cX = self.x + self.width/2
    local cY = self.y + self.height/2
    self:setCollideRect(cX -(self.triggerSize/2) , cY-(self.triggerSize/2), self.triggerSize, self.triggerSize)

    self:moveTo(lData.position.x,lData.position.y)
    self:add()

    self.colliderSize = 32
    self.collider = gfx.sprite.new()
    self.collider:moveTo(self.x, self.y)
    self.collider:setBounds(self.x-(self.colliderSize/2), self.y-(self.colliderSize/2), self.colliderSize, self.colliderSize)
    self.collider:setCollideRect(0,0, self.colliderSize,self.colliderSize)
    self.collider:add()
end