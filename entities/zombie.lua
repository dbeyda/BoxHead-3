--! file: zombie.lua
Config = require "entities.config"
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
