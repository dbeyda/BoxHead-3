--! file: zombie.lua
require "math"
require "lib.utils"
Config = require "config"
Zombie = Object:extend()

-- Class properties
Zombie.zombies = {}
Zombie.zombiesCount = 0
Zombie.lastTimeZombie = 0
Zombie.zombieInterval = Config.ZOMBIE_INTERVAL

-- Static methods
function Zombie.addZombie()
    Zombie.zombiesCount = Zombie.zombiesCount + 1
    z = Zombie(getRandomPosition())
    z.f:setUserData(Zombie.zombiesCount)
    Zombie.zombies[Zombie.zombiesCount] = z
end

function Zombie.killZombie(zombie)
    if Zombie.zombies[zombie] ~= nil then 
        Zombie.zombies[zombie].f:destroy()
        Zombie.zombies[zombie] = nil
    end
end

function Zombie.wasHit(zombieId, damage)
    if Zombie.zombies[zombieId] ~= nil then
        z = Zombie.zombies[zombieId]
        z.health = z.health - damage
        if z.health <= 0 then
            Zombie.killZombie(zombieId)
        end
    end
end

-- Constructor
function Zombie:new(x, y)
    self.health = Config.ZOMBIE_HEALTH
    self.damage = Config.ZOMBIE_DAMAGE
    self.speed = Config.ZOMBIE_SPEED
    self.width, self.height = unpack(Config.ZOMBIE_SIZE)
    self.direction = 'south' --! north, northeast, east, southest, south, southwest, west, northwest
    self.body = love.physics.newBody(world, x, y, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    self.s = love.physics.newRectangleShape(self.width, self.height)
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setCategory(Config.ZOMBIE_CATEGORY)
end

-- Methods

function Zombie:draw()
    if self.health > Config.ZOMBIE_HEALTH * 0.7 then
        love.graphics.setColor(unpack(Config.ZOMBIE_FULL_LIFE_COLOR))
    elseif self.health > Config.ZOMBIE_HEALTH * 0.4 then
        love.graphics.setColor(unpack(Config.ZOMBIE_MID_LIFE_COLOR))
    else
        love.graphics.setColor(unpack(Config.ZOMBIE_LOW_LIFE_COLOR))
    end
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end

function Zombie:getPosition()
    pos = {}
    pos.x = self.body:getX()
    pos.y = self.body:getY()
    return pos;
end

function Zombie:followPlayer(player, dt)
    playerPos = player:getPosition()
    zombiePos = self:getPosition()
    deltaX = playerPos.x - zombiePos.x
    deltaY = playerPos.y - zombiePos.y
    
    -- diagonal movement: ajust the parameters to tune when the zombie will walk in diagonal
    if math.abs(deltaX/deltaY) >= 0.3 and math.abs(deltaX/deltaY) <= 1.7 then
        -- calculate cardinal speed vectors so that the resulting speed is equal to Config.ZOMBIE_SPEED
        speed = math.sqrt(math.pow(Config.ZOMBIE_SPEED, 2)/2)
        -- use the sign (+1 or -1) to set the velocity direction
        signX = deltaX/math.abs(deltaX)
        signY = deltaY/math.abs(deltaY)
        self.body:setLinearVelocity(signX*speed, signY*speed)

    -- movement only in x
    elseif math.abs(deltaX) >= math.abs(deltaY) then
        sign = deltaX/math.abs(deltaX)
        self.body:setLinearVelocity(sign*Config.ZOMBIE_SPEED, 0)

    -- movement only in y 
    else
        sign = deltaY/math.abs(deltaY)
        self.body:setLinearVelocity(0, sign*Config.ZOMBIE_SPEED)
        
    end
end