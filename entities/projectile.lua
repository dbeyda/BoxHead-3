--! file: projectile.lua

Config = require "entities.config"
Bullet = Object:extend()

function Bullet:new(x, y, direction)
    
    self.speed = Config.REGULAR_BULLET_SPEED
    self.damage = Config.REGULAR_BULLET_DAMAGE

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.s = love.physics.newRectangleShape(unpack(Config.REGULAR_BULLET_SIZE))
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setCategory(Config.BULLET_CATEGORY)
    self.f:setMask(Config.PLAYER_CATEGORY, Config.BULLET_CATEGORY)

    if direction == "north" then
        self.body:setLinearVelocity(0, -self.speed)
    elseif direction == "east" then
        self.body:setLinearVelocity(self.speed, 0)
    elseif direction == "south" then
        self.body:setLinearVelocity(0, self.speed)
    elseif direction == "west" then
        self.body:setLinearVelocity(-self.speed, 0)
    elseif direction == 'northeast' then
        self.body:setLinearVelocity(self.speed, -self.speed)
    elseif direction == 'southeast' then
        self.body:setLinearVelocity(self.speed, self.speed)
    elseif direction == 'northwest' then
        self.body:setLinearVelocity(-self.speed, -self.speed)
    elseif direction == 'southwest' then
        self.body:setLinearVelocity(-self.speed, self.speed)
    end
end

function Bullet:draw()
    love.graphics.setColor(unpack(Config.REGULAR_BULLET_COLOR))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end
    