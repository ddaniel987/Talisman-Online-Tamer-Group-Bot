--[[ mana bot --]]
local mana = {}

-- Modules
local ptr = require("Modules/pointers")
local util = require("Modules/utility")
local cycle = require("Modules/cycle")
local keys = require("Modules/keys")
local cords = require("Modules/cords")
local Boss = require("Modules/bossList")
local travel = require("Modules/travel")
local bot = require("Modules/bot")
local config = require("Modules/CONFIG")
local skills = keys.mana
local logger = require("Modules/logger") --logger

-- Variables
mana.level = ptr.getLevel()
mana.MyCharName = ptr.getCharName()
logger.say("<<< "..mana.MyCharName.." is Starting... >>>")

-- sending tab
function mana.Tab()
::TAB::
	send("tab", 100)
	if ptr.isTargetSelected() and ptr.getTargetName() ~= config.Fay then
		logger.say("Target Found!")
		else
		logger.say("Target not Found! Searching...")
		goto TAB
	end
end

function mana.getFayCoords()
	local lastPosFile = io.open("fayPos.txt", "r")
	local coords = lastPosFile:read("*all")
	lastPosFile:close()
	local x, y = coords:match("(-?%d+),(-?%d+)")
	
	return {tonumber(x), tonumber(y)}
end

-- Attacking
function mana.kill()
	-- Unstick variable
    local stickness = 0
    local stuck = 10
    local kill = nil
	
    -- Kill target
    logger.say("Killing...")

    while not ptr.isTargetDead() and ptr.isTargetSelected() and ptr.getTargetName() ~= config.Fay
    do 
        kill = 1
        -- If target is healthy use strong attack
        if ptr.getTargetHp() >= util.getTargetHpPct(60) then
            send(skills.strong) wait(1500)
			send(skills.aoe) wait(MS)
			else
			send(skills.weak) wait(MS)
        end
        
        -- If char gets stuck, unstick
        if stickness >= stuck then
            logger.say("Unstucking, Getting a new target...")
            mana.Tab(true)
            return mana.kill()
        end
		
		-- Checking if the target is a Boss and attacking
		local targetName = ptr.getTargetName()
		if Boss.verify(targetName) then
			logger.say("Killing boss "..targetName)
			while not ptr.isTargetDead() do
				send(skills.strong) wait(MS)
				send(skills.weak) wait(MS)
				mana.dead()
			end
		end
		

        -- Stuck logic
        if ptr.isTargetHpFull() then stickness = stickness + 1  end
		mana.dead()
    end

    if kill then KILLS = KILLS + 1 end
	
	--check if we got far
	local fayCo = mana.getFayCoords()
	if tonumber(fayCo[1]) ~= nil and tonumber(fayCo[2]) ~= nil then
		if math.abs(ptr.getX() - fayCo[1]) >= 1 and math.abs(ptr.getY() - fayCo[2]) >= 1 then --5 coord range
			logger.say("Killed. Heading to fay")
			left(25,204)
			local lX = ptr.getX()
			local lY = ptr.getY()
			send("p") wait(1000)
			if lX == ptr.getX() and lY == ptr.getY() and math.abs(ptr.getX() - fayCo[1]) >= 5 and math.abs(ptr.getY() - fayCo[2]) >= 5 then --if too far from fay, resort to minimap
				logger.say("Fay is too far. Resolving to minimap")
				travel.miniMap(mana.getFayCoords()) wait(1000)
			end
		end
	end
	
	mana.Tab(true) --next target
end

function mana.waituntilfarmspot()
	local countspot = 0 
    local prevX, prevY
    while true do
        local x = ptr.getX()
        local y = ptr.getY()
        --logger.say(x, y)
        if prevX == x and prevY == y then
            countspot = countspot + 1
            if countspot >= 3 then
                send("Tab") wait(500)
				if ptr.isTargetSelected() then
					logger.say("Ready to start again !!! ")
					break
					else
					return mana.gotospot()	
				end
            end
        else
            countspot = 0
        end
        prevX, prevY = x, y 
        wait(S)
    end
end

-- Go to Spot if dead
function mana.gotospot()
	send(keys.map) wait(S)
	local Condition = "a"
	if Condition ~= nil then
    for i = 1, #Condition
    do
	-- Reset star point in map
    right(SPOT_FARM[1] + 20, SPOT_FARM[2] + 20)
	wait(500)
	-- Spot farm
	right(SPOT_FARM[1], SPOT_FARM[2])
	wait(500)
	send(keys.map) wait(S)
	-- Wait until coords = SPOT_FARM cords
    mana.waituntilfarmspot()
    return
    end
    end
end

-- Check char is dead
function mana.dead()
	local ConditionB = "b"
	local hpJ = ptr.getHp() 
	if hpJ < 1 then
	wait(S) 
	logger.say("Char "..mana.MyCharName, "is Dead !")
	wait(S)
	if ConditionB ~= nil then
		for i = 1, #ConditionB
		do
		logger.say("Trying to use Jackstraw")
		left(cords.revive.jackstrawok[1], cords.revive.jackstrawok[2]) wait("3s")
		end
		end
        local hpn = ptr.getHp() 
		if hpn < 1 then
			logger.say("Jackstraw not found, Reviving normal...")
            left(cords.revive.okbutton[1], cords.revive.okbutton[2]) wait("3s")
            end
        logger.say("Char "..mana.MyCharName, "is Live Again !")
        util.sit()
		logger.say("Sitting to recover HP")
		send(keys.pots.hp) wait("1s")
        wait("20s")
        logger.say("Char "..mana.MyCharName, "is Returning to Battle !")
		mana.gotospot()	
	end
end

-- Recover HP MP
function mana.recover()
	mana.dead()
	-- HP
	if util.isCharLowerThanHp(LOW_HP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			util.sit()
			logger.say("Recovering HP...")
			send(keys.pots.hp) wait("1s")
			end			
		
	while ptr.getHp() < util.maxHp do 
		if not ptr.isSitting() then send(keys.sit) wait(MS) end
		if ptr.isTargetSelected() then
			logger.say("Darn it, someone is bothering me.") return 
			end
			
		wait(S)
    end
	logger.say("Hp is full let's get to work.")          
	end
	
	-- MP
	if util.isCharLowerThanMana(LOW_MP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			util.sit()
			logger.say("Recovering MP...")
			send(keys.pots.mana) wait("1s")
			end		
		
	while ptr.getMana() < util.maxMana do 
		if not ptr.isSitting() then send(keys.sit) wait(MS) end
		if ptr.isTargetSelected() then
			logger.say("Darn it, someone is bothering me.") return 
			end
			
		wait(S)
    end
	logger.say("Mana is full let's get to work.")          
	end
	
	-- MP in Battle
	--if util.isCharLowerThanMana(LOW_MP_IN_BATTLE) then
		--logger.say("Using Mana recover in battle...")
		--send(keys.pots.mana) wait(MS) 
	--end
end


return mana
