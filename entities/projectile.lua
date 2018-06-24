--! file: projectile.lua

local bulletStep = 15


function Player:update(dt)
    if love.keyboard.isDown('right', 'up') then
        self.direction = 'northeast'
        local new_x = self.x + playerStep
        if new_x >= 0 and new_x <= screenWidth-self.width then
            self.x = new_x
        end
    elseif love.keyboard.isDown('right', 'down') then
        self.direction = 'southeast'
        local new_x = self.x - playerStep
        if new_x >= 0 and new_x <= screenWidth then
            self.x = new_x
        end
    elseif love.keyboard.isDown('left', 'up') then
        self.direction = 'northwest'
        local new_y = self.y - playerStep
        if new_y >= 0 and new_y <= screenHeight then
            self.y = new_y
        end
    elseif love.keyboard.isDown('left', 'down') then
        self.direction = 'southwest'
        local new_y = self.y + playerStep
        if new_y >= 0 and new_y <= screenHeight-self.height then
            self.y = new_y
        end
    elseif love.keyboard.isDown('right') then
        self.direction = 'east'
        local newX = self.x + playerStep
        if positionIsValid(newX, self.y, self.width, self.height) then
            self.x = new_x
        end
    elseif love.keyboard.isDown('left') then
        self.direction = 'west'
        local newX = self.x - playerStep
        if positionIsValid(newX, self.y, self.width, self.height) then
            self.x = new_x
        end
    elseif love.keyboard.isDown('up') then
        self.direction = 'north'
        local newY = self.y - playerStep
        if positionIsValid(self.x, newY, self.width, self.height) then
            self.y = new_y
        end
    elseif love.keyboard.isDown('down') then
        self.direction = 'south'
        local newY = self.y + playerStep
        if positionIsValid(self.x, newY, self.width, self.height) then
            self.y = new_y
        end
    end
end