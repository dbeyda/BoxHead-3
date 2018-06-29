
function love.load()
    Object = require 'lib.classic'
    Config = require "config"
    require "entities.player"
    require "entities.walls"
    require "entities.zombie"

    screenWidth, screenHeight = love.graphics.getDimensions()

    world = love.physics.newWorld(0, 0, true)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    walls = Walls()
    p1 = Player()

    for i = 0,Config.INITIAL_ZOMBIES do
        Zombie.addZombie()
    end
end

function love.update(dt)
    world:update(dt)
    p1:update(dt)
    for i, zombie in pairs(Zombie.zombies) do 
        zombie:followPlayer(p1, dt)
    end

    if love.timer.getTime() - Zombie.lastTimeZombie > Zombie.zombieInterval then
        Zombie.lastTimeZombie = love.timer.getTime()
        Zombie.addZombie()
    end
end


function love.draw()
    p1:draw()
    walls:draw()
    
    for i, z in pairs(Zombie.zombies) do
        z:draw()
    end
end

function love.keyreleased(key)
    p1:keyreleased(key)
end

-- collision functions --

function beginContact(a, b, coll)
    x,y = coll:getNormal()

    -- Bullet x Wall collision handling
    if (a:getCategory() == Config.WALL_CATEGORY and b:getCategory() == Config.BULLET_CATEGORY) then
        p1:removeBullet(b:getUserData())
    elseif (a:getCategory() == Config.BULLET_CATEGORY and b:getCategory() == Config.WALL_CATEGORY) then
        p1:removeBullet(a:getUserData())
    end

    -- Bullet x Zombie collision handling
    if (a:getCategory() == Config.ZOMBIE_CATEGORY and b:getCategory() == Config.BULLET_CATEGORY) then
        local damage = 10
        Zombie.wasHit(a:getUserData(), damage)
        p1:removeBullet(b:getUserData())
    elseif (a:getCategory() == Config.BULLET_CATEGORY and b:getCategory() == Config.ZOMBIE_CATEGORY) then
        local damage = 10
        Zombie.wasHit(b:getUserData(), damage)
        p1:removeBullet(a:getUserData())
    end
    
end
 
function endContact(a, b, coll)
end
 
function preSolve(a, b, coll)
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse) 
end
