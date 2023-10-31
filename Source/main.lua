import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/math"
import "CoreLibs/ui"

import "global"
import '../toyboxes/toyboxes.lua'
import 'jsonUtil'
import 'game'
import 'mathUtil'

local pd = playdate
local gfx = playdate.graphics

function start()
    game.start()
end

start()

function playdate.update()
    game.update()
    playdate.drawFPS(0,0)
    gfx.sprite.update()
    pd.timer.updateTimers() 
end


