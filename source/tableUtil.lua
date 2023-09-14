
function getTiledProperty(table, name)
    local props = table.properties
    if props  then
        for i = 1, #props do
            if props[i].name == name then
                return props[i].value
            end
        end
    end

    return nil
end