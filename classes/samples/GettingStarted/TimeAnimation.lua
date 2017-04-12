require "classes.constants.screen"

TimeAnimation={}

function TimeAnimation:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundTimeAnimation.png", 360, 570)
    local labelInfo = display.newText("Drag or fling ball to bounce", 0, 0, native.systemFontBold, 20)
    local ball = display.newCircle(0, 0, 40)
    local lastTime = 0
    local prevTime = 0
    local friction = 0.8
    local g = .09

    function private.TimeAnimation()

        background.x = screen.centerX
        background.y = screen.centerY

        labelInfo.x = screen.centerX
        labelInfo.y = 60
        labelInfo.anchorX = 0.5
        labelInfo.anchorY = 0.5
        labelInfo:setFillColor(255/255, 255/255, 255/255)

        ball:setFillColor(255/255, 255/255, 255/255, 166/255)
        ball.x = screen.centerX
        ball.y = ball.height
        ball.vx = 0
        ball.vy = 0
        ball.xPrev  = 0
        ball.yPrev  = 0

        this:insert(background)
        this:insert(labelInfo)
        this:insert(ball)

        ball:addEventListener("touch", private.onDragBall)
        Runtime:addEventListener("enterFrame", private.setTimeFromRunApp)
        Runtime:addEventListener("enterFrame", private.updateBallPosition)
    end

    function private.setTimeFromRunApp(event)
        lastTime = event.time
        Runtime:removeEventListener("enterFrame", private.setTimeFromRunApp)
    end

    function private.updateBallPosition(event)
        local timePassed = event.time - lastTime

        lastTime = lastTime + timePassed
        ball.vy = ball.vy + g
        ball.x = ball.x + ball.vx*timePassed
        ball.y = ball.y + ball.vy*timePassed

        if ball.x+ball.width/2 >= screen.right then
            ball.x = screen.right - ball.width/2
            ball.vx = ball.vx*friction
            ball.vx = -ball.vx
        elseif ball.x - ball.width/2 <= screen.left  then
            ball.x = screen.left + ball.width/2
            ball.vx = ball.vx*friction
            ball.vx = -ball.vx
        end

        if ball.y >= screen.bottom - ball.height/2 then
            ball.y = screen.bottom - ball.height/2
            ball.vy = ball.vy*friction
            ball.vx = ball.vx*friction
            ball.vy = -ball.vy
        elseif ball.y <= screen.top + ball.height/2 then
            ball.y = screen.top + ball.height/2
            ball.vy = ball.vy*friction
            ball.vy = -ball.vy
        end
    end

    function private.onDragBall(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus(event.target)
            event.target.isFocus = true

            event.target.x0 = event.x - event.target.x
            event.target.y0 = event.y - event.target.y

            Runtime:removeEventListener("enterFrame", private.updateBallPosition)
            Runtime:addEventListener("enterFrame", private.updateBallParameters)
        elseif event.target.isFocus then
            if event.phase == "moved" then
                event.target.x = event.x - event.target.x0
                event.target.y = event.y - event.target.y0
            elseif event.phase == "ended" or event.phase == "cancelled" then
                lastTime = event.time

                Runtime:removeEventListener("enterFrame", private.updateBallParameters)
                Runtime:addEventListener("enterFrame", private.updateBallPosition)

                display.getCurrentStage():setFocus(nil)
                event.target.isFocus = false
            end
        end

        return true
    end

    function private.updateBallParameters(event)
        local timePassed = event.time - prevTime

        prevTime = prevTime + timePassed

        ball.vx = (ball.x - ball.xPrev)/timePassed
        ball.vy = (ball.y - ball.yPrev)/timePassed

        ball.xPrev = ball.x
        ball.yPrev = ball.y
    end

    function public:destroy()
        ball:removeEventListener("touch", private.onDragBall)
        Runtime:removeEventListener("enterFrame", private.updateBallPosition)
        Runtime:removeEventListener("enterFrame", private.updateBallParameters)

        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        ball:removeSelf()
        ball = nil

        this:removeSelf()
        this = nil
    end

    private.TimeAnimation()
    return this
end
return TimeAnimation
