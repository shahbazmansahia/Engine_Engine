//// Controls all gameplay logic

game = {}

local pd = playdate
local gfx = playdate.graphics

import "scene"

function game.start()
    LDtk.load( "ldtkfiles/NativeWorld.ldtk"  )

    CURRENT_SCENE = "Level_0"
    
    player = Player(200,120)
    game.loadScene(CURRENT_SCENE)
    


    currentState = sExploring
end

function game.loadScene(sceneName)
    
    local previousLevel = CURRENT_SCENE
    CURRENT_SCENE = sceneName

    LDtk.load_level(sceneName)
    if not(previousLevel == sceneName) then
        LDtk.release_level(previousLevel)
    end

    scene.draw(sceneName)
    --player.sprite:add()

    local charactersDB = convertJSONToTable('db_characters.json')
  
    --[[
    -- Load Entities
    for index, entity in ipairs( LDtk.get_entities( "Level_0" ) ) do
        if entity.name=="NPC" then
            local cData = charactersDB[entity.fields.Name]
            if(cData == nil) then
                print("-- ERROR - Level:placeNPC() : Failed to find ".. entity.fields.Name .." in character database")
                return nil
            else
                npc1 = NPC(entity, cData)
            end
            
            --print(entity.fields.Name) -- Just sends console confirmation now
        end
    end
    ]]

end

function game.update()
    getMovementInputVector()

    changeSceneOnScreenExit()

end

--[[If there is an adjcent scene in the direction that the player exits the screen
then change to that scene]]
function changeSceneOnScreenExit()
    local outOfBounds = pointIsOutOfBounds(player.x, player.y, 0,0,SCENE_WIDTH, SCENE_HEIGHT)
    local sceneFound = true
    if outOfBounds == 1 then -- north
        local newScene = LDtk.get_neighbours(CURRENT_SCENE, "north")[1]
        sceneFound = not(newScene == nil)
        if sceneFound then
            game.loadScene(newScene)
            player:moveTo(player.x, SCENE_HEIGHT - 32)
        end
    elseif outOfBounds == 2 then -- East
        local newScene = LDtk.get_neighbours(CURRENT_SCENE, "east")[1]
        sceneFound = not(newScene == nil)
        if sceneFound then
            game.loadScene(newScene)
            player:moveTo(32, player.y )
        end
    elseif outOfBounds == 3 then -- south
        local newScene = LDtk.get_neighbours(CURRENT_SCENE, "south")[1]
        sceneFound = not(newScene == nil)
        if sceneFound then
            game.loadScene(newScene)
            player:moveTo(player.x, 32)
        end
    elseif outOfBounds == 4 then -- West
        local newScene = LDtk.get_neighbours(CURRENT_SCENE, "west")[1]
        sceneFound = not(newScene == nil)
        if sceneFound then
            game.loadScene(newScene)
            player:moveTo(SCENE_WIDTH - 32, player.y)
        end
    elseif sceneFound == false then
        print("No scene found in [" .. outOfBounds .. "] direction")
    end  
end

function getMovementInputVector()
    if pd.buttonIsPressed(pd.kButtonUp) then 
        player:move(0, -1)
    end
    if pd.buttonIsPressed(pd.kButtonDown) then 
        player:move(0, 1)
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then 
        player:move(-1, 0)
    end
    if pd.buttonIsPressed(pd.kButtonRight) then 
        player:move(1, 0)
    end

end