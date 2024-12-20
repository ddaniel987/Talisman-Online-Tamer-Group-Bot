--[[ In-game key bindings --]]

local keys = {}

keys.sit = "x"
keys.selectyourself = "f1"
keys.follow = "p"

keys.inventory = "i"
keys.map = "m"

keys.pots = {
    hp = 5, mana = 6
}

keys.petFood = 0

keys.buff = 9

keys.stamina = {
    strong = 2,
    weak = 1,
	stun = 4
}

keys.mana = {
    strong = 1,
    weak = 2,
    aoe = 3
}

keys.tamer = {
    strong = 1,
    weak = 2,
    aoe = 3,
	petAtk = "E",
	petHeal = 4,
	petBuff = 7,
	petBuff2 = 7,
	petBuff3 = 7,
	petBuff4 = 7
}

keys.fairy = {
	atk = {
		strong = 3,
		weak = 3,
		lotus = 4,
		stun = 3
	},	
	heal = {
		curespell = "f2",
		healingspell = "f3",
		sunneedle = "f4"
		}   
}

return keys