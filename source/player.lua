local pd <const> = playdate
local gfx <const> = playdate.graphics

import "camera"

class("Player").extends(gfx.sprite)

function Player:init(x,y)
    Player.super.init(self)
    self.type = TYPE_PLAYER
    self.speed = 4;
    self.dirX = 0;
    self.dirY = 0;

    self.idleTable = gfx.imagetable.new("sprites/characters/mcidle")

    self:setImage(self.idleTable:getImage(1))
    local w,h = self.idleTable:getImage(1):getSize()
    self:setZIndex(100)
    self:setCollideRect(8,16, 16,16)

    self:moveTo(x,y)
    self:add()
end

function Player:update()
    
    -- Move player 
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

    setCameraPosition(self.x, self.y)
end

-- Should be called something else or split up
-- Set direction of player
function Player:move(dirX, dirY)

    if(dirY < 0)then
        self:setImage(self.idleTable:getImage(3))
    elseif (dirY > 0) then
        self:setImage(self.idleTable:getImage(1))
    elseif (dirX < 0) then
        self:setImage(self.idleTable:getImage(2))
    elseif (dirX > 0) then
        self:setImage(self.idleTable:getImage(4))
    end

    -- normalize
    self.dirX = dirX;
    self.dirY = dirY;
end

-- When colliding with anything, check for interaction
-- This should be transfered to another class to support NPC x NPC interaction
function Player:checkForAction()
    -- this doesn't work because the player isn't colliding *through* the NPC collider. 
    local x,y,collisions,collisonCount = self:checkCollisions(self.x, self.y)
    for i = 1, collisonCount do
        local collision = collisions[i].other
        if collision.type == TYPE_NPC then 
            eStartConversation(collision.id)
        end
    end
     -- input should switch to dialogue
end

function Player:collisionResponse(other)
   -- if(other.type == tNPC) then
  --      return gfx.sprite.kCollisionTypeOverlap
  --  else
        return gfx.sprite.kCollisionTypeSlide
 --   end

end
