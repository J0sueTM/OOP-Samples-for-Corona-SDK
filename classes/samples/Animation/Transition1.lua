require "classes.constants.screen"

Transition1={}

function Transition1:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local backgroundBlack = display.newRect(0, 0, 360, 570)
    local background = display.newImageRect("img/backgroundTransition1.png", 360, 570)
    local labelCounter = display.newText("Start", 0, 0, system.nativeFont, 50)
    local count = 0
    local timerID

    function private.Transition1()

        backgroundBlack.x = screen.centerX
        backgroundBlack.y = screen.centerY
        backgroundBlack:setFillColor(0/255, 0/255, 0/255)

        background.x = screen.centerX
        background.y = screen.centerY

        labelCounter.x = screen.centerX
        labelCounter.y = screen.centerY
        labelCounter.anchorX = 0.5
        labelCounter.anchorY = 0.5
        labelCounter:setFillColor(255/255, 255/255, 255/255)

        this:insert(backgroundBlack)
        this:insert(background)
        this:insert(labelCounter)

        timerID = timer.performWithDelay(1000, private.repeatFade, 20)

    end

    function private.repeatFade (event)
        background.alpha = 1
        transition.to(background, {alpha=0, time=1000})
        count = count + 1
        labelCounter.text = count
    end

    function public:destroy()
        timer.cancel(timerID)
        timerID = nil

        backgroundBlack:removeSelf()
        backgroundBlack = nil

        background:removeSelf()
        background = nil

        labelCounter:removeSelf()
        labelCounter = nil

        this:removeSelf()
        this = nil
    end

    private.Transition1()
    return this
end
return Transition1
