import '../toyboxes/toyboxes.lua'

local gfx = playdate.graphics

gfx.setColor(gfx.kColorBlack)

-- Draw background. This can be imported from LDtk file
local bgImage = gfx.image.new(400,240, gfx.kColorBlack) 
local bg = gfx.sprite.new(bgImage)
bg:moveTo(0, 0)
bg:setCenter(0,0)
bg:add()

-- Basic example of loading LDtk file
LDtk.load( "ldtkfiles/test.ldtk"  )
local tilemap = LDtk.create_tilemap("Level_0")

-- Create sprite and assign tilemap to it
local sprite = gfx.sprite.new()
sprite:setTilemap(tilemap)
sprite:moveTo(0, 0)
--sprite:setZIndex(-1) -- get from tilemap
sprite:setCenter(0,0)
sprite:setBounds(0, 0, 400, 240)
sprite:add()  


function playdate.update()
    playdate.drawFPS(0,0)
    gfx.sprite.update()
end
