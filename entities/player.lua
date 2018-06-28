--! file: player.lua

Config = require "entities.config"
require "entities.projectile"

Player = Object:extend()

function Player:new()
    self.bullet = {}
    self.bulletCount = 0
    self.lastShot = love.timer.getTime( )
    self.health = Config.PLAYER_HEALTH
    self.shootingInterval = Config.PLAYER_SHOOTING_INTERVAL
    self.currentWeapon = 0
    self.weaponList = {}
    self.width, self.height = unpack(Config.PLAYER_SIZE)
    self.speed = Config.PLAYER_SPEED
    self.initialX, self.initalY = unpack(Config.PLAYER_INITIAL_POS)
    self.direction = 'south' --! north, northeast, east, southest, south, southwest, west, northwest
    self.body = love.physics.newBody(world, self.initialX, self.initalY, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    self.s = love.physics.newRectangleShape(self.width, self.height)
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setUserData("Player") 
    self.f:setCategory(Config.PLAYER_CATEGORY)
    self.f:setMask(Config.PLAYER_CATEGORY, Config.BULLET_CATEGORY)
end


function Player:update(dt)
    if love.keyboard.isDown('right') and love.keyboard.isDown('up') then
        self.direction = 'northeast'
        self.body:setLinearVelocity(self.speed, -self.speed)
    elseif love.keyboard.isDown('right') and love.keyboard.isDown('down') then
        self.direction = 'southeast'
        self.body:setLinearVelocity(self.speed, self.speed)
    elseif love.keyboard.isDown('left') and love.keyboard.isDown('up') then
        self.direction = 'northwest'
        self.body:setLinearVelocity(-self.speed, -self.speed)
    elseif love.keyboard.isDown('left') and love.keyboard.isDown('down') then
        self.direction = 'southwest'
        self.body:setLinearVelocity(-self.speed, self.speed)
    elseif love.keyboard.isDown('right') then
        self.direction = 'east'
        self.body:setLinearVelocity(self.speed, 0)
    elseif love.keyboard.isDown('left') then
        self.direction = 'west'
        self.body:setLinearVelocity(-self.speed, 0)
    elseif love.keyboard.isDown('up') then
        self.direction = 'north'
        self.body:setLinearVelocity(0, -self.speed)
    elseif love.keyboard.isDown('down') then
        self.direction = 'south'
        self.body:setLinearVelocity(0, self.speed)
    end
    
    if love.keyboard.isDown('space') then
        if love.timer.getTime( ) - self.lastShot > self.shootingInterval then
            self.lastShot = love.timer.getTime()
            local b = Bullet(self.body:getX(), self.body:getY(), self.direction)
            self.bulletCount = self.bulletCount + 1
            b.f:setUserData("bullet"..self.bulletCount)
            self.bullet["bullet"..self.bulletCount] = b
        end
    end
end

function Player:keyreleased(key)
    if key == 'left' or key == 'right' or key == 'down' or key == 'up' then
        self.body:setLinearVelocity(0,0)
    end
end


function Player:draw()
    love.graphics.setColor(unpack(Config.PLAYER_COLOR))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
    
    for i, b in pairs(self.bullet) do 
        b:draw()
    end

    -- love.graphics.setColor(0, 105, 255, 255)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- --! draw the front of the player in the right direction
    -- local xx = 0
    -- local yy = 0
    -- local size = 10
    -- if self.direction == 'north' then
    --     xx = self.x + (self.width/2) - size/2
    --     yy = self.y
    -- elseif self.direction == 'south' then
    --     xx = self.x + (self.width/2) - size/2
    --     yy = self.y + self.height - size
    -- elseif self.direction == 'east' then
    --     xx = self.x + self.width - size
    --     yy = self.y + self.height/2 - size/2
    -- elseif self.direction == 'west' then
    --     xx = self.x
    --     yy = self.y + self.height/2 - size/2
    -- elseif self.direction == 'northeast' then
    --     xx = self.x + self.width - size
    --     yy = self.y
    -- elseif self.direction == 'northwest' then
    --     xx = self.x
    --     yy = self.y
    -- elseif self.direction == 'southeast' then
    --     xx = self.x + self.width - size
    --     yy = self.y + self.height - size
    -- elseif self.direction == 'southwest' then
    --     xx = self.x
    --     yy = self.y + self.height - size
    -- end
    -- love.graphics.setColor(50, 0, 0, 255)
    -- love.graphics.rectangle("fill", xx, yy, size, size)
end

function Player:getDirection()
    return self.direction
end

function Player:getWeapon()
    return self.currentWeapon
end

function Player:removeBullet(b)
    if self.bullet[b] ~= nil then 
        self.bullet[b].f:destroy()
        self.bullet[b] = nil
    end
end