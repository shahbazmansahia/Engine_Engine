import "global"
import "dialogue"

function eOpenDoor(id)

    -- hmmmmm TODO
    -- break up level, other files may need to use file reading and json decoding
    -- make all dbs global
    --local door = doorsDB[id]
    --local linkedDoor = doorsDB[door.link]
    

    --loadLevel(door.level, linkedDoor.x, linkedDoor.y, linkedDoor.spawnDir)
end

function eStartConversation(id)
    
    -- check if conversation hasn't started

    --print("Hi " .. id)
    dialogue.initDialogue("hi")

    CURRENT_STATE = STATE_DIALOGUE
end

function eEndConversation()

    CURRENT_STATE = STATE_EXPLORING
    
end