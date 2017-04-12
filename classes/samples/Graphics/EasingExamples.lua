require "classes.constants.screen"

EasingExamples={}

function EasingExamples:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelInfo = display.newText("Tap to start the Easing samples", 0, 0, nil, 16)
    local currentEasing = 0
    local labelEase1, labelEase2, labelEase3, labelEase4, labelEase5, labelEase6, labelEase7
    local circle1, circle2, circle3, circle4, circle5, circle6, circle7

    function private.EasingExamples()

        background.x = screen.centerX
        background.y = screen.centerY
        background.isHitTestable = true

        labelInfo.x = screen.centerX
        labelInfo.y = screen.centerY
        labelInfo.anchorX = 0.5
        labelInfo.anchorY = 0.5
        labelInfo:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelInfo)

        background:addEventListener("tap", private.onBackgroundTap)

    end

    function private.ease1()
        if not labelEase1 then
            labelEase1 = display.newText("Linear", 0, 10, native.systemFontBold, 12)
            labelEase1.anchorX = 0
            labelEase1.anchorY = 0
            labelEase1:setFillColor( 255/255, 0/255, 0/255)
            this:insert(labelEase1)
        end

        if not circle1 then
            circle1 = display.newCircle(20, 60, 10)
            circle1:setFillColor(255/255, 0/255, 0/255)
            this:insert(circle1)
        else
            circle1.y = 60
        end

        transition.to(circle1, {time=3000, y=460})
    end

    function private.ease2()
        if not labelEase2 then
            labelEase2 = display.newText("inOutExpo", 45, 30, native.systemFontBold, 12)
            labelEase2.anchorX = 0
            labelEase2.anchorY = 0
            labelEase2:setFillColor(255/255, 0/255, 255/255)
            this:insert(labelEase2)
        end

        if not circle2 then
            circle2 = display.newCircle(65, 60, 10)
            circle2:setFillColor(255/255, 0/255, 255/255)
            this:insert(circle2)
        else
            circle2.y = 60
        end

        transition.to(circle2, {time=3000, y=460, transition = easing.inOutExpo})
    end

    function private.ease3()
        if not labelEase3 then
            labelEase3 = display.newText("inOutQuad", 90, 10, native.systemFontBold, 12)
            labelEase3.anchorX = 0
            labelEase3.anchorY = 0
            labelEase3:setFillColor(255/255, 255/255, 255/255)
            this:insert(labelEase3)
        end

        if not circle3 then
            circle3 = display.newCircle(110, 60, 10)
            circle3:setFillColor(255/255, 255/255, 255/255)
            this:insert(circle3)
        else
            circle3.y = 60
        end

        transition.to(circle3, {time=3000, y=460, transition = easing.inOutQuad})
    end

    function private.ease4()
        if not labelEase4 then
            labelEase4 = display.newText("outExpo", 135, 30, native.systemFontBold, 12)
            labelEase4.anchorX = 0
            labelEase4.anchorY = 0
            labelEase4:setFillColor(0/255, 255/255, 255/255)
            this:insert(labelEase4)
        end

        if not circle4 then
            circle4 = display.newCircle(155, 60, 10)
            circle4:setFillColor(0/255, 255/255, 255/255)
            this:insert(circle4)
        else
            circle4.y = 60
        end

        transition.to(circle4, {time=3000, y=460, transition = easing.outExpo})
    end

    function private.ease5()
        if not labelEase5 then
            labelEase5 = display.newText("outQuad", 180, 10, native.systemFontBold, 12)
            labelEase5.anchorX = 0
            labelEase5.anchorY = 0
            labelEase5:setFillColor(0/255, 0/255, 255/255)
            this:insert(labelEase5)
        end

        if not circle5 then
            circle5 = display.newCircle(200, 60, 10)
            circle5:setFillColor(0/255, 0/255, 255/255)
            this:insert(circle5)
        else
            circle5.y = 60
        end

        transition.to(circle5, {time=3000, y=460, transition = easing.outQuad})
    end

    function private.ease6()
        if not labelEase6 then
            labelEase6 = display.newText("inExpo", 225, 30, native.systemFontBold, 12)
            labelEase6.anchorX = 0
            labelEase6.anchorY = 0
            labelEase6:setFillColor(255/255, 255/255, 0/255)
            this:insert(labelEase6)
        end

        if not circle6 then
            circle6 = display.newCircle(245, 60, 10)
            circle6:setFillColor(255/255, 255/255, 0/255)
            this:insert(circle6)
        else
            circle6.y = 60
        end

        transition.to(circle6, {time=3000, y=460, transition = easing.inExpo})
    end

    function private.ease7()
        if not labelEase7 then
            labelEase7 = display.newText("inQuad", 270, 10, native.systemFontBold, 12)
            labelEase7.anchorX = 0
            labelEase7.anchorY = 0
            labelEase7:setFillColor(0/255, 255/255, 0/255)
            this:insert(labelEase7)
        end

        if not circle7 then
            circle7 = display.newCircle(290, 60, 10)
            circle7:setFillColor(0/255, 255/255, 0/255)
            this:insert(circle7)
        else
            circle7.y = 60
        end

        transition.to(circle7, {time=3000, y=460, transition = easing.inQuad})
    end

    function private.onBackgroundTap(event)
        if currentEasing == 0 then
            private.ease1()
            private.ease2()
            private.ease3()
            private.ease4()
            private.ease5()
            private.ease6()
            private.ease7()
            labelInfo.text = "Tap to cycle through Easing functions"
        elseif currentEasing == 1 then
            private.ease1()
        elseif currentEasing == 2 then
            private.ease2()
        elseif currentEasing == 3 then
            private.ease3()
        elseif currentEasing == 4 then
            private.ease4()
        elseif currentEasing == 5 then
            private.ease5()
        elseif currentEasing == 6 then
            private.ease6()
        elseif currentEasing == 7 then
            private.ease7()
        end

        currentEasing = currentEasing + 1

        if currentEasing > 7 then
            currentEasing = 1
        end

        return true
    end

    function public:destroy()
        background:removeEventListener("tap", private.onBackgroundTap)

        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        this:removeSelf()
        this = nil
    end

    private.EasingExamples()
    return this
end
return EasingExamples
