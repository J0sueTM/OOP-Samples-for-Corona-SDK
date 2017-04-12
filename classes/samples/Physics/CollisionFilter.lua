require "classes.constants.screen"

CollisionFilter={}

function CollisionFilter:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect("img/backgroundCollisionFilter.png", 360, 570)
    local borderTop = display.newRect(0, 0, 320, 1)
    local borderBottom = display.newRect(0, screen.bottom-10, 320, 1)
    local borderLeft = display.newRect(0, 1, 1, 480)
    local borderRight = display.newRect(319, 1, 1, 480)
    local borderCollisionFilter = {categoryBits = 1, maskBits = 6} --Collides with (4 & 2) only
    local borderBodyElement = {friction=0.4, bounce=0.8, filter=borderCollisionFilter}
    local redCollisionFilter = {categoryBits = 2, maskBits = 3} --Collides with (2 & 1) only
    local blueCollisionFilter = {categoryBits = 4, maskBits = 5} --Collides with (4 & 1) only
    local redBody = {density=0.2, friction=0, bounce=0.95, radius=43.0, filter=redCollisionFilter}
    local blueBody = {density=0.2, friction=0, bounce=0.95, radius=43.0, filter=blueCollisionFilter}
    local balloonRed = {}
    local balloonBlue = {}

    function private.CollisionFilter()
        physics.start()
        physics.setScale(60)

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(borderTop)
        this:insert(borderBottom)
        this:insert(borderLeft)
        this:insert(borderRight)

        borderTop.anchorX = 0
        borderTop.anchorY = 0
        borderTop:setFillColor(0, 0, 0, 0) --Invisible
        physics.addBody(borderTop, "static", borderBodyElement)

        borderBottom.anchorX = 0
        borderBottom.anchorY = 0
        borderBottom:setFillColor(0, 0, 0, 0)
        physics.addBody(borderBottom, "static", borderBodyElement)

        borderLeft.anchorX = 0
        borderLeft.anchorY = 0
        borderLeft:setFillColor(0, 0, 0, 0)
        physics.addBody(borderLeft, "static", borderBodyElement)

        borderRight.anchorX = 0
        borderRight.anchorY = 0
        borderRight:setFillColor(0, 0, 0, 0)
        physics.addBody(borderRight, "static", borderBodyElement)

        for i = 1, 4 do
            balloonRed[i] = display.newImageRect("img/balloonWhite.png", 83, 101)
            balloonRed[i].x = (80*i)-60
            balloonRed[i].y = 50 + math.random(20)
            physics.addBody(balloonRed[i], redBody)
            balloonRed[i].isFixedRotation = true
            this:insert(balloonRed[i])

            balloonBlue[i] = display.newImageRect("img/balloonBlue.png", 83, 101)
            balloonBlue[i].x = (80*i)-60
            balloonBlue[i].y = 250 + math.random(20)
            physics.addBody(balloonBlue[i], blueBody)
            balloonBlue[i].isFixedRotation = true
            this:insert(balloonBlue[i])
        end

    end

    function public:destroy()
        for i = 1, 4 do
            this:remove(balloonRed[i])
            this:remove(balloonBlue[i])
        end

        background:removeSelf()
        background = nil

        borderTop:removeSelf()
        borderTop = nil

        borderBottom:removeSelf()
        borderBottom = nil

        borderLeft:removeSelf()
        borderLeft = nil

        borderRight:removeSelf()
        borderRight = nil

        this:removeSelf()
        this = nil
    end

    private.CollisionFilter()
    return this
end
return CollisionFilter
