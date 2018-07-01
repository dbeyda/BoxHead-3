--! file: walls.lua

Config = require 'config'
Walls = Object:extend()

function Walls:new()

    local screenWidth, screenHeight = love.graphics.getDimensions()

    leftWall = {}
    leftWall.b = love.physics.newBody(world, 10, screenHeight / 2, 'static')
    leftWall.s = love.physics.newRectangleShape(20, screenHeight)
    leftWall.f = love.physics.newFixture(leftWall.b, leftWall.s)
    leftWall.f:setUserData('wall')
    leftWall.f:setCategory(Config.WALL_CATEGORY)

    rightWall = {}
    rightWall.b = love.physics.newBody(world, screenWidth - 10, screenHeight / 2, 'static')
    rightWall.s = love.physics.newRectangleShape(20, screenHeight)
    rightWall.f = love.physics.newFixture(rightWall.b, rightWall.s)
    rightWall.f:setUserData('wall')
    rightWall.f:setCategory(Config.WALL_CATEGORY)

    topWall = {}
    topWall.b = love.physics.newBody(world, screenWidth /2, 10, 'static')
    topWall.s = love.physics.newRectangleShape(screenWidth - 20, 20)
    topWall.f = love.physics.newFixture(topWall.b, topWall.s)
    topWall.f:setUserData('wall')
    topWall.f:setCategory(Config.WALL_CATEGORY)

    bottomWall = {}
    bottomWall.b = love.physics.newBody(world, screenWidth /2, screenHeight - 10, 'static')
    bottomWall.s = love.physics.newRectangleShape(screenWidth - 20, 20)
    bottomWall.f = love.physics.newFixture(bottomWall.b, bottomWall.s)
    bottomWall.f:setUserData('wall')
    bottomWall.f:setCategory(Config.WALL_CATEGORY)



end

function Walls:draw(player)
    love.graphics.setColor(181, 120, 82, 255)
    screenWidth, screenHeight = love.graphics.getDimensions()
    pos = player:getPosition()
    a, b, c, d, e, f, g, h = leftWall.b:getWorldPoints(leftWall.s:getPoints())
    love.graphics.polygon('fill', a-pos.x+screenWidth/2, b-pos.y+screenHeight/2,
                                    c-pos.x+screenWidth/2, d-pos.y+screenHeight/2,
                                    e-pos.x+screenWidth/2, f-pos.y+screenHeight/2,
                                    g-pos.x+screenWidth/2, h-pos.y+screenHeight/2)
    a, b, c, d, e, f, g, h = rightWall.b:getWorldPoints(rightWall.s:getPoints())
    love.graphics.polygon('fill', a-pos.x+screenWidth/2, b-pos.y+screenHeight/2,
    c-pos.x+screenWidth/2, d-pos.y+screenHeight/2,
    e-pos.x+screenWidth/2, f-pos.y+screenHeight/2,
    g-pos.x+screenWidth/2, h-pos.y+screenHeight/2)
    a, b, c, d, e, f, g, h = topWall.b:getWorldPoints(topWall.s:getPoints())
    love.graphics.polygon('fill', a-pos.x+screenWidth/2, b-pos.y+screenHeight/2,
    c-pos.x+screenWidth/2, d-pos.y+screenHeight/2,
    e-pos.x+screenWidth/2, f-pos.y+screenHeight/2,
    g-pos.x+screenWidth/2, h-pos.y+screenHeight/2)
    a, b, c, d, e, f, g, h = bottomWall.b:getWorldPoints(bottomWall.s:getPoints())
    love.graphics.polygon('fill', a-pos.x+screenWidth/2, b-pos.y+screenHeight/2,
    c-pos.x+screenWidth/2, d-pos.y+screenHeight/2,
    e-pos.x+screenWidth/2, f-pos.y+screenHeight/2,
    g-pos.x+screenWidth/2, h-pos.y+screenHeight/2)
end