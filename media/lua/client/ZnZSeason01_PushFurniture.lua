ISWorldMenuElements = ISWorldMenuElements or {}

function PushFurniture(item, newSquare)
    print("pushing furniture");
    item:setX(newSquare:getX());
    item:setY(newSquare:getY());
end

function ISWorldMenuElements.ContextPush()
    local self = ISMenuElement.new();

    function self.init()
    end

    function self.createMenu(_data)
        for _, item in ipairs(_data.objects) do
            print("creating menu");
            local square = item:getSquare();
            local type = item:getType();
            print("type: " .. type)
            if square then
                print("found item square");
                local moveProps = ISMoveableSpriteProps.fromObject(item);
                if moveProps and instanceof(item, "IsoObject") then
                    print("found moveable item from props");
                    local playerCoordinates = { x = _data.player:getX(), y = _data.player:getY() };
                    local itemCoordinates = { x = square:getX(), y = square:getY() };
                    local isPlayerTouching = math.floor(playerCoordinates.x) == itemCoordinates.x + 1 or
                        math.floor(playerCoordinates.x) == itemCoordinates.x - 1 or
                        math.floor(playerCoordinates.y) == itemCoordinates.y + 1 or
                        math.floor(playerCoordinates.y) == itemCoordinates.y - 1;
                    print("playerCoordinates: " .. playerCoordinates.x .. ", " .. playerCoordinates.y)
                    print("itemCoordinates: " .. itemCoordinates.x .. ", " .. itemCoordinates.y)
                    print("isPlayerTouching: " .. tostring(isPlayerTouching));
                    local xDiff = math.floor(playerCoordinates.x) - itemCoordinates.x;
                    local yDiff = math.floor(playerCoordinates.y) - itemCoordinates.y;
                    local direction;
                    if yDiff == -1 then
                        direction = IsoDirections.S;
                    elseif yDiff == 1 then
                        direction = IsoDirections.N
                    elseif xDiff == -1 then
                        direction = IsoDirections.E
                    elseif xDiff == 1 then
                        direction = IsoDirections.W
                    end

                    if direction then
                        print("found direction")

                        local newSquare = square:getAdjacentSquare(direction);

                        local option = _data.context:addOption(getText("Push"), _data, self.push, item);
                        print("added option");

                        option.notAvailable = (not isPlayerTouching and not newSquare:isNotBlocked());
                    end
                end
            end
        end
    end

    function self.push(_data, item)
        print("push");
        local square = item:getSquare();
        local playerCoordinates = { x = _data.player:getX(), y = _data.player:getY() };
        local itemCoordinates = { x = square:getX(), y = square:getY() };
        local isPlayerTouching = math.floor(playerCoordinates.x) == itemCoordinates.x + 1 or
            math.floor(playerCoordinates.x) == itemCoordinates.x - 1 or
            math.floor(playerCoordinates.y) == itemCoordinates.y + 1 or
            math.floor(playerCoordinates.y) == itemCoordinates.y - 1;
        print("playerCoordinates: " .. playerCoordinates.x .. ", " .. playerCoordinates.y)
        print("itemCoordinates: " .. itemCoordinates.x .. ", " .. itemCoordinates.y)
        print("isPlayerTouching: " .. tostring(isPlayerTouching));
        local xDiff = math.floor(playerCoordinates.x) - itemCoordinates.x;
        local yDiff = math.floor(playerCoordinates.y) - itemCoordinates.y;
        local direction;
        if yDiff == -1 then
            direction = IsoDirections.S;
        elseif yDiff == 1 then
            direction = IsoDirections.N
        elseif xDiff == -1 then
            direction = IsoDirections.E
        elseif xDiff == 1 then
            direction = IsoDirections.W
        end

        if direction then
            print("found direction")

            local newSquare = square:getAdjacentSquare(direction);
            if instanceof(item, "IsoMovingObject")
                and isPlayerTouching
                and newSquare:isNotBlocked(true) then
                ISTimedActionQueue.add(PushFurniture(item, newSquare));
            end
            print("add push to times acctions");
        end
    end

    return self;
end
