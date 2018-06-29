--! file: player.lua

Config = require "config"
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
    if love.keyboard.isDown(Config.KEYS.WALK_EAST) and love.keyboard.isDown(Config.KEYS.WALK_NORTH) then
        self.direction = Config.DIRECTION.NE
        self.body:setLinearVelocity(self.speed, -self.speed)
    elseif love.keyboard.isDown(Config.KEYS.WALK_EAST) and love.keyboard.isDown(Config.KEYS.WALK_SOUTH) then
        self.direction = Config.DIRECTION.SE
        self.body:setLinearVelocity(self.speed, self.speed)
    elseif love.keyboard.isDown(Config.KEYS.WALK_WEST) and love.keyboard.isDown(Config.KEYS.WALK_NORTH) then
        self.direction = Config.DIRECTION.NW
        self.body:setLinearVelocity(-self.speed, -self.speed)
    elseif love.keyboard.isDown(Config.KEYS.WALK_WEST) and love.keyboard.isDown(Config.KEYS.WALK_SOUTH) then
        self.direction = Config.DIRECTION.SW
        self.body:setLinearVelocity(-self.speed, self.speed)
    elseif love.keyboard.isDown(Config.KEYS.WALK_EAST) then
        self.direction = Config.DIRECTION.E
        self.body:setLinearVelocity(self.speed, 0)
    elseif love.keyboard.isDown(Config.KEYS.WALK_WEST) then
        self.direction = Config.DIRECTION.W
        self.body:setLinearVelocity(-self.speed, 0)
    elseif love.keyboard.isDown(Config.KEYS.WALK_NORTH) then
        self.direction = Config.DIRECTION.N
        self.body:setLinearVelocity(0, -self.speed)
    elseif love.keyboard.isDown(Config.KEYS.WALK_SOUTH) then
        self.direction = Config.DIRECTION.S
        self.body:setLinearVelocity(0, self.speed)
    end
    
    if love.keyboard.isDown(Config.KEYS.SHOOT) then
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
    if key == Config.KEYS.WALK_WEST or key == Config.KEYS.WALK_EAST or key == Config.KEYS.WALK_SOUTH or key == Config.KEYS.WALK_NORTH then
        self.body:setLinearVelocity(0,0)
    end
end

function Player:draw()
    love.graphics.setColor(unpack(Config.PLAYER_COLOR))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
    
    for i, b in pairs(self.bullet) do 
        b:draw()
    end
end

function Player:getPosition()
    pos = {}
    pos.x = self.body:getX()
    pos.y = self.body:getY()
    return pos;
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