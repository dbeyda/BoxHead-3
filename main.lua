
function love.load()
    Object = require 'lib.classic'
    sti = require 'lib.sti'
    Config = require 'config'
    Camera = require 'lib.Camera'
    require 'entities.player'
    require 'entities.wall'
    require 'entities.zombie'

    love.window.setFullscreen(true, "desktop")
    bigFont = love.graphics.newFont(32)
    smallFont = love.graphics.newFont(22)

    screenWidth, screenHeight = love.graphics.getDimensions()

    map = sti('assets/level1.lua', { "box2d" })
    world = love.physics.newWorld(0, 0, true)
    map:box2d_init(world)
    map:addCustomLayer("Sprite Layer", 5)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    for k, object in pairs(map.objects) do
        if object.name == "player" then
            p1 = Player(object.x, object.y)
        elseif object.type == "wall" then
            Wall(object.x, object.y, object.width, object.height, object.rotation, object.name)
        elseif object.type == "zombie-respawn" then
            table.insert(Zombie.respawnZones, {x=object.x, y=object.y})
        end
        -- -- Prints object's properties
        -- for i, prop in pairs(object) do
        --     print(i, prop)
        -- end
    end

    for i = 0,Config.INITIAL_ZOMBIES do
        Zombie.addZombie()
    end
end

function love.update(dt)
    map:update(dt)
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
    pos = p1:getPosition()
    love.graphics.push()
    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.translate(-pos.x, -pos.y)

    love.graphics.setColor(255, 255, 255)
    map:draw(-pos.x + screenWidth/2, -pos.y + screenHeight/2)
    p1:draw()
    for i, z in pairs(Zombie.zombies) do
        z:draw()
    end
    love.graphics.pop()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(bigFont)
    love.graphics.print("Score:"..p1.score, 20, 20)
    love.graphics.print("Health:"..p1.health, screenWidth - 200, 20)
    love.graphics.setFont(smallFont)
    love.graphics.print("Current weapon:"..p1:getWeapon().name, screenWidth - 340, screenHeight - 50)
end

function love.keyreleased(key)
    p1:keyreleased(key)
end

-- Collision handlers

function handleBulletZombieCollision(bullet, zombie)
    local damage = 10
    local killedZombie = Zombie.wasHit(zombie:getUserData(), damage)
    if (killedZombie) then
        p1:updateScore(15)
    end
    p1:removeBullet(bullet:getUserData())
end

function handlePlayerZombieCollision(player, zombie, coll)
    local damage = 10
    local isDead = p1:wasHit(damage, coll)
    if isDead then
        print ("DEAD")
    end
end


-- Collision callbacks --

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
        handleBulletZombieCollision(b, a)
    elseif (a:getCategory() == Config.BULLET_CATEGORY and b:getCategory() == Config.ZOMBIE_CATEGORY) then
        handleBulletZombieCollision(a, b)
    end
end
 
function endContact(a, b, coll)
end
 
function preSolve(a, b, coll)
    -- Player x Zombie collision handling
    if (a:getCategory() == Config.ZOMBIE_CATEGORY and b:getCategory() == Config.PLAYER_CATEGORY) then
        handlePlayerZombieCollision(b, a, coll)
    elseif (a:getCategory() == Config.PLAYER_CATEGORY and b:getCategory() == Config.ZOMBIE_CATEGORY) then
        handlePlayerZombieCollision(a, b, coll)
    end
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse) 
end