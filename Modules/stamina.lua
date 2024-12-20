--[[ stamina bot --]]
local stamina = {}

-- Modules
local ptr = require("Modules/pointers")
local util = require("Modules/utility")
local cycle = require("Modules/cycle")
local keys = require("Modules/keys")
local cords = require("Modules/cords")
local Boss = require("Modules/bossList")
local skills = keys.stamina

-- Variables
stamina.level = ptr.getLevel()
stamina.MyCharName = ptr.getCharName()
log("<<< "..stamina.MyCharName.." is Starting... >>>")

-- Var unstuck logic 2
stamina.stuckCount = 0

-- sending tab
function stamina.Tab()
::TAB::
	send("tab", 100)
	if ptr.isTargetSelected() then
		log("Target Found!")
		else
		log("Target not Found! Searching...")
		goto TAB
	end
end

-- Attacking
function stamina.kill()
	-- Unstick variable logic 1
    local stickness = 0 
    local stuck = 60
	
    local kill = nil
	
    -- Kill target
    log("Killing...")

    while not ptr.isTargetDead() and ptr.isTargetSelected() 
    do 
        kill = 1
        -- If target is healthy use strong attack
        if ptr.getTargetHp() >= util.getTargetHpPct(45) then
            send(skills.strong) wait(MS)
			else
			send(skills.weak) wait(MS)
			send(skills.stun) wait(MS)
        end
        
        -- If char gets stuck, unstick with logic 1
        if stickness >= stuck then
			if stamina.stuckCount == 4 then
				stamina.gotospot()
                stamina.stuckCount = 0
			else
				log("Unstucking, Getting a new target...")
				stamina.stuckCount = stamina.stuckCount + 1
				stamina.Tab(true)
				return stamina.kill()			
			end
        end
		
		-- Checking if the target is a Boss and attacking
		local targetName = ptr.getTargetName()
		if Boss.verify(targetName) then
			log("Killing boss "..targetName)
			while not ptr.isTargetDead() do
				send(skills.strong)
				wait(MS)
			end
		end
		
        -- Stuck logic 1
        if ptr.isTargetHpFull() then stickness = stickness + 1  end
		--log(stickness) -- log for tests
		
		stamina.dead()
    end

    if kill then KILLS = KILLS + 1 end
    log("clear") log("Kill count: ", KILLS)

end
	

function stamina.waituntilfarmspot()
	local countspot = 0 
    local prevX, prevY
    while true do
        local x = ptr.getX()
        local y = ptr.getY()
        --log(x, y)
        if prevX == x and prevY == y then
            countspot = countspot + 1
            if countspot >= 3 then
				send("Tab") wait(500)
				if ptr.isTargetSelected() then
					log("Ready to start again !!! ")
					break
					else
					return stamina.gotospot()	
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
function stamina.gotospot()
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
    stamina.waituntilfarmspot()
	
    return
	
    end
    end
end

-- Check char is dead
function stamina.dead()
	local ConditionB = "b"
	local hpJ = ptr.getHp() 
	if hpJ < 1 then
	wait(S) 
	log("Char "..stamina.MyCharName, "is Dead !")
	wait(S)
	if ConditionB ~= nil then
		for i = 1, #ConditionB
		do
		log("Trying to use Jackstraw")
		left(cords.revive.jackstrawok[1], cords.revive.jackstrawok[2]) wait("3s")
		end
		end
        local hpn = ptr.getHp() 
		if hpn < 1 then
			log("Jackstraw not found, Reviving normal...")
            left(cords.revive.okbutton[1], cords.revive.okbutton[2]) wait("3s")
            end
        log("Char "..stamina.MyCharName, "is Live Again !")
        util.sit()
		log("Sitting to recover HP")
        wait("20s")
        log("Char "..stamina.MyCharName, "is Returning to Battle !")
		stamina.gotospot()	
	end
end

-- Recover HP
function stamina.recover()
	stamina.dead()
	if util.isCharLowerThanHp(LOW_HP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			end	
			
	util.sit()
	log("Recovering HP...")
	send(keys.pots.hp) wait("1s")
		
	while ptr.getHp() < util.maxHp do 
		if not ptr.isSitting() then send(keys.sit) wait(MS) end
		if ptr.isTargetSelected() then
			log("Darn it, someone is bothering me.") return
			end			
		wait(S)
    end
	log("Hp is full let's get to work.") 
	end
	
	-- HP in Battle
	--if util.isCharLowerThanHp(LOW_HP_IN_BATTLE) then
		--("Ustaminag HP recover in battle...")
		--send(keys.pots.hp) wait(MS) 
	--end
	
	
end

return stamina
