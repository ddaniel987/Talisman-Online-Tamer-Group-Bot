-- Boss list names to attack strong

local Boss = {}

Boss.listNames = {
    "Boss1",
    "Boss2",
	"Boss3",
	"Boss4",
	"Boss5",
	"Boss6",
	"Boss7",
	"Boss8",
	"Boss9",
	"Boss10",
	"Boss11",
    "Boss12"
}

function Boss.verify(name)
    for _, bossName in ipairs(Boss.listNames) do
        if name == bossName then
            return true
        end
    end
    return false
end

return Boss
