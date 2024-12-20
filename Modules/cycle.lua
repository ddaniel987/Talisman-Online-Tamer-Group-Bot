--[[ Cyclical actions --]]
local cycle = {}

local keys = require("Modules/keys")
local cords = require("Modules/cords")
local deleter = require("Modules/items").delete
local ptr = require("Modules/pointers")

-- Adds a new cyclical action to a table
function cycle.add(action, interval, name, t)

    -- Default table of actions
    t = t and t or ACTIONS

    -- Convert period to seconds
    interval = interval * 60

    -- Add new cycle to a table
    -- [1] action (the function)
    -- [2] interval in seconds
    -- [3] when the next cycle should occur
    table.insert(t, {action, interval, os.clock(), name})
end

-- Execute all cycles in accordance to their intervals
function cycle.exec(cycles)
    local clock = os.clock()
    for key, val in pairs(cycles)
    do  
        if clock >= val[3] then
            log("Executing " .. val[4] .. "...")
            val[1]() -- execute cycle
            val[3] = clock + val[2] -- update interval
        end
    end
end

function cycle.petFood()
    wait(S) send(keys.petFood) wait(S)
end

function cycle.buffUp()
    send(keys.buff) wait(S)
	send(keys.tamer.petBuff) wait(S) -- buff
	send(keys.tamer.petBuff2) wait(S) -- buff 2
	send(keys.tamer.petBuff3) wait(S) -- buff 3
	send(keys.tamer.petBuff4) wait(S) -- buff 4
end

function cycle.petHeal()
    send(keys.tamer.petHeal) wait(S)
end

function cycle.fairybuffUp()
	send(keys.selectyourself) wait(S)
    send(keys.fairy.heal.sunneedle) wait(S)
end

function cycle.fairyTeambuffUp()
	left(cords.avatars.team1[1], cords.avatars.team1[2]) wait(S)
    send(keys.fairy.heal.sunneedle) wait(S)
end

function cycle.reportCharHP()
	local charName = ptr.getCharName()
	local currHp = ptr.getHp()
	local maxHp = ptr.getMaxHp()
	local hpPerc = math.floor(currHp / maxHp * 100)
	local file = io.open("chars/" .. charName .. ".txt", "w")
	file:write(hpPerc)
    file:close()
end

-- Default periodic actions
ACTIONS = {}
if PET_FOOD_DELAY then cycle.add(cycle.petFood, PET_FOOD_DELAY, "pet food") end
if DELETER_DELAY then cycle.add(deleter, DELETER_DELAY, "deleter") end
if BUFF_DELAY then cycle.add(cycle.buffUp, BUFF_DELAY, "buff") end
if FAIRY_BUFF_DELAY then cycle.add(cycle.fairybuffUp, FAIRY_BUFF_DELAY, "buff") end
if FAIRY_TEAM_BUFF_DELAY then cycle.add(cycle.fairyTeambuffUp, FAIRY_TEAM_BUFF_DELAY, "buff team") end
if PET_HEAL_DELAY then cycle.add(cycle.petHeal, PET_HEAL_DELAY, "Healing pet") end
cycle.add(cycle.reportCharHP, 0.01, "report hp")

return cycle
