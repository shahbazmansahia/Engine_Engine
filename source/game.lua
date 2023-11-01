-- Controls all gameplay logic

import 'events'
import 'player'
import 'npc'
import 'dialogue'
import 'sequence'

game = {}

local pd = playdate
local gfx = playdate.graphics

local scene

import "scene"

-- Must be called at the start of the game state
function game.start()
    charactersDB = convertJSONToTable('db_characters.json')
    currentSequence = convertJSONToTable('sequences/sequence01.json')
    --print(currentSequence.interactions[1].id)

    LDtk.load( "ldtkfiles/NativeWorld.ldtk"  )

    CURRENT_SCENE = "Level_0"
    
    player = Player(200,120)
    game.loadScene(CURRENT_SCENE)

    CURRENT_STATE = STATE_EXPLORING
end

-- Unloads the current scene, then loads the desired scene
function game.loadScene(sceneName)
    
    local previousLevel = CURRENT_SCENE
    CURRENT_SCENE = sceneName

    LDtk.load_level(sceneName) -- it is better to load first
    if not(previousLevel == sceneName) then
        LDtk.release_level(previousLevel)
    end
    
    if not(scene == nil) then
        scene:unload()
    end

    scene = Scene(CURRENT_SCENE)
    scene:draw()
    scene:loadEntities()
    --player.sprite:add()
end

-- Perform code every frame specific to current game state
function game.update()

    if CURRENT_STATE == STATE_MENU then
    elseif CURRENT_STATE == STATE_EXPLORING then
        getMovementInputVector()
    elseif CURRENT_STATE == STATE_DIALOGUE then
    else
        print("ERROR main.lua - Main in unknown state | currentState = " .. CURRENT_STATE )
    end

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

function pd.BButtonDown()
    if CURRENT_STATE == STATE_MENU then
    elseif CURRENT_STATE == STATE_EXPLORING then
    elseif CURRENT_STATE == STATE_DIALOGUE then
        event.EndConversation()
    end
end

function pd.AButtonDown()
    if CURRENT_STATE == STATE_MENU then
    elseif CURRENT_STATE == STATE_EXPLORING then
        player:checkForAction()
    elseif CURRENT_STATE == STATE_DIALOGUE then
        dialogue.continue()
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