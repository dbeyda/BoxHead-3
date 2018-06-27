--! file: player.lua

require "entities.projectile"

local screenWidth, screenHeight = love.graphics.getDimensions()

Player = Object:extend()

function Player:new()
    self.bullet = {}
    self.state = "normal"
    self.lastShot = love.timer.getTime( )
    self.x = 100
    self.y = 100
    self.health = 100
    self.currentWeapon = 0
    self.weaponList = {}
    self.width = 40
    self.height = 40
    self.speed = 300
    self.direction = 'south' --! north, northeast, east, southest, south, southwest, west, northwest
    self.body = love.physics.newBody(world, 400,200, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    self.s = love.physics.newRectangleShape(self.width, self.height)
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setUserData("Player") 
    self.f:setCategory(1)
    self.f:setMask(1,2)
end


function Player:update(dt)
    local newX = self.body:getX()
    local newY = self.body:getY()

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
        if love.timer.getTime( ) - self.lastShot > 0.1 then
            print ("SHOOT!")
            self.lastShot = love.timer.getTime()
            b = Bullet(self.body:getX(), self.body:getY(), self.direction)
            table.insert(self.bullet, b)
        end
    end
end

function Player:keyreleased(key)
    if key == 'left' or key == 'right' or key == 'down' or key == 'up' then
        self.body:setLinearVelocity(0,0)
    end
end


function Player:draw()
    love.graphics.setColor(9, 184, 171, 255)
    love.graphics.polygon("fill", p1.body:getWorldPoints(p1.s:getPoints()))

    if #self.bullet > 0 then
        for i, b in ipairs(self.bullet) do 
            b:draw()
        end
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

function xPositionIsValid(x, width)
    local screenWidth, screenHeight = love.graphics.getDimensions()
    if x >= 0 and x <= screenWidth-width then
        return true
    end
    return False
end

function yPositionIsValid(y, height)
    local screenWidth, screenHeight = love.graphics.getDimensions()
    if y >= 0 and y <= screenHeight-height then
        return true
    end
    return False
end