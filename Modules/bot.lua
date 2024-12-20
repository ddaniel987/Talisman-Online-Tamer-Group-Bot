--[[ Bot main module --]]

local bot = {}

local ptr = require("Modules/pointers")
local cycle = require("Modules/cycle")
local util = require("Modules/utility")
local keys = require("Modules/keys")
local travel = require("Modules/travel")
local cords = require("Modules/cords")

bot.SAFE_SPOT = {0,0}

-- Gets a desired target 
function bot.getTarget(farway)

    -- Get target
    log("Let's get a target to kill")
    while not ptr.isTargetSelected() or ptr.isTargetDead() or farway do
        send("tab") wait(MS)
        -- Sit if no mobs around
        --util.sit()
        if farway then break end
    end

end

function bot.getReady(char)

	for i = 1, 5 do
		left(cords.minimize[1], cords.minimize[2]) wait(50) 
	end

	SAFE_SPOT = {ptr.getX(), ptr.getY()} 
	wait(500)
	
	for i = 1, 6 do
		left(cords.minimap.zoomIn[1], cords.minimap.zoomIn[2])
		wait(10)
	end
	
	if GET_BACK == "ON" then
		log("GET_BACK mode is ON")
		-- Add get back delayed action
		if GET_BACK_DELAY then
			cycle.add(function() travel.miniMap(SAFE_SPOT) end,
						GET_BACK_DELAY, "Going back...")
		end
	else
		log("GET_BACK mode off")
	end

end

-- Main function
function bot.start(char)

    -- Execute cycles
    cycle.exec(ACTIONS)

    -- Get a target
	::TARGET::
    bot.getTarget()
	
	if KILL_SANTA == "NO" and ptr.getTargetName() == "Santa Mushroom" then 
		send("Tab", 100)
		goto TARGET 
	end
	
	if ptr.getTargetName() == ptr.getCharName() then 
		send("Tab", 100)
	end
    
    -- Kill target
    char.kill()

    -- Reload character resources
    if char.level ~= ptr.getLevel() then
        wait(W)
        util.maxHp = ptr.getMaxHp()
		wait(W)
		util.maxMana = ptr.getMaxMana()
		wait(W)
        char.level = ptr.getLevel()
    end
	
	char.recover()
end

function bot.heal(char)

	-- Execute cycles
    cycle.exec(ACTIONS)
	
	-- Heall target
    char.cure()

    -- Reload character resources
    if char.level ~= ptr.getLevel() then
        wait(MS)
        util.maxHp = ptr.getMaxHp()
		util.maxMana = ptr.getMaxMana()
        char.level = ptr.getLevel()
    end
end

return bot