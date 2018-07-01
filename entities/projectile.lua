--! file: projectile.lua

Config = require 'config'
Bullet = Object:extend()

function Bullet:new(x, y, direction)
    
    self.speed = Config.REGULAR_BULLET_SPEED
    self.damage = Config.REGULAR_BULLET_DAMAGE

    self.body = love.physics.newBody(world, x, y, 'dynamic')
    self.s = love.physics.newRectangleShape(unpack(Config.REGULAR_BULLET_SIZE))
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

function Bullet:draw(player)
    love.graphics.setColor(unpack(Config.REGULAR_BULLET_COLOR))
    screenWidth, screenHeight = love.graphics.getDimensions()
    pos = player:getPosition()
    a, b, c, d, e, f, g, h = self.body:getWorldPoints(self.s:getPoints())
    love.graphics.polygon('fill', a-pos.x+screenWidth/2, b-pos.y+screenHeight/2,
                                    c-pos.x+screenWidth/2, d-pos.y+screenHeight/2,
                                    e-pos.x+screenWidth/2, f-pos.y+screenHeight/2,
                                    g-pos.x+screenWidth/2, h-pos.y+screenHeight/2)
end
    