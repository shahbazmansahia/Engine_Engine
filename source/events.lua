
import "dialogue"

event = {}

function event.OpenDoor(id)

    -- hmmmmm TODO
    -- break up level, other files may need to use file reading and json decoding
    -- make all dbs global
    --local door = doorsDB[id]
    --local linkedDoor = doorsDB[door.link]
    

    --loadLevel(door.level, linkedDoor.x, linkedDoor.y, linkedDoor.spawnDir)
end

function event.StartConversation(id)
    
    -- check if conversation hasn't started

    --local path = sequence.CheckForDialogueOverride(id)
    local path = "dialogue/test"
    --local path = "dialogue/Pilot2"
    --print(path)

    dialogue.initDialogue(path)

    CURRENT_STATE = STATE_DIALOGUE
end

function event.EndConversation()
    dialogue.stopDialogue()
    CURRENT_STATE = STATE_EXPLORING
    
end