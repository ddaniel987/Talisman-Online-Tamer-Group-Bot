--[[ In-game key bindings --]]

local keys = {}

keys.follow = "p"
keys.sit = "8"

keys.inventory = "i"
keys.friends = "f"
keys.map = "m"

keys.pots = {
    hp = 5, mana = 6
}

keys.petFood = 0

keys.buff = 9  -- skill buff

keys.stamina = {
    strong = 2,  -- skill mais forte
    weak = 1,    -- skill mais fraca
	stun = 4     -- skill stun
}

keys.mana = {
    strong = 1,  -- skill mais forte
    weak = 2,    -- skill mais fraca
    aoe = 3      -- aoe, se nao for usar use atalho igual uma outra
}

return keys