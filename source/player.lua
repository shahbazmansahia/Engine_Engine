local pd <const> = playdate
local gfx <const> = playdate.graphics


class("Player").extends(gfx.sprite)

function Player:init(x,y)
    Player.super.init(self)
    self.speed = 2;
    self.dirX = 0;
    self.dirY = 0;
    
    local image = gfx.image.new("sprites/hero_idle_D.png")
    self:setImage(image)
    local w,h = image:getSize()

    self:setCollideRect(4,8, 8,8)

    self:moveTo(x,y)
    self:add()
end

function Player:update()
    --self:moveBy(self.dirX * self.speed, self.dirY * self.speed);
    local x,y,collisions,collisonCount = self:moveWithCollisions(self.x + self.dirX * self.speed, self.y + self.dirY * self.speed)

    --[[

        for i = 1, collisonCount do
            local collision = collisions[i].other
            
            if collision.type == tDoor then  
                eOpenDoor(collision.id) -- may need repeated call protection  
            end
            
            --print(collision.type)
            
        end
        ]]
        
    self.dirX = 0;
    self.dirY = 0;

    --setCameraPosition(self.x, self.y)
end

function Player:move(dirX, dirY)
    -- normalize
    self.dirX = dirX;
    self.dirY = dirY;
end

function Player:checkForAction()

    local x,y,collisions,collisonCount = self:checkCollisions(self.x, self.y)
    --[[

 
    for i = 1, collisonCount do
        local collision = collisions[i].other
        if collision.type == tNPC then 
            eStartConversation(collision.id)
        end
    end
       ]]
     -- input should switch to dialogue
        


end

function Player:collisionResponse(other)
   -- if(other.type == tNPC) then
  --      return gfx.sprite.kCollisionTypeOverlap
  --  else
        return gfx.sprite.kCollisionTypeSlide
 --   end

end
