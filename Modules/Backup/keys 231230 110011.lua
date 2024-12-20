--[[ In-game key bindings --]]

local keys = {}

keys.sit = "8"
keys.selectyourself = "f1"

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

keys.fairy = {
	atk = {
		strong = 2,
		weak = 1,
		lotus = 3,
		stun = 4
	},	
	heal = {
		curespell = "f2",
		healingspell = "f3",
		sunneedle = "f4"
		}   
}

return keys