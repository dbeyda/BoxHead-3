
function love.load()
    Object = require 'lib.classic'
    require "entities.player"
    require "entities.walls"
    require "entities.zombie"

    screenWidth, screenHeight = love.graphics.getDimensions()

    world = love.physics.newWorld(0, 0, true)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    walls = Walls()
    p1 = Player()

    zombies = {}
    zombiesCount = 0
    zombieInterval = 1.5
    lastTimeZombie = 0

    for i = 0,10 do
        addZombie()
    end

    text       = ""   -- we'll use this to put info text on the screen later
    persisting = 0
end

function getRandomPosition()
    return math.random(0, screenWidth), math.random(0, screenHeight)
end

function addZombie()
    zombiesCount = zombiesCount + 1
    z = Zombie(getRandomPosition())
    z.f:setUserData(zombiesCount)
    zombies[zombiesCount] = z
end

function killZombie(zombie)
    if zombies[zombie] ~= nil then 
        zombies[zombie].f:destroy()
        zombies[zombie] = nil
    end
end

function love.update(dt)
    world:update(dt)
    p1:update(dt)

    if love.timer.getTime() - lastTimeZombie > zombieInterval then
        lastTimeZombie = love.timer.getTime()
        addZombie()
    end
end


function love.draw()
    p1:draw()
    walls:draw()
    
    for i, z in pairs(zombies) do
        z:draw()
    end
end

function love.keyreleased(key)
    p1:keyreleased(key)
end

-- collision functions --

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
    -- print(text)

    -- Bullet x Wall collision handling
    if (a:getCategory() == 3 and b:getCategory() == 2) then
        p1:removeBullet(b:getUserData())
    elseif (a:getCategory() == 2 and b:getCategory() == 3) then
        p1:removeBullet(a:getUserData())
    end

    -- Bullet x Zombie collision handling
    if (a:getCategory() == 4 and b:getCategory() == 2) then
        killZombie(a:getUserData())
        p1:removeBullet(b:getUserData())
    elseif (a:getCategory() == 2 and b:getCategory() == 4) then
        killZombie(b:getUserData())
        p1:removeBullet(a:getUserData())
    end
    
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
