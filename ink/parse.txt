--local savePath = "../source/dialogue"
local savePath = "C:/Users/colep/Documents/PlaydateSDK/Games/Engine_Engine/source/dialogue/"

local narrator = require('narrator.narrator')
-- Parse a Ink file at path 'stories/game.ink'
-- and save the book at path 'stories/game.lua'
local book = narrator.parse_file('test', savePath .. "test.lua", { save = true })
narrator.parse_file('Pilot2', savePath .. "Pilot2.lua", { save = true})