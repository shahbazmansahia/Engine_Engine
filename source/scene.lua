-- Represents a single LDtk level and all of its objects within it.



class("Scene").extends(Object)


function Scene:init(sceneName)
    self.name = sceneName 

    self.layers = {}
    self.collisions = {}
    self.entities = {}


end

-- Scenes must be unloaded before destroyed
-- Removes all sprites and entities created by this scene
function Scene:unload()

    for entityName in pairs(self.entities) do
        self.entities[entityName]:remove()
    end

    for layerName, layer in pairs(self.layers) do
        self.layers[layerName]:remove()
        gfx.sprite.removeSprites(self.collisions[layerName])
    end
end

-- Called once; Draws the LDtk level
function Scene:draw()

    --playdate.graphics.sprite.removeAll()

    for layerName, layer in pairs(LDtk.get_layers(self.name)) do        
        if not layer.tiles then
			goto continue
		end

        local tilemap = LDtk.create_tilemap(self.name, layerName)

		local layerSprite = playdate.graphics.sprite.new()
		layerSprite:setTilemap(tilemap)
		layerSprite:moveTo(0, 0)
		layerSprite:setCenter(0, 0)
		layerSprite:setZIndex(layer.zIndex)
		layerSprite:add()
        self.layers[layerName] = layerSprite

		local emptyTiles = LDtk.get_empty_tileIDs(self.name, "Solid", layerName)

		if emptyTiles then
			self.collisions[layerName] = gfx.sprite.addWallSprites(tilemap, emptyTiles)
		end

        ::continue::
        
    end

    local sceneRect = LDtk.get_rect(self.name)
    SCENE_WIDTH = sceneRect.width
    SCENE_HEIGHT = sceneRect.height
    


end

-- Called once; Loads all entities found in the current LDtk level
function Scene:loadEntities()

        for index, entity in ipairs( LDtk.get_entities(self.name) ) do
            if entity.name=="NPC" then
                local cData = charactersDB[entity.fields.Name]
                if(cData == nil) then
                    print("-- ERROR - Scene:loadEntities() : Failed to find ".. entity.fields.Name .." in character database")
                    return nil
                else
                    local e = NPC(entity, cData)
                    self.entities[e.id] = e
                    print("npc")
                end
                
                --print(entity.fields.Name) -- Just sends console confirmation now
            end
        end
end
