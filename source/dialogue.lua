dialogue = {}

import "textbox"

local textBox

local textList = {
    "There is something old about this world",
    "I feel as if we are being watched"
}
local textIndex = 1


function dialogue.initDialogue(text)

    textIndex = 1
    textBox = Textbox()
    dialogue.getNextText()
end

-- should only be called by events.lua
-- (this is not obvious, perhaps a flaw in the architecture?)
function dialogue.stopDialogue()
    textBox:remove()
    textBox = nil
end

function dialogue.getNextText()

    if textIndex > #textList then
        dialogue.stopDialogue()
        eEndConversation()
        return
    end
    
    textBox:setText(textList[textIndex])
    textIndex = textIndex + 1
end