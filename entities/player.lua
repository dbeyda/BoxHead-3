--! file: player.lua

local screenWidth, screenHeight = love.graphics.getDimensions()
local playerStep = 5

Player = Object:extend()

function Player:new()
    self.x = 100
    self.y = 100
    self.health = 100
    self.currentWeapon = 0
    self.weaponList = {}
    self.width = 40
    self.height = 40
    self.direction = 'south' --! north, northeast, east, southest, south, southwest, west, northwest
end


function Player:update(dt)
    local newX = self.x
    local newY = self.y

    if love.keyboard.isDown('right') and love.keyboard.isDown('up') then
        self.direction = 'northeast'
        newX = self.x + playerStep
        newY = self.y - playerStep
    elseif love.keyboard.isDown('right') and love.keyboard.isDown('down') then
        self.direction = 'southeast'
        newX = self.x + playerStep
        newY = self.y + playerStep
    elseif love.keyboard.isDown('left') and love.keyboard.isDown('up') then
        self.direction = 'northwest'
        newX = self.x - playerStep
        newY = self.y - playerStep
    elseif love.keyboard.isDown('left') and love.keyboard.isDown('down') then
        self.direction = 'southwest'
        newX = self.x - playerStep
        newY = self.y + playerStep
    elseif love.keyboard.isDown('right') then
        self.direction = 'east'
        newX = self.x + playerStep
        newY = self.y
    elseif love.keyboard.isDown('left') then
        self.direction = 'west'
        newX = self.x - playerStep
        newY = self.y
    elseif love.keyboard.isDown('up') then
        self.direction = 'north'
        newX = self.x
        newY = self.y - playerStep
    elseif love.keyboard.isDown('down') then
        self.direction = 'south'
        newX = self.x
        newY = self.y + playerStep
    end

    if xPositionIsValid(newX, self.width) then
        self.x = newX
    end
    if yPositionIsValid(newY, self.height) then
        self.y = newY
    end
end


function Player:draw()
    love.graphics.setColor(0, 105, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    --! draw the front of the player in the right direction
    local xx = 0
    local yy = 0
    local size = 10
    if self.direction == 'north' then
        xx = self.x + (self.width/2) - size/2
        yy = self.y
    elseif self.direction == 'south' then
        xx = self.x + (self.width/2) - size/2
        yy = self.y + self.height - size
    elseif self.direction == 'east' then
        xx = self.x + self.width - size
        yy = self.y + self.height/2 - size/2
    elseif self.direction == 'west' then
        xx = self.x
        yy = self.y + self.height/2 - size/2
    elseif self.direction == 'northeast' then
        xx = self.x + self.width - size
        yy = self.y
    elseif self.direction == 'northwest' then
        xx = self.x
        yy = self.y
    elseif self.direction == 'southeast' then
        xx = self.x + self.width - size
        yy = self.y + self.height - size
    elseif self.direction == 'southwest' then
        xx = self.x
        yy = self.y + self.height - size
    end
    love.graphics.setColor(50, 0, 0, 255)
    love.graphics.rectangle("fill", xx, yy, size, size)
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