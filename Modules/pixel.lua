--[[ Color/pixel recognition --]]

local pixel = {}

-- Blocked window offsets
local X, Y = 8, 31 


-- Tries to match a pixel at specific coordinates
function pixel.match(x, y, c)
    return (color (x + X, y + Y, workwindow()) == c)
end

-- Searchs for one or more pixels in a rectangular area
function pixel.search(startX, startY, endX, endY, 
                    c, count, deviation)

    -- Default parameters
    count = count or 1
    deviation = deviation or 5
    RESULT = nil

    -- Perform the search
    local found = findcolor(startX + X, startY + Y, endX + X, endY + Y, 
                        (c), '%RESULT', workwindow(), count, deviation)

    -- Return coordinates of found pixels
    return RESULT
end

-- Returns an image from a rectangular area
function pixel.getImage(startX, startY, endX, endY)
    return getimage(startX, startY, endX, endY, workwindow())
end


-- Searchs for one or more images in a rectangular area
function pixel.imageSearch(startX, startY, endX, endY, 
                            path, accuracy, count, deviation, method)

    -- Default paramenters
    accuracy = accuracy or 70
    count = count or -1
    deviation = deviation or 5
    if not method then
        method = workwindow()
        startX = startX + X startY = startY + Y
        endX = endX + X endY = endY + Y
    end
    
    -- Perform the search
    local result, found = findimage(startX, startY, endX, endY, 
                        {path}, method, accuracy, count, deviation)
    
    -- Return coordinates of found images
    return result   
end

return pixel