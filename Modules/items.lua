--[[ Item deleter bot --]]
local items = {}

local ptr = require("Modules/pointers")
local pixel = require("Modules/pixel")
local util = require("Modules/utility")
local cords = require("Modules/cords")
local keys = require("Modules/keys")

-- Item images
local itemPath, count = dir([[Images/items/]])
local itemImages = {}

-- Load images into memory
for i = 1, count do
    local image = loadimage(itemPath[i][1])
    table.insert(itemImages, {image, itemPath[i][3]})
end

local destroyIcon = loadimage([["Images/misc/destroy-item.bmp"]])
local destroyCords = nil


-- Removes items from inventory 
function items.delete() 
	if DELETER_BOT == "OFF" then log("Deleter bot Mode OFF") return end wait(W)
	if MINIMIZED_MODE == "ON" then showwindow() wait(3000) end
	-- showwindow() wait(2000)
    
    log("Opening bag...")
    if not ptr.isBagOpen() then send(keys.inventory) wait(W)
    else log("Bag's already open!") end

    -- Determine bag cordinates through destroy icon
    -- Get destroy icon coordinates
    if not destroyCords then 
        destroyCords = pixel.imageSearch(0, 0, 1024, 768, destroyIcon, 90, 1)
    end

    -- Exit if destroyIcon was not found
    if not destroyCords then return -1 end

    -- Build bag coordinates
    local bagCords = {
            {destroyCords[1][1] - 5, destroyCords[1][2] - 200,
                destroyCords[1][1] + 220, destroyCords[1][2]  - 15},
            {destroyCords[1][1] + 250, destroyCords[1][2] - 420,
                destroyCords[1][1] + 490, destroyCords[1][2] - 10}
        } 
    local offsets = {
        {218, 181}, {218, 410}
    }  
    
    -- Scan both bags
    local toDelete = {}
    log("Scanning bag for potential items...")
    for i = 1, #bagCords 
    do
        -- Get image of the bag
        local bagImage = getimage(bagCords[i][1], bagCords[i][2], 
                                    bagCords[i][3], bagCords[i][4], workwindow())

        -- Try to delete all items provided if found
        for item, value in pairs(itemImages)
        do  
            -- Search image for possible items
            local itemsFound = pixel.imageSearch(0, 0, offsets[i][1], offsets[i][2],                                    
                                                    value[1], 90, -1, 5, bagImage)

            -- Add item cords toDelete table to be deleted later
            if itemsFound then
                log(#itemsFound .. " " .. value[2] .. " found!")
                for j = 1, #itemsFound
                do
                    table.insert(toDelete, {itemsFound[j][1], itemsFound[j][2]})
                end
            end
        end

        -- Delete image of the bag
        deleteimage(bagImage)
    end

    -- Delete found items
    if next(toDelete) ~= nil then
        log("Deleting them all... ")
        for i = 1, #toDelete
        do  
            left(toDelete[i][1], toDelete[i][2]) wait(200)
            left(destroyCords[1][1], destroyCords[1][2]) wait(200)
            if ptr.getConfirmBox() then 
                left(cords.confirmBox.ok[1], cords.confirmBox.ok[2]) wait(200) 
            end
        end
    else log("No items found!") end

    log("Closing bag...")
    if ptr.isBagOpen() then send(keys.inventory) wait(W) end wait(W)
	if MINIMIZED_MODE == "ON" then showwindow(workwindow(), "MINIMIZE") end
	-- showwindow(workwindow(), "MINIMIZE")
end


return items

