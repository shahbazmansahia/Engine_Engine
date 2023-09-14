
-- Reads file, decodes JSON, and returns table
function convertJSONToTable(path)

    local levelData = nil;

    local f = playdate.file.open(path);
    if f then
        local byteSize = playdate.file.getSize(path);
        levelData = f:read(byteSize);
        f:close();

        if not levelData then
            print("-- ERROR: failed to parse file at " .. path);
            return nil;
        end
    else
        print("-- ERROR: Failed to find file at " .. path)
        return nil
    end

    
    local jsonTable = json.decode(levelData);

    if not jsonTable then
        print("-- ERROR: Failed to parse json data at " .. path);
        return nil;
    end

    return jsonTable;

end