require "classes.constants.screen"

Clock={}

function Clock:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local backgroundBlack = display.newRect(screen.centerX, screen.centerY, 570, 570)
    local background = display.newImageRect("img/purple.png", 360, 570)
    local labelHourValue = display.newText("18", 100, 90, native.systemFontBold, 180)
    local labelMinuteValue = display.newText("35", 100, 240, native.systemFontBold, 180)
    local labelSecondValue = display.newText("44", 100, 390, native.systemFontBold, 180)
    local labelHours = display.newText("hours ", 220, 100, native.systemFont, 40)
    local labelMinutes = display.newText("minutes ", 220, 250, native.systemFont, 40)
    local labelSeconds = display.newText("seconds ", 210, 400, native.systemFont, 40)
    local timerID

    function private.Clock()
        this.anchorChildren = true
        this.x = screen.centerX
        this.y = screen.centerY

        backgroundBlack:setFillColor(0/255, 0/255, 0/255)

        background.x = screen.centerX
        background.y = screen.centerY

        labelHours:setFillColor(255/255, 255/255, 255/255)
        labelHourValue:setFillColor(255/255, 255/255, 255/255, 70/255)
        labelHourValue.rotation = -15

        labelMinutes:setFillColor(255/255, 255/255, 255/255)
        labelMinuteValue:setFillColor(255/255, 255/255, 255/255, 70/255)
        labelMinuteValue.rotation = -15

        labelSeconds:setFillColor(255/255, 255/255, 255/255)
        labelSecondValue:setFillColor(255/255, 255/255, 255/255, 70/255)
        labelSecondValue.rotation = -15

        this:insert(backgroundBlack)
        this:insert(background)
        this:insert(labelHourValue)
        this:insert(labelMinuteValue)
        this:insert(labelSecondValue)
        this:insert(labelHours)
        this:insert(labelMinutes)
        this:insert(labelSeconds)

        private.updateTime()

        timerID = timer.performWithDelay(1000, private.updateTime, -1)
        Runtime:addEventListener("orientation", private.onOrientationChange)

    end

    function private.updateTime(event)
        local time = os.date("*t")
        local hourText = time.hour
        local minuteText = time.min
        local secondText = time.sec

        if hourText < 10 then
            hourText = "0" .. hourText
        end

        if minuteText < 10 then
            minuteText = "0" .. minuteText
        end

        if secondText < 10 then
            secondText = "0" .. secondText
        end

        labelHourValue.text = hourText
        labelMinuteValue.text = minuteText
        labelSecondValue.text = secondText
    end

    function private.onOrientationChange(event)
        local direction = event.type
        local newAngle = this.rotation - event.delta

        if direction == "landscapeLeft" or direction == "landscapeRight" then
            labelHourValue.y = 120
            labelSecondValue.y = 360
            labelHours.y = 130
            labelSeconds.y = 370
        elseif direction == "portrait" or direction == "portraitUpsideDown" then
            labelHourValue.y = 90
            labelSecondValue.y = 390
            labelHours.y = 100
            labelSeconds.y = 400
        end

        transition.to(this, {time=150, rotation=newAngle})
    end

    function public:destroy()
        Runtime:removeEventListener("orientation", private.onOrientationChange)
        timer.cancel(timerID)

        backgroundBlack:removeSelf()
        backgroundBlack = nil

        background:removeSelf()
        background = nil

        labelHourValue:removeSelf()
        labelHourValue = nil

        labelMinuteValue:removeSelf()
        labelMinuteValue = nil

        labelSecondValue:removeSelf()
        labelSecondValue = nil

        labelHours:removeSelf()
        labelHours = nil

        labelMinutes:removeSelf()
        labelMinutes = nil

        labelSeconds:removeSelf()
        labelSeconds = nil

        this:removeSelf()
        this = nil
    end

    private.Clock()
    return this
end
return Clock
