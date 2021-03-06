--! file: projectile.lua

Config = require "config"
Bullet = Object:extend()

function Bullet:new(x, y, direction, bulletConfig)
        
    self.color = bulletConfig.color
    self.speed = bulletConfig.speed
    self.damage = bulletConfig.damage

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.s = love.physics.newRectangleShape(unpack(bulletConfig.size))
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setCategory(Config.BULLET_CATEGORY)
    self.f:setMask(Config.PLAYER_CATEGORY, Config.BULLET_CATEGORY)

    if direction == Config.DIRECTION.N then
        self.body:setLinearVelocity(0, -self.speed)
    elseif direction == Config.DIRECTION.E then
        self.body:setLinearVelocity(self.speed, 0)
    elseif direction == Config.DIRECTION.S then
        self.body:setLinearVelocity(0, self.speed)
    elseif direction == Config.DIRECTION.W then
        self.body:setLinearVelocity(-self.speed, 0)
    elseif direction == Config.DIRECTION.NE then
        self.body:setLinearVelocity(self.speed, -self.speed)
    elseif direction == Config.DIRECTION.SE then
        self.body:setLinearVelocity(self.speed, self.speed)
    elseif direction == Config.DIRECTION.NW then
        self.body:setLinearVelocity(-self.speed, -self.speed)
    elseif direction == Config.DIRECTION.SW then
        self.body:setLinearVelocity(-self.speed, self.speed)
    end
end

function Bullet:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end
    