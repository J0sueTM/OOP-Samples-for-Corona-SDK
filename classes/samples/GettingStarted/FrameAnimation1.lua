require "classes.constants.screen"

FrameAnimation1={}

function FrameAnimation1:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect( "img/backgroundFrameAnimation1.png", 360, 570)
    local ball = display.newImageRect( "img/ball.png", 77, 77)

    function private.FrameAnimation1()
        background.x = screen.centerX
        background.y = screen.centerY

        ball.x = screen.centerX
        ball.y = screen.centerY
        ball.xSpeed = 7.5
        ball.ySpeed = 6.4
        ball.xDirection = 1
        ball.yDirection = 1
        ball.radius = 40

        this:insert(background)
        this:insert(ball)

        Runtime:addEventListener("enterFrame", private.animate)
    end

    function private.animate(event)
        if ball.x + (ball.xSpeed * ball.xDirection) > screen.right - ball.radius or ball.x + (ball.xSpeed * ball.xDirection) < screen.left + ball.radius then
            ball.xDirection = -ball.xDirection
        end
        if ball.y + (ball.ySpeed * ball.yDirection) > screen.bottom - ball.radius or ball.y + (ball.ySpeed * ball.yDirection) < screen.top + ball.radius then
            ball.yDirection = -ball.yDirection
        end

        ball.x = ball.x + (ball.xSpeed * ball.xDirection)
        ball.y = ball.y + (ball.ySpeed * ball.yDirection)
    end

    function public:destroy()
        Runtime:removeEventListener("enterFrame", private.animate)

        background:removeSelf()
        background = nil

        ball:removeSelf()
        ball = nil

        this:removeSelf()
        this = nil
    end

    private.FrameAnimation1()
    return this
end
return FrameAnimation1
