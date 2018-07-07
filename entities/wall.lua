--! file: walls.lua

Config = require "config"
require "math"
Wall = Object:extend()

Wall.walls = {}

function Wall:new(x, y, width, height, angle, name)
    love.graphics.setColor(100, 25, 80, 0)
    local screenWidth, screenHeight = love.graphics.getDimensions()
    angle = math.rad(angle)
    self.b = love.physics.newBody(world, x, y, "static")
    self.s = love.physics.newRectangleShape((width/2.0) - math.sin(angle)*(width/2.0 + height /2.0) ,  (height/2.0) + math.sin(angle)*(width/2.0 - height /2.0) , width, height, angle)
    self.f = love.physics.newFixture(self.b, self.s)
    self.f:setUserData(name)
    self.f:setCategory(Config.WALL_CATEGORY)
    table.insert(Wall.walls, self)
end

function Wall:draw(dt)
    love.graphics.setColor(100, 25, 80, 0)
end