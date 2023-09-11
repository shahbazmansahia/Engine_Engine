local pd <const> = playdate
local gfx <const> = playdate.graphics


class("Player").extends(gfx.sprite)

function Player:init(x,y)
    Player.super.init(self)
    
    local image = gfx.image.new("sprites/hero_idle_D.png")
    self:setImage(image)
    local w,h = image:getSize()

    --self:setCollideRect(4,8, 8,8) -- when we are ready to add collisions

    self:moveTo(x,y)
    self:add()
end