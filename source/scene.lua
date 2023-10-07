//// Represents a single LDtk level and all of its objects within it.



scene = {}

layers = {}
collisions = {}

function scene.draw(scene)

    --playdate.graphics.sprite.removeAll()
    for layerName, layer in pairs(layers) do
        layers[layerName]:remove()
        gfx.sprite.removeSprites(collisions[layerName])
    end
    layers = {}
    collisions = {}

    
    for layerName, layer in pairs(LDtk.get_layers(scene)) do        
        if not layer.tiles then
			goto continue
		end

        local tilemap = LDtk.create_tilemap(scene, layerName)

		local layerSprite = playdate.graphics.sprite.new()
		layerSprite:setTilemap(tilemap)
		layerSprite:moveTo(0, 0)
		layerSprite:setCenter(0, 0)
		layerSprite:setZIndex(layer.zIndex)
		layerSprite:add()
        layers[layerName] = layerSprite

		local emptyTiles = LDtk.get_empty_tileIDs(scene, "Solid", layerName)

		if emptyTiles then
			collisions[layerName] = playdate.graphics.sprite.addWallSprites(tilemap, emptyTiles)
		end

        ::continue::
        
    end

    local sceneRect = LDtk.get_rect(scene)
    SCENE_WIDTH = sceneRect.width
    SCENE_HEIGHT = sceneRect.height

end
