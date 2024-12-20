--[[ Various sorts of utility --]]

local utility = {}

local ptr = require("Modules/pointers")
local keys = require("Modules/keys")
local cords = require("Modules/cords")

-- Line and mouse delay
linedelay(0)
mouseclickdelay(150)

-- Delais
MS = 100 W = 500 S = 1000

-- Character resources
utility.maxHp = ptr.getMaxHp()
utility.maxMana = ptr.getMaxMana()
utility.lowHp = LOW_HP and utility.maxHp * LOW_HP 
                        or utility.maxHp * 0.3 
						
utility.lowMana = LOW_MANA and utility.maxMana * LOW_MANA 
                        or utility.maxMana * 0.3

-- return avatar coordinates by team member name
function utility.getTeamMemberCoords(memberName)
	if memberName == ptr.getTeam1Name() then 
		return cords.avatars.TEAM1 
	end
	if memberName == ptr.getTeam2Name() then 
		return cords.avatars.TEAM2 
	end
	if memberName == ptr.getTeam3Name() then 
		return cords.avatars.TEAM3 
	end
	if memberName == ptr.getTeam4Name() then 
		return cords.avatars.TEAM4 
	end

end

-- Returns true if in battle via hp checking
function utility.battleCheck()
    local prevHp = ptr.getHp() wait(MS)
    if ptr.getHp() < prevHp then return true 
    else return false end
end



-- Returns target hp percentage 
function utility.getTargetHpPct(pct)
    -- Hp threshold goes from 460 to 597 resulting in 137 for max hp
    local hpMin = 460
    local hpMax = 137
    return hpMin + hpMax * (pct/100)
end

-- Returns true if char is lower than...
function utility.isCharLowerThanHp(hp)
    return ptr.getHp() <= (ptr.getMaxHp() * (hp)) and true or false 
end

-- Returns true if char is lower than...
function utility.isCharLowerThanMana(mp)
    return ptr.getMana() <= (ptr.getMaxMana() * (mp)) and true or false 
end

-- Returns true if target is lower than...
function utility.isTargetLowerThan(hp)
    local hp = hp * 100
    return ptr.getTargetHp() <= utility.getTargetHpPct(hp) and true or false
end

-- Sit if not sitting
function utility.sit()
    if ptr.isInBattle() then
		log("Battle status, unable to sit")
		wait(S)
	else
		log("Sitting...")
		send(keys.sit) wait(S)
		if not ptr.isSitting() then send(keys.sit) wait(MS) end
	end

end


return utility