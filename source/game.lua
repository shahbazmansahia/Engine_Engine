game = {}

local pd = playdate
local gfx = playdate.graphics

function game.loadLevel()
    gfx.setColor(gfx.kColorBlack)

    -- Draw background. This can be imported from LDtk file
    local bgImage = gfx.image.new(400,240, gfx.kColorBlack) 
    local bg = gfx.sprite.new(bgImage)
    bg:moveTo(0, 0)
    bg:setCenter(0,0)
    bg:add()

    -- Basic example of loading LDtk file
    LDtk.load( "ldtkfiles/test.ldtk"  )
    local tilemap = LDtk.create_tilemap("Level_0", "Main")
    gfx.sprite.addWallSprites( tilemap, LDtk.get_empty_tileIDs( "Level_0", "Solid", "Main") )

    -- Create sprite and assign tilemap to it
    local sprite = gfx.sprite.new()
    sprite:setTilemap(tilemap)
    sprite:moveTo(0, 0)
    --sprite:setZIndex(-1) -- get from tilemap
    sprite:setCenter(0,0)
    sprite:setBounds(0, 0, 400, 240)
    sprite:add()  

    local charactersDB = convertJSONToTable('db_characters.json')
  

    -- Load Entities
    for index, entity in ipairs( LDtk.get_entities( "Level_0" ) ) do
        if entity.name=="NPC" then
            local cData = charactersDB[entity.fields.Name]
            if(cData == nil) then
                print("-- ERROR - Level:placeNPC() : Failed to find ".. entity.fields.Name .." in character database")
                return nil
            else
                npc1 = NPC(entity, cData)
            end
            
            --print(entity.fields.Name) -- Just sends console confirmation now
        end
    end

end