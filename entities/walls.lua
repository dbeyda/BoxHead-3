--! file: walls.lua

Walls = Object:extend()

function Walls:new()

    local screenWidth, screenHeight = love.graphics.getDimensions()

    leftWall = {}
    leftWall.b = love.physics.newBody(world, 10, screenHeight / 2, "static")
    leftWall.s = love.physics.newRectangleShape(20, screenHeight)
    leftWall.f = love.physics.newFixture(leftWall.b, leftWall.s)
    leftWall.f:setUserData("leftWall")

    rightWall = {}
    rightWall.b = love.physics.newBody(world, screenWidth - 10, screenHeight / 2, "static")
    rightWall.s = love.physics.newRectangleShape(20, screenHeight)
    rightWall.f = love.physics.newFixture(rightWall.b, rightWall.s)
    rightWall.f:setUserData("rightWall")

    topWall = {}
    topWall.b = love.physics.newBody(world, screenWidth /2, 10, "static")
    topWall.s = love.physics.newRectangleShape(screenWidth - 20, 20)
    topWall.f = love.physics.newFixture(topWall.b, topWall.s)
    topWall.f:setUserData("topWall")

    bottomWall = {}
    bottomWall.b = love.physics.newBody(world, screenWidth /2, screenHeight - 10, "static")
    bottomWall.s = love.physics.newRectangleShape(screenWidth - 20, 20)
    bottomWall.f = love.physics.newFixture(bottomWall.b, bottomWall.s)
    bottomWall.f:setUserData("bottomWall")

end

function Walls:draw()
    love.graphics.setColor(181, 120, 82, 255)
    love.graphics.polygon("fill", leftWall.b:getWorldPoints(leftWall.s:getPoints()))
    love.graphics.polygon("fill", rightWall.b:getWorldPoints(rightWall.s:getPoints()))
    love.graphics.polygon("fill", topWall.b:getWorldPoints(topWall.s:getPoints()))
    love.graphics.polygon("fill", bottomWall.b:getWorldPoints(bottomWall.s:getPoints()))
end