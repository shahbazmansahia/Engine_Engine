

local narrator = require('narrator.narrator')
-- Parse a Ink file at path 'stories/game.ink'
-- and save the book at path 'stories/game.lua'
local book = narrator.parse_file('test', { save = true })