--[[ fairyHeal bot --]]
local fairyHeal = {}

-- Modules
local ptr = require("Modules/pointers")
local util = require("Modules/utility")
local cycle = require("Modules/cycle")
local keys = require("Modules/keys")
local cords = require("Modules/cords")

-- Variables
fairyHeal.level = ptr.getLevel()
fairyHeal.MyCharName = ptr.getCharName()
log("<<< "..fairyHeal.MyCharName.." is Starting... >>>")

function fairyHeal.heal()
		
	-- Use Healing Spell if Hp < 40%, Heal until is 80 +	
	if ptr.getTargetHp() <= util.getTargetHpPct(80) then
		log("Using Healing Spell...")
		while ptr.getTargetHp() <= util.getTargetHpPct(90) do
		fairyHeal.dead()
		send(keys.fairy.heal.healingspell) wait("2s")
		end
		wait(S)
		fairyHeal.dead()
		send(keys.fairy.heal.curespell) wait(S) log("Using Cure Spell...")
		end
end

function fairyHeal.teamName()
	left(cords.avatars.team1[1], cords.avatars.team1[2]) wait(MS)
	teamName = ptr.getTargetName()
	log("My Team name is: "..teamName)
end
	

function fairyHeal.follow()

	-- Follow Member
	while ptr.getTargetHp() >= util.getTargetHpPct(80) do
		send(keys.follow) wait(W)
		
		local currentTarget = ptr.getTargetName()
		-- log(currentTarget)
		if currentTarget == fairyHeal.MyCharName then 
			left(cords.avatars.team1[1], cords.avatars.team1[2]) wait(MS)
		end
		
		if util.isCharLowerThanHp(LOW_HP) then
			send(keys.selectyourself) wait(W)
			send(keys.fairy.heal.healingspell) wait("3s")
			send(keys.fairy.heal.curespell) wait(S)
			fairyHeal.cure()
		end			
			
	end
end

-- Main Function to Heal
function fairyHeal.cure()
			
	-- Cure Team Member	
	left(cords.avatars.team1[1], cords.avatars.team1[2]) wait(MS)
	fairyHeal.heal()
	fairyHeal.follow()

end

-- Check char is dead
function fairyHeal.dead()
	::Again::
	local ConditionB = "b"
	local hpJ = ptr.getHp() 
	if hpJ < 1 then
	wait(S) 
	log("Char "..fairyHeal.MyCharName, "is Dead !")
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
			if hpn < 1 then 
				goto Again 
			end
        log("Char "..fairyHeal.MyCharName, "is Live Again !")
        send(keys.selectyourself) wait(W)
		log("Recovering HP")
        send(keys.fairy.heal.healingspell) wait("3s")
        send(keys.fairy.heal.healingspell) wait("3s")
		send(keys.fairy.heal.healingspell) wait("4s")
		send(keys.fairy.heal.sunneedle) wait("3s")
        log("Char "..fairyHeal.MyCharName, "is in revive spot...") wait(S)
			
	end
end

-- Recover HP MP
function fairyHeal.recover()
	fairyHeal.dead()
	-- HP
	if util.isCharLowerThanHp(LOW_HP) then
		if ptr.isTargetSelected() then
			send("ESC")
			wait("2s")
			send(keys.selectyourself) wait(W)
			log("Recovering HP...")
			end			
		
	while ptr.getHp() < util.maxHp do 
		if ptr.isTargetSelected() then
			log("Darn it, someone is bothering me.") return
			end
			
		send(keys.fairy.heal.healingspell) wait("2s")
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
			log("Darn it, someone is bothering me.") return util.isCharLowerThanMana(LOW_MP)
			end
			
		wait(S)
    end
	log("Mana is full let's get to work.")          
	end
end

return fairyHeal
