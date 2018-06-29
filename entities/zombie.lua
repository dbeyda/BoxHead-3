--! file: zombie.lua
require "math"
Config = require "config"
Zombie = Object:extend()

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
    self.f:setMask(Config.ZOMBIE_CATEGORY)
end

function Zombie:draw()
    love.graphics.setColor(unpack(Config.ZOMBIE_COLOR))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end

function Zombie:getPosition()
    pos = {}
    pos.x = self.body:getX()
    pos.y = self.body:getY()
    return pos;
end

function Zombie:follow_player(player, dt)
    player_pos = player:getPosition()
    zombie_pos = self:getPosition()
    delta_x = player_pos.x - zombie_pos.x
    delta_y = player_pos.y - zombie_pos.y
    
    -- diagonal movement: ajust the parameters to tune when the zombie will walk in diagonal
    if math.abs(delta_x/delta_y) >= 0.3 and math.abs(delta_x/delta_y) <= 1.7 then
        -- calculate cardinal speed vectors so that the resulting speed is equal to Config.ZOMBIE_SPEED
        speed = math.sqrt(math.pow(Config.ZOMBIE_SPEED, 2)/2)
        -- use the sign (+1 or -1) to set the velocity direction
        sign_x = delta_x/math.abs(delta_x)
        sign_y = delta_y/math.abs(delta_y)
        self.body:setLinearVelocity(sign_x*speed, sign_y*speed)

    -- movement only in x
    elseif math.abs(delta_x) >= math.abs(delta_y) then
        sign = delta_x/math.abs(delta_x)
        self.body:setLinearVelocity(sign*Config.ZOMBIE_SPEED, 0)

    -- movement only in y 
    else
        sign = delta_y/math.abs(delta_y)
        self.body:setLinearVelocity(0, sign*Config.ZOMBIE_SPEED)
        
    end
end