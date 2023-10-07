local xOffset = 0
local yOffset = 0



function setCameraPosition(x,y)

    --local newX = floor(max(min(x - 200 + 60, maxX), minX))

    xOffset = min(max(x-200, 0), SCENE_WIDTH-400)
    yOffset = min(max(y-120, 0), SCENE_HEIGHT-240)
    --print("(".. xOffset .. "," .. yOffset .. ")")
    gfx.setDrawOffset(-xOffset,-yOffset)
end

function getCameraOffset()
    return xOffset, yOffset
end