--! file: zombie.lua
Zombie = Object:extend()

function Zombie:new(x, y)
    self.width = 40
    self.height = 40
    self.direction = 'south' --! north, northeast, east, southest, south, southwest, west, northwest
    self.body = love.physics.newBody(world, x, y, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    self.s = love.physics.newRectangleShape(self.width, self.height)
    self.f = love.physics.newFixture(self.body, self.s)          -- connect body to shape
    self.body:setFixedRotation(true)
    self.f:setUserData("Player") 
    self.f:setCategory(4)
    self.f:setMask(4)
end

function Zombie:draw()
    love.graphics.setColor(134, 0, 0, 255)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.s:getPoints()))
end
