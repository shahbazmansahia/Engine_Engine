-- playdate libraries
pd = playdate
gfx = playdate.graphics

-- object types
TYPE_PLAYER = 1
TYPE_DOOR = 2
TYPE_NPC = 3

-- databases
charactersDB = {};
doorsDB = {};

-- game state
STATE_MENU = 1
STATE_EXPLORING = 2
STATE_DIALOGUE = 3

-- scene info
CURRENT_SCENE = ""
SCENE_WIDTH = 0
SCENE_HEIGHT = 0
CURRENT_STATE = STATE_MENU