
function love.load()
    Object = require 'lib.classic'
    require "entities.player"
    require "entities.walls"

    local screenWidth, screenHeight = love.graphics.getDimensions()

    world = love.physics.newWorld(0, 0, true)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    walls = Walls()
    p1 = Player()

    text       = ""   -- we'll use this to put info text on the screen later
    persisting = 0
end


function love.update(dt)
    world:update(dt)
    p1:update(dt)
end


function love.draw()
    p1:draw()
    walls:draw()
end

function love.keyreleased(key)
    p1:keyreleased(key)
end


-- collision functions --

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
    -- print(text)
end
 
function endContact(a, b, coll)
    persisting = 0
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
    -- print(text)
end
 
function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
        -- print(text)
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
        -- print(text)
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
    -- print(text)
end
