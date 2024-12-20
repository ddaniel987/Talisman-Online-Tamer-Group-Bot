--[[ Fairy Atk bot --]]
local fairyAtk = {}

-- Modules
local ptr = require("Modules/pointers")
local util = require("Modules/utility")
local cycle = require("Modules/cycle")
local keys = require("Modules/keys")
local cords = require("Modules/cords")
local skills = keys.fairy

-- Variables
fairyAtk.level = ptr.getLevel()
fairyAtk.MyCharName = ptr.getCharName()
log("<<< "..fairyAtk.MyCharName.." is Starting... >>>")

-- sending tab
function fairyAtk.Tab()
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
function fairyAtk.kill()

	-- Unstick variable
    local stickness = 0
    local stuck = 50
    local kill = nil
	
    -- Kill target
    log("Killing...")

    while not ptr.isTargetDead() and ptr.isTargetSelected() 
    do 
        kill = 1
		
		if ptr.getTargetName() == ptr.getCharName() then 
			send("Tab", 100)
		end
		
        -- If target is healthy use strong attack
        if ptr.getTargetHp() > util.getTargetHpPct(55) then
			send(skills.atk.lotus) wait(MS)
            send(skills.atk.strong) wait(MS)			
			send(skills.atk.stun) wait(MS)
			else		
			send(skills.atk.weak) wait(MS)
        end
        
        -- If char gets stuck, unstick
        if stickness >= stuck then
            log("Unstucking, Getting a new target...")
            fairyAtk.Tab(true)
            return fairyAtk.kill()
        end
		

        -- Stuck logic
        if ptr.isTargetHpFull() then stickness = stickness + 1  end
		fairyAtk.dead()
    end

    if kill then KILLS = KILLS + 1 end
    log("clear") log("Kill count: ", KILLS)

end

function fairyAtk.waituntilfarmspot()
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
					return fairyAtk.gotospot()	
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
function fairyAtk.gotospot()
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
    fairyAtk.waituntilfarmspot()
    return
    end
    end
end

-- Check char is dead
function fairyAtk.dead()
	local ConditionB = "b"
	local hpJ = ptr.getHp() 
	if hpJ < 1 then
	wait(S) 
	log("Char "..fairyAtk.MyCharName, "is Dead !")
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
        log("Char "..fairyAtk.MyCharName, "is Live Again !")
        send(keys.selectyourself) wait(W)
		log("Recovering HP")
        send(skills.heal.healingspell) wait("2s")
        send(skills.heal.healingspell) wait("2s")
		send(skills.heal.healingspell) wait("2s")
		send(keys.fairy.heal.sunneedle) wait("2s")
        log("Char "..fairyAtk.MyCharName, "is Returning to Battle !")
		fairyAtk.gotospot()	
	end
end

-- Recover HP MP
function fairyAtk.recover()
	fairyAtk.dead()
	-- HP
	if util.isCharLowerThanHp(LOW_HP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			send(keys.selectyourself) wait(W)
			log("Recovering HP...")
			end			
	
	local mXHP = util.maxHp - 10
	while ptr.getHp() <= mXHP  do 
		if ptr.isInBattle() then 
			log("Darn it, someone is bothering me.")
			return fairyAtk.kill()
		end
		send(keys.selectyourself) wait(100)
		send(skills.heal.healingspell) wait(100)
		--log(util.maxHp, mXHP)
    end
	log("Hp is full let's get to work.")          
	end
	
	-- MP
	if util.isCharLowerThanMana(LOW_MP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			util.sit()
			log("Recovering MP...")
			end		
		
	while ptr.getMana() < util.maxMana do 
		if not ptr.isSitting() then send(keys.sit) wait(MS) end
		if ptr.isTargetSelected() then
			log("Darn it, someone is bothering me.") return 
			end
			
		wait(S)
    end
	log("Mana is full let's get to work.")          
	end
end

return fairyAtk
