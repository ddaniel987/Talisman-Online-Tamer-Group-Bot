--[[ Reading game memory --]]

local pointers = {}

-- Client base address
local CLIENT = 0x00400000

--[[ Pointer and Offsets --]]
-- HP 
local HP_POINTER = readmem(0x011450EC, "d") -- ok

-- Hp plus
local HP_PLUS_POINTER = readmem(0x011450EC, "d") -- ok

-- Hp buff
local HP_BUFF_POINTER = readmem(0x011450EC, "d") -- ok

-- Max HP
local MAX_HP_POINTER = readmem(0x011450EC, "d") -- ok

-- Mana
local MANA_POINTER = readmem(0x011450EC, "d") -- ok

-- Mana buff
local MANA_BUFF_POINTER = readmem(0x011450EC, "d") -- ok

-- Max mana
local MAX_MANA_POINTER = readmem(0x011450EC, "d") -- ok

-- Char level
local LEVEL_POINTER = readmem(0x011450EC, "d") -- ok

-- Battle status
local BATTLE_STATUS_POINTER = readmem(0x011450EC, "d") -- ok

-- How many chars in team
local TEAM_SIZE_POINTER = readmem(0x0106D328, "d") -- ok

-- Split window
local splitOffsets = {0x18, 0x694, 0x0, 0xC, 0x1F8} -- ok
local SPLIT_POINTER = readmem(0x12CE2E0, "d")
for i = 1, #splitOffsets
do
    SPLIT_POINTER =
        readmem(SPLIT_POINTER + splitOffsets[i], "d")
end

-- Monk breakpoint counter
local BREAKPOINT_POINTER = readmem(0x011450EC, "d") -- ok


-- Friend List
local friendListOffsets = {0x10, 0x2C, 0x4C, 0x4, 0xC, 0x4} -- ok
local FRIEND_LIST_POINTER = readmem(CLIENT + 0x00C4311C, "d")
for i = 1, #friendListOffsets
do
    FRIEND_LIST_POINTER = 
        readmem(FRIEND_LIST_POINTER + friendListOffsets[i], "d")
end

-- Vender bag 
local VENDER_BAG_POINTER = readmem(CLIENT + 0x00C640D8, "d") -- old

-- Channel
local CHANNEL_POINTER = readmem(CLIENT + 0x00D3537C, "d")-- old

-- Char name
local CHAR_NAME_POINTER = readmem(0x011450EC, "d") -- ok


-- Target selected
local targetSelectedOffsets = {0xD0, 0x2DC, 0x24} -- ok
local TARGET_SELECTED_POINTER = readmem(CLIENT + 0x00EC05C8, "d")
for i = 1, #targetSelectedOffsets
do
    TARGET_SELECTED_POINTER = 
        readmem(TARGET_SELECTED_POINTER + targetSelectedOffsets[i], "d")
end

-- Enemey HP
local targetHpOffsets = {0x18, 0x59C, 0x0, 0xC, 0x1F4, 0x15C} -- ok
local TARGET_HP_POINTER = readmem(0x012CE2E0, "d")
for i = 1, #targetHpOffsets
do
    TARGET_HP_POINTER = 
        readmem(TARGET_HP_POINTER + targetHpOffsets[i], "d")
end


-- Target name
local targetNameOffsets = {0x18, 0xB1C, 0x0, 0xC, 0xD9C} -- ok
local TARGET_HP_NAME_POINTER = readmem(0x012CE2E0, "d")
for i = 1, #targetNameOffsets
do
    TARGET_HP_NAME_POINTER = 
        readmem(TARGET_HP_NAME_POINTER + targetNameOffsets[i], "d")
end

-- Team 1 name
local teamName1Offsets = {0x18, 0x77C, 0x0, 0xC, 0x678, 0x8B4} -- ok
local TEAM_NAME_1 = readmem(0x012CE2E0, "d")
for i = 1, #teamName1Offsets
do
    TEAM_NAME_1 = 
        readmem(TEAM_NAME_1 + teamName1Offsets[i], "d")
end

-- Team 2 name
local teamName2Offsets = {0x18, 0x34C, 0x0, 0xC, 0x678, 0x8B4} -- ok
local TEAM_NAME_2 = readmem(0x012CE2E0, "d")
for i = 1, #teamName1Offsets
do
    TEAM_NAME_2 = 
        readmem(TEAM_NAME_2 + teamName2Offsets[i], "d")
end

-- Team 3 name
local teamName3Offsets = {0x18, 0x3F4, 0x0, 0xC, 0x1F4, 0x15C} -- ok
local TEAM_NAME_3 = readmem(0x012CE2E0, "d")
for i = 1, #teamName3Offsets
do
    TEAM_NAME_3 = 
        readmem(TEAM_NAME_3 + teamName3Offsets[i], "d")
end

-- Team 4 name
local teamName4Offsets = {0x18, 0xA1C, 0x0, 0xC, 0x1F4, 0x54} -- ok
local TEAM_NAME_4 = readmem(0x012CE2E0, "d")
for i = 1, #teamName4Offsets
do
    TEAM_NAME_4 = 
        readmem(TEAM_NAME_4 + teamName4Offsets[i], "d")
end

-- X position
local X_POINTER = readmem(0x011450EC, "d") -- ok


-- Y position
local Y_POINTER = readmem(0x011450EC, "d") -- ok

-- X ROT
local X_ROT_POINTER = readmem(0x011450EC, "d") -- ok

-- Y ROT
local Y_ROT_POINTER = readmem(0x011450EC, "d") -- ok

-- Zoom pointer
local ZOOM_POINTER = readmem(0x116FFF4, "d") -- ok

-- Rotation pointer
local ROTATION_POINTER = readmem(0x116FFF4, "d") -- ok

-- Angle pointer
local ANGLE_POINTER = readmem(0x116FFF4, "d") -- ok

-- Char location
local locationOffsets = {0x7F8, 0xF4} -- ok
local LOCATION_POINTER = readmem(0x011450EC, "d")
for i = 1, #locationOffsets
do
    LOCATION_POINTER = 
        readmem(LOCATION_POINTER + locationOffsets[i], "d")
end

-- Mount status
local MOUNT_STATUS = readmem(0x011450EC, "d") -- ok

-- Pet
local PET_POINTER = readmem(0x011450EC, "d") -- ok


-- Main bag items
local bagOffsets = {0x7A0, 0x30, 0x38, 0xA4, 0x0, 0x8} -- old
local BAG_POINTER = readmem(CLIENT + 0x00C11980, "d")
for i = 1, #bagOffsets
do
    BAG_POINTER = 
        readmem(BAG_POINTER + bagOffsets[i], "d")
end

-- Last bag items
local lastBagOffsets = {0x7A0, 0x30, 0x18, 0xA4, 0x4, 0x8}  -- old
local LAST_BAG_POINTER = readmem(CLIENT + 0x00C11980, "d")
for i = 1, #lastBagOffsets
do
    LAST_BAG_POINTER = 
        readmem(LAST_BAG_POINTER + lastBagOffsets[i], "d")
end


-- Dialog 
local dialogOffsets = {0x70, 0x56C, 0xC, 0x4, 0x42C, 0x1F8} -- ok
local DIALOG_POINTER = readmem(0x0117B27C, "d")
for i = 1, #dialogOffsets
do
    DIALOG_POINTER = 
        readmem(DIALOG_POINTER + dialogOffsets[i], "d")
end 

-- Surrounds
local surrOffsets = {0x18, 0x61C, 0x0, 0xC, 0x4A8, 0x80} -- ok
local SURROUNDS_POINTER = readmem(0x012CE2E0, "d")
for i = 1, #surrOffsets
do
    SURROUNDS_POINTER = 
        readmem(SURROUNDS_POINTER + surrOffsets[i], "d")
end 

-- Surrounds Link
local surrLinkOffsets = {0x18, 0x8C, 0x3C}
local SURROUNDS_LINK_POINTER = readmem(0x012CE2DC, "d") -- ok
for i = 1, #surrLinkOffsets
do
    SURROUNDS_LINK_POINTER = 
        readmem(SURROUNDS_LINK_POINTER + surrLinkOffsets[i], "d")
end 



-- Bag open 
local bagOpenOffsets = {0x18, 0x5C4, 0x0, 0xC, 0x1F8, 0x42C} -- ok
local BAG_OPEN_POINTER = readmem(0x012CE2E0, "d")
for i = 1, #bagOpenOffsets
do
    BAG_OPEN_POINTER = 
        readmem(BAG_OPEN_POINTER + bagOpenOffsets[i], "d")
end 

--loot
local lootOffsets = {0xD0, 0x7F4, 0x0, 0x24}
local LOOT_POINTER = readmem(CLIENT + 0x00EC05C8, "d") -- old
for i = 1, #lootOffsets
do
    LOOT_POINTER = 
        readmem(LOOT_POINTER + lootOffsets[i], "d")
end

-- Returns your current HP value
function pointers.getHp()
    return readmem(HP_POINTER + 0x3B8, "d")
end

-- Return hp percent pluses
function pointers.getHpPlus()
    local plus = readmem(HP_PLUS_POINTER + 0xE4, "b")
    if plus >= 100 then
        return plus - 100
    else
        return plus
    end
end

-- Return hp buffs
function pointers.getHpBuff()
    return readmem(HP_BUFF_POINTER + 0xE0, "d")
end   

-- Returns your maximum HP value
function pointers.getMaxHp()
    local hp = readmem(MAX_HP_POINTER + 0xDC, "d") + pointers.getHpBuff() 
    local pluses = pointers.getHpPlus()

    if pluses == 1 then return hp 
    else return math.floor(((hp * pluses) / 100) + hp) end
end

-- Returns your current mana value 
function pointers.getMana()
    return readmem(MANA_POINTER + 0x3BC, "d")
end

-- Return mana buffs
function pointers.getManaBuff()
    return readmem(MANA_BUFF_POINTER + 0x6F0, "d")
end

-- Returns your maximum mana value
function pointers.getMaxMana()
    return readmem(MAX_MANA_POINTER + 0x6EC, "d") + pointers.getManaBuff()
end

-- Returns char name
function pointers.getCharName()
    local name = readmem(CHAR_NAME_POINTER + 0xBC, "s", 30)
    
    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w]+$") then return name
    else 
        -- Else read it with offset
        return readmem(readmem(CHAR_NAME_POINTER + 0xBC, "d") + 0x0, "s", 30)
    end
end

-- Returns true if in battle, false otherwise
function pointers.isInBattle()
    return readmem(BATTLE_STATUS_POINTER + 0x854, "b") == 1
end


-- Returns true if target selected, false otherwise
function pointers.isTargetSelected()
    return readmem(TARGET_SELECTED_POINTER + 0xC10, "b") == 1 
end

-- Returns target HP value
function pointers.getTargetHp()
    return readmem(TARGET_HP_POINTER + 0x480, "w")
end

-- Returns target name
function pointers.getTargetName()
    local name = readmem(TARGET_HP_NAME_POINTER + 0x9AC, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else 
        return readmem(readmem(TARGET_HP_NAME_POINTER + 0x9AC, "d") + 0x0, "s", 51)
    end
end

-- Returns team 1 name
function pointers.getTeam1Name()
    local name = readmem(TEAM_NAME_1 + 0x4F4, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else 
        return readmem(readmem(TEAM_NAME_1 + 0x4F4, "d") + 0x0, "s", 51)
    end
end

-- Returns team 2 name
function pointers.getTeam2Name()
    local name = readmem(TEAM_NAME_2 + 0x4F4, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else 
        return readmem(readmem(TEAM_NAME_2 + 0x4F4, "d") + 0x0, "s", 51)
    end
end

-- Returns team 3 name
function pointers.getTeam3Name()
    local name = readmem(TEAM_NAME_3 + 0x54, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else 
        return readmem(readmem(TEAM_NAME_3 + 0x54, "d") + 0x0, "s", 51)
    end
end

-- Returns team 4 name
function pointers.getTeam4Name()
    local name = readmem(TEAM_NAME_4 + 0x54, "s", 51)

    -- If name is alphanumeric return it safely
    if string.match(name, "^[%w ']+$") then return name
    else 
        return readmem(readmem(TEAM_NAME_4 + 0x54, "d") + 0x0, "s", 51)
    end
end

-- Returns true if target is dead, false otherwise
function pointers.isTargetDead()
    return readmem(TARGET_HP_POINTER + 0x480, "w") == 0
end

-- Returns true if target is full health, false otherwise
function pointers.isTargetHpFull()
    return readmem(TARGET_HP_POINTER + 0x480, "w") == 597
end

-- Returns char's x-axis location
function pointers.getX()
    local x = readmem(X_POINTER + 0x810, "f") / 20
    return x > 0 and math.floor(x) or math.ceil(x)
end

-- Returns char's y-axis location
function pointers.getY()
    local y = readmem(Y_POINTER + 0x814, "f") / 20
    return y > 0 and math.floor(y) or math.ceil(y)
end

-- Returns current location
function pointers.getLocation()
    local location = readmem(LOCATION_POINTER + 0x44C, "s", 51)

	-- If location is alphanumeric return it safely
    if string.match(location, "^[%w ']+$") then return location
    else 
        return readmem(readmem(LOCATION_POINTER + 0x44C, "d") + 0x0, "s", 51)
    end
end

-- Returns char's level
function pointers.getLevel()
    return readmem(LEVEL_POINTER + 0x3C4, "w")
end


-- Returns true if player is mounted
function pointers.isMounted()
    return readmem(MOUNT_STATUS + 0x8B0, "d") ~= 0
end

-- Returns true if pet is alive
function pointers.isPetAlive()
    return readmem(PET_POINTER + 0x10A8, "d") ~= 0
end

-- Returns how many items in main bag
function pointers.getBagItems()
    return readmem(BAG_POINTER + 0x10, "d") 
end

-- Returns the number of items in last bag
function pointers.getLastBagItems()
    return readmem(LAST_BAG_POINTER + 0x10, "d")
end

-- Returns the number of items in vender's bag
function pointers.getVenderBagItems()
    return readmem(VENDER_BAG_POINTER + 0x7EC, "d")
end

-- Returns true if there is a notification
function pointers.getNotification()
    return readmem(CLIENT + 0xD7097C, "d") == 1 and true or false -- ok
end

-- Returns true if dialog window is open
function pointers.getDialog()
    return readmem(DIALOG_POINTER + 0x240, "d") == 16775 and true or false
end

-- Returns true if surrounds window is open
function pointers.getSurr()
    return readmem(SURROUNDS_POINTER + 0xBD0, "d") == 16775 and true or false
end


function pointers.getSurrLink(name)
    local link = readmem(CLIENT + 0xECA1A8, "s", 50) -- old
	
	wait(500)
    
    -- Verifica se o nome está na string do link
    if string.find(link, name) then
        return true  -- O nome foi encontrado
    else
        return false -- O nome não foi encontrado
    end
end


-- Returns zoom level
function pointers.getZoom()
    return readmem(ZOOM_POINTER + 0x64, "f")
end

function pointers.setZoom(zValue)
	writemem (zValue, ZOOM_POINTER + 0x64, "f")
end

-- Return rotation level
function pointers.getRotation()
    return readmem(ROTATION_POINTER + 0x5C, "f")
end

function pointers.setRotation(rValue)
	writemem (rValue, ROTATION_POINTER + 0x5C, "f")
end

-- Return angle level
function pointers.getAngle()
    return readmem(ANGLE_POINTER + 0x60, "f")
end

function pointers.setAngle(aValue)
	writemem (aValue, ANGLE_POINTER + 0x60, "f")
end

-- Returns true if there is a confirm box
function pointers.getConfirmBox()
    return readmem(0x012CE35C, "d") == 1 and true or false
end

-- Returns true if bag is open
function pointers.isBagOpen()
    return readmem(BAG_OPEN_POINTER + 0xBA0, "d") == 903 and true or false
end

-- Returns true if channeling 
function pointers.isChanneling()
    return readmem(CHANNEL_POINTER + 0x10, "d") == 24 and true or false  -- old
end


-- Returns true if sitting, false otherwise
function pointers.isSitting()
	SIT_POINTER = readmem(0x011450EC, "d")
    return readmem(SIT_POINTER + 0x290, "b") == 200 and true or false
end


function pointers.isFlistOpen()
	return readmem(FRIEND_LIST_POINTER + 0x240, "d") == 16775 and true or false
end

function pointers.getSplit()
	return readmem(SPLIT_POINTER + 0x240, "d") == 16775 and true or false
end

-- Retorna True se aparecer a janela de loot
function pointers.LootWindow()
    return readmem(0x0105B958, "d") == 1 and true or false -- ok
end

function pointers.isLoot()
    return readmem(LOOT_POINTER + 0x40, "d") ~= 0
end

function pointers.getBreakpoint()
	return readmem(BREAKPOINT_POINTER + 0x3E0, "d")
end

function pointers.isInTeam()
	return readmem(TEAM_SIZE_POINTER + 0x3D8, "d") >= 2 and true or false
end

function pointers.teamSize()
	return readmem(TEAM_SIZE_POINTER + 0x3D8, "d") -- team size
end

function pointers.getSurrLink(name)
    local link = readmem(CLIENT + 0xED575F, "s", 50)
	
	wait(500)
    
    if string.find(link, name) then
        return true  
    else
        return false 
    end
end

-- Returns x fish
function pointers.fishX()
    local x = readmem(X_ROT_POINTER + 0x828, "f")
    return x > 0 and math.floor(x) or math.ceil(x)
end

-- Returns  y fish
function pointers.fishY()
    local y = readmem(Y_ROT_POINTER + 0x82C, "f")
    return y > 0 and math.floor(y) or math.ceil(y)
end

-- if fish
function pointers.fish()
    return readmem(0x0105B958, "d") == 1 and true or false -- ok
end

-- while fishing fish
function pointers.isFishing()
    return readmem(0x0105BA48, "d") == 1 and true or false -- ok
end

function pointers.mouseX()
    return readmem(0x012CE394, "d") -- ok
end

function pointers.mouseY()
    return readmem(0x012CE398, "d") -- ok
end

return pointers
