sequence = {}

function sequence.CheckForDialogueOverride(id)

    local interactions = currentSequence.interactions

    for i = 1, #interactions, 1 do
        if interactions[i].id == id then
            return interactions[i].dialogue[1].path
        end
    end
    
end