--! file: projectile.lua

require "entities.constants"
Bullet = Object:extend()

function Bullet:new(x, y, direction)
    self.speed = 800
    self.damage = 10

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.s = love.physics.newRectangleShape(5, 5)
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setCategory(BULLET_CATEGORY)
    self.f:setMask(PLAYER_CATEGORY, BULLET_CATEGORY)

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
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end
    