function max(a,b)
    if a > b then
        return a;
    else
        return b;
    end
end

function min(a,b)
    if a < b then
        return a;
    else
        return b;
    end
end

function pointIsOutOfBounds(px,py,bx,by,bWidth,bHeight)
   if (px >= bx and px < bx+bHeight) and py < by then -- top
    return 1
   elseif px > bx+bWidth and (py >= by and py <= by+bHeight) then -- right
    return 2
   elseif (px >= bx and px <= by + bWidth) and py > by+bHeight then -- bottom
    return 3
   elseif px < bx and (py >= by and py <= by+bHeight) then -- left
    return 4
   else 
    return 0
   end
end