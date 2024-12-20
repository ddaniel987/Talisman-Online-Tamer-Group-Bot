local ptr = require("Modules/pointers")

local logger = {}
function logger.say(str)
	local charName = ptr.getCharName()
	log(charName .. ": " .. str)
end

return logger