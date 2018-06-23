
function love.load()
    Object = require 'lib.classic'
    require "entities.player"
    p1 = Player()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    
 
end


function love.update(dt)
    p1:update(dt)
end


function love.draw()
    p1:draw()
end

function love.keypress(key)

end
