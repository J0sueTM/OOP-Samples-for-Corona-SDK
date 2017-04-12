require "classes.constants.screen"

FrameAnimation2={}

function FrameAnimation2:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundFrameAnimation2.png", 360, 570)
    local collection = {}
    local params = {
                       {radius=20, xDirection=1, yDirection=1, xSpeed=2.8, ySpeed=6.1, r=0/255, g=158/255, b=255/255},
                       {radius=12, xDirection=1, yDirection=1, xSpeed=3.8, ySpeed=4.2, r=146/255, g=197/255, b=255/255},
                       {radius=15, xDirection=1, yDirection=-1, xSpeed=5.8, ySpeed=5.5, r=0/255, g=87/255, b=184/255},
                   }

    function private.FrameAnimation2()
        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        for i, item in ipairs(params) do
            local ball = private.newBall(item)

            collection[#collection + 1] = ball
        end

        Runtime:addEventListener("enterFrame", private.onTick)
    end

    function private.onTick(event)
        for i, ball in ipairs(collection) do
            if ball.x + (ball.xSpeed * ball.xDirection) > screen.right - ball.radius or ball.x + (ball.xSpeed * ball.xDirection) < screen.left + ball.radius then
                ball.xDirection = -ball.xDirection
            end
            if ball.y + (ball.ySpeed * ball.yDirection) > screen.bottom - ball.radius or ball.y + (ball.ySpeed * ball.yDirection) < screen.top + ball.radius then
                ball.yDirection = -ball.yDirection
            end

            ball.x = ball.x + (ball.xSpeed * ball.xDirection)
            ball.y = ball.y + (ball.ySpeed * ball.yDirection)
        end
    end

    function private.newBall(params)
        local circle = display.newCircle(screen.centerX, screen.centerY, params.radius)

        circle:setFillColor(params.r, params.g, params.b, 255/255)
        circle.xDirection = params.xDirection
        circle.yDirection = params.yDirection
        circle.xSpeed = params.xSpeed
        circle.ySpeed = params.ySpeed
        circle.radius = params.radius

        this:insert(circle)

        return circle
    end

    function public:destroy()
        Runtime:removeEventListener("enterFrame", private.onTick)

        background:removeSelf()
        background = nil

        this:removeSelf()
        this = nil
    end

    private.FrameAnimation2()
    return this
end
return FrameAnimation2
