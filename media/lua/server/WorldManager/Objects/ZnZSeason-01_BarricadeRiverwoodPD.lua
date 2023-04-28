PlaceWindowBarricades = {};

function PlaceWindowBarricades.onloadgs(sq)
    local modData = sq:getModData();
    if (not modData["BarricadeRiverwoodPD:isBarricaded"]) then
        local sqCoordinates = { x = sq:getX(), y = sq:getY(), z = sq:getZ() };

        if sqCoordinates.x > 6070 and sqCoordinates.x < 6095 and sqCoordinates.y > 5250 and sqCoordinates.y < 5270 then
            print("Checking square " .. sqCoordinates.x .. ", " .. sqCoordinates.y .. ", " .. sqCoordinates.z);
            local tileIsoObjects = sq:getObjects();
            local numberTileIsoObjects = tileIsoObjects:size();

            for i = 0, numberTileIsoObjects - 1 do
                local tileIsoObject = tileIsoObjects:get(i);

                if tileIsoObject and instanceof(tileIsoObject, "IsoWindow") then
                    print("Found window at " .. sqCoordinates.x .. ", " .. sqCoordinates.y .. ", " .. sqCoordinates.z)
                    local coordinates = { x = tileIsoObject:getX(), y = tileIsoObject:getY(), z = tileIsoObject:getZ() };

                    if not tileIsoObject:isBarricaded() then
                        print("Placing barricade at " .. coordinates.x .. ", " .. coordinates.y .. ", " .. coordinates.z);
                        tileIsoObject:addBarricadesDebug(2, false);
                    end
                end

                if tileIsoObject and instanceof(tileIsoObject, "IsoDoor") and tileIsoObject:isExterior() then
                    print("Found door at " .. sqCoordinates.x .. ", " .. sqCoordinates.y .. ", " .. sqCoordinates.z);
                    local oppositeSquare = tileIsoObject:getOppositeSquare()
                    if oppositeSquare:getRoom() then
                        print("Found room at " ..
                        oppositeSquare:getX() .. ", " .. oppositeSquare:getY() .. ", " .. oppositeSquare:getZ());
                        local cabinet = IsoObject.new(oppositeSquare, "location_business_office_generic_01_16", false);
                        cabinet:createContainersFromSpriteProperties();
                        oppositeSquare:AddSpecialObject(cabinet);
                        if isClient() then cabinet:transmitCompleteItemToServer() end
                        triggerEvent("OnObjectAdded", cabinet)
                    else
                        local square = tileIsoObject:getSquare()
                        print("Found room at " .. square:getX() .. ", " .. square:getY() .. ", " .. square:getZ());
                        local cabinet = IsoObject.new(square, "location_business_office_generic_01_16", false);
                        cabinet:createContainersFromSpriteProperties();
                        square:AddSpecialObject(cabinet);
                        if isClient() then cabinet:transmitCompleteItemToServer() end
                        triggerEvent("OnObjectAdded", cabinet)
                    end
                end
            end
        end

        modData["BarricadeRiverwoodPD:isBarricaded"] = true;
    end
end

Events.LoadGridsquare.Add(PlaceWindowBarricades.onloadgs);
