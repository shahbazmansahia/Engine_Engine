dialogue = {}

import "textbox"

-- We need a better way to do this
local book = 
import "dialogue/test"

local story

local textBox
local textQueue = {}
local textQueueLength = 0
local textIndex = 1
local maxCharacters = 150


function dialogue.initDialogue(text)
    story = narrator.init_story(book)
    dialogueEnded = false
    textIndex = 1
    textQueueLength = 0
    textQueue = {}
    textBox = Textbox()

    story:begin()
    dialogue.getNextText()
end

-- should only be called by events.lua
-- (this is not obvious, perhaps a flaw in the architecture?)
function dialogue.stopDialogue()
    textBox:remove()
    textBox = nil
end

-- Called when player makes a choice or wants to read next text
function dialogue.continue()
  if textBox.displayingChoices then
    story:choose(textBox:getCurrentSelectedRow())

    textBox:hideChoices()
    dialogue.getNextText()
  else
    dialogue.getNextText()
  end
end

function dialogue.getNextText()
  if textIndex < textQueueLength 
  then
    textBox:setText(textQueue[textIndex])
    textIndex = textIndex + 1

  elseif story:can_choose() 
  then
    local choices = story:get_choices()
    for i, choice in ipairs(choices) do
      choices[i] = choice.text
    end
    textBox:displayChoices(choices)

  elseif story:can_continue() 
  then
    local paragraphs = story:continue()
    local batchCount = 1

    for _, paragraph in ipairs(paragraphs) do
      local text = paragraph.text         
      if string.len(text) > maxCharacters then       
        local adjustedText = dialogue.splitString(text)
        for i = 1, #adjustedText, 1 do
          textQueue[batchCount] = adjustedText[i]
          batchCount = batchCount + 1
        end
      else
        textQueue[batchCount] = text
        batchCount = batchCount + 1
      end 
    end

    textIndex = 1
    textQueueLength = batchCount
    textBox:setText(textQueue[textIndex])
    textIndex = textIndex + 1

  else
    eEndConversation()
  end
end

function dialogue.splitString(inputString)
  local words = {}
  for word in inputString:gmatch("%S+") do
      table.insert(words, word)
  end

  local result = {}
  local currentLine = ""
  for i, word in ipairs(words) do
      if #currentLine + #word + 1 <= maxCharacters-3 then
          if #currentLine > 0 then
              currentLine = currentLine.." "..word
          else
              currentLine = word
          end
      else
          table.insert(result, currentLine .. "...") -- "..." to end of a split segment.
          currentLine = word
      end
  end
  if #currentLine > 0 then
      table.insert(result, currentLine)
  end

  return result
end