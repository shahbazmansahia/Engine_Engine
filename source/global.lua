-- playdate libraries
pd = playdate
gfx = playdate.graphics

-- object types
tPlayer = 1
tDoor = 2
tNPC = 3

-- databases
charactersDB = {};
doorsDB = {};

sMenu = 1
sExploring = 2
sDialogue = 3

-- scene info
CURRENT_SCENE = ""
SCENE_WIDTH = 0
SCENE_HEIGHT = 0

currentState = sMenu