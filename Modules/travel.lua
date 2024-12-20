--[[ Traveling around the map --]]

local travel = {}

local ptr = require("Modules/pointers")
local cords = require("Modules/cords")
local getX = ptr.getX
local getY = ptr.getY


-- Travels to a specified location via teleportation
function travel.teleport(to, xY)
    left(to[1], to[2]) wait(MS)
    while getX() ~= xY[1] or getY() ~= xY[2] do wait(MS) end
end 

-- Travels to a specified location via map
function travel.map(route)

    -- Open map
    if route.open then left(cords.map[1], cords.map[2]) wait(MS) end

    -- Destructuring
    local xY = route.node.xY
    local via = route.node.via

    -- Take path
    right(via[1], via[2]) wait(MS)
    while getX() ~= xY[1] or getY() ~= xY[2] do wait(10) end

    -- Close map
    if route.close then left(cords.map[1], cords.map[2]) wait(MS) end

    -- Wait for a delay
    if route.pause then wait(route.pause) end
end


-- Travels to a specific coordinate via mini-map
function travel.miniMap(xY)    

	while math.abs(getX() - xY[1]) > 1 and math.abs(getY() - xY[2]) > 1
    do  
        local x = getX() local y = getY()
        local via = {cords.move.stop[1], cords.move.stop[2]}
        local repos = {x - xY[1], y - xY[2]}

        -- Check the need of repositioning
        if repos[1] ~= 0 or repos[2] ~= 0 then
            -- X axis
            if repos[1] ~= 0 then via[1] = via[1] - repos[1] end
            -- Y axis
            if repos[2] ~= 0 then via[2] = via[2] + repos[2]end
            -- Travel
            right(via[1], via[2]) 

            -- While char is moving wait
            while true do
                wait(300)
                if math.abs(getX() - x) <= 1 and math.abs(getY() - y) <= 1 then
					break
				end
                x = getX() y = getY()
            end
        end
    end
    
    -- Reset cursor
    left(cords.mouseReset[1], cords.mouseReset[2]) wait(MS)
end


return travel

