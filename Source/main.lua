import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/math"

import '../toyboxes/toyboxes.lua'
import 'player'

local pd = playdate
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
local tilemap = LDtk.create_tilemap("Level_0", "Main")
gfx.sprite.addWallSprites( tilemap, LDtk.get_empty_tileIDs( "Level_0", "Solid", "Main") )

-- Create sprite and assign tilemap to it
local sprite = gfx.sprite.new()
sprite:setTilemap(tilemap)
sprite:moveTo(0, 0)
--sprite:setZIndex(-1) -- get from tilemap
sprite:setCenter(0,0)
sprite:setBounds(0, 0, 400, 240)
sprite:add()  


-- Load Entities
for index, entity in ipairs( LDtk.get_entities( "Level_0" ) ) do
    if entity.name=="NPC" then
        --player.sprite:add()
        --player.init( entity )
        print("Found npc") -- Just sends console confirmation now
    end
end
    

function start()
    player = Player(200,120)


    currentState = sExploring
end

start()

function playdate.update()
    getMovementInputVector()
    playdate.drawFPS(0,0)
    gfx.sprite.update()
end

function getMovementInputVector()
    if pd.buttonIsPressed(pd.kButtonUp) then 
        player:move(player.dirX, -1)
    end

    if pd.buttonIsPressed(pd.kButtonDown) then 
        player:move(player.dirX, 1)
    end

    if pd.buttonIsPressed(pd.kButtonLeft) then 
        player:move(-1, player.dirY)
    end

    if pd.buttonIsPressed(pd.kButtonRight) then 
        player:move(1, player.dirY)
    end

end
