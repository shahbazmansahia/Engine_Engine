import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/math"

import '../toyboxes/toyboxes.lua'
import 'player'
import 'npc'
import 'jsonUtil'
import 'game'

local pd = playdate
local gfx = playdate.graphics

function start()
    game.loadLevel()
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
