screenWidth, screenHeight = love.graphics.getDimensions()

function getRandomPosition()
    return math.random(0, screenWidth), math.random(0, screenHeight)
end