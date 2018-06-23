--! file: projectile.lua

local bulletStep = 10

Player = Object:extend()

function Player:new()
    self.test = math.random(1, 1000)
    self.x = 100
    self.y = 100
    self.health = 100
    self.currentWeapon = 0
    self.weaponList = {}
    self.width = 40
    self.height = 40
    self.direction = 'down' --! up, down, left, right
end


function Player:update(dt)
    if love.keyboard.isDown('right') then
        self.direction = 'right'
        local new_x = self.x + step
        if new_x >= 0 and new_x <= screenWidth-self.width then
            self.x = new_x
        end
    elseif love.keyboard.isDown('left') then
        self.direction = 'left'
        local new_x = self.x - step
        if new_x >= 0 and new_x <= screenWidth then
            self.x = new_x
        end
    elseif love.keyboard.isDown('up') then
        self.direction = 'up'
        local new_y = self.y - step
        if new_y >= 0 and new_y <= screenHeight then
            self.y = new_y
        end
    elseif love.keyboard.isDown('down') then
        self.direction = 'down'
        local new_y = self.y + step
        if new_y >= 0 and new_y <= screenHeight-self.height then
            self.y = new_y
        end
    end
end


function Player:draw()
    love.graphics.setColor(0, 105, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    --! draw the front of the player
    local xx = 0
    local yy = 0
    local size = 10
    if self.direction == 'up' then
        xx = self.x + (self.width/2) - size/2
        yy = self.y
    elseif self.direction == 'down' then
        xx = self.x + (self.width/2) - size/2
        yy = self.y + self.height - size
    elseif self.direction == 'right' then
        xx = self.x + self.width - size
        yy = self.y + self.height/2 - size/2
    elseif self.direction == 'left' then
        xx = self.x
        yy = self.y + self.height/2 - size/2
    end
    love.graphics.setColor(50, 205, 25, 255)
    love.graphics.rectangle("fill", xx, yy, size, size)
end

function Player.keypress(self, key)

end


function Player:getDirection()
    return self.direction
end

function Player:getWeapon()
    return self.currentWeapon
end