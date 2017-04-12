require "classes.constants.screen"

Accelerometer={}

function Accelerometer:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local isSimulator = system.getInfo("environment") == "simulator"
    local labelTitle = display.newText("Accelerator / Shake", screen.centerX, 20, native.systemFontBold, 20)
    local labelMessage = display.newText("", screen.centerX, 55, native.systemFontBold, 13)
    local soundID = audio.loadSound ("sound/beep_wav.wav")
    local frameUpdate = false
    local labelGravityX = display.newText("gravity x = ", 50, 95, native.systemFont, 24)
    local labelGravityY = display.newText("gravity y = ", 50, 120, native.systemFont, 24)
    local labelGravityZ = display.newText("gravity z = ", 50, 145, native.systemFont, 24)
    local labelInstantX = display.newText("instant x = ", 50, 170, native.systemFont, 24)
    local labelInstantY = display.newText("instant y = ", 50, 195, native.systemFont, 24)
    local labelInstantZ = display.newText("instant z = ", 50, 220, native.systemFont, 24)
    local labelValueGravityX = display.newText("0.0", 220, 95, native.systemFont, 24)
    local labelValueGravityY = display.newText("0.0", 220, 120, native.systemFont, 24)
    local labelValueGravityZ = display.newText("0.0", 220, 145, native.systemFont, 24)
    local labelValueInstantX = display.newText("0.0", 220, 170, native.systemFont, 24)
    local labelValueInstantY = display.newText("0.0", 220, 195, native.systemFont, 24)
    local labelValueInstantZ = display.newText("0.0", 220, 220, native.systemFont, 24)
    local circle = display.newCircle(0, 0, 20)

    function private.Accelerometer()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle.anchorX = 0.5
        labelTitle.anchorY = 0.5
        labelTitle:setFillColor(255/255, 255/255, 255/255)

        labelMessage:setFillColor(255/255, 255/255, 255/255)

        labelGravityX.anchorX = 0
        labelGravityX.anchorY = 0
        labelGravityX:setFillColor(255/255, 255/255, 255/255)

        labelValueGravityX.anchorX = 0
        labelValueGravityX.anchorY = 0
        labelValueGravityX:setFillColor(255/255, 255/255, 255/255)

        labelGravityY.anchorX = 0
        labelGravityY.anchorY = 0
        labelGravityY:setFillColor(255/255, 255/255, 255/255)

        labelValueGravityY.anchorX = 0
        labelValueGravityY.anchorY = 0
        labelValueGravityY:setFillColor(255/255, 255/255, 255/255)

        labelGravityZ.anchorX = 0
        labelGravityZ.anchorY = 0
        labelGravityZ:setFillColor(255/255, 255/255, 255/255)

        labelValueGravityZ.anchorX = 0
        labelValueGravityZ.anchorY = 0
        labelValueGravityZ:setFillColor(255/255, 255/255, 255/255)

        labelInstantX.anchorX = 0
        labelInstantX.anchorY = 0
        labelInstantX:setFillColor(255/255, 255/255, 255/255)

        labelValueInstantX.anchorX = 0
        labelValueInstantX.anchorY = 0
        labelValueInstantX:setFillColor(255/255, 255/255, 255/255)

        labelInstantY.anchorX = 0
        labelInstantY.anchorY = 0
        labelInstantY:setFillColor(255/255, 255/255, 255/255)

        labelValueInstantY.anchorX = 0
        labelValueInstantY.anchorY = 0
        labelValueInstantY:setFillColor(255/255, 255/255, 255/255)

        labelInstantZ.anchorX = 0
        labelInstantZ.anchorY = 0
        labelInstantZ:setFillColor(255/255, 255/255, 255/255)

        labelValueInstantZ.anchorX = 0
        labelValueInstantZ.anchorY = 0
        labelValueInstantZ:setFillColor(255/255, 255/255, 255/255)

        circle.x = screen.centerX
        circle.y = screen.centerY
        circle.anchorX = 0.5
        circle.anchorY = 0.5
        circle:setFillColor(0/255, 0/255, 255/255)

        this:insert(background)
        this:insert(labelTitle)
        this:insert(labelMessage)
        this:insert(labelGravityX)
        this:insert(labelGravityY)
        this:insert(labelGravityZ)
        this:insert(labelInstantX)
        this:insert(labelInstantY)
        this:insert(labelInstantZ)
        this:insert(labelValueGravityX)
        this:insert(labelValueGravityY)
        this:insert(labelValueGravityZ)
        this:insert(labelValueInstantX)
        this:insert(labelValueInstantY)
        this:insert(labelValueInstantZ)
        this:insert(circle)

        if isSimulator then
            labelMessage.text = "Accelerometer not supported on Simulator"
        end

        system.setAccelerometerInterval(60)
        Runtime:addEventListener("accelerometer", private.onAccelerate)
        Runtime:addEventListener("enterFrame", private.onFrame)

    end

    function private.onFrame()
        frameUpdate = true
    end

    function private.onAccelerate(event)
        private.xyzFormat(labelValueGravityX, event.xGravity)
        private.xyzFormat(labelValueGravityY, event.yGravity)
        private.xyzFormat(labelValueGravityZ, event.zGravity)
        private.xyzFormat(labelValueInstantX, event.xInstant)
        private.xyzFormat(labelValueInstantY, event.yInstant)
        private.xyzFormat(labelValueInstantZ, event.zInstant)

        frameUpdate = false

        circle.x = screen.centerX + (screen.centerX * event.xGravity)
        circle.y = screen.centerY + (screen.centerY * event.yGravity * -1)

        if event.isShake then
            private.showLabelMessage("Shake!", 400, 3, 52, {1, 1, 0})
            audio.play(soundID)
        end
    end

    function private.xyzFormat(labelValue, value)
        labelValue.text = string.format("%1.3f", value)

        if not frameUpdate then
            return
        end

        if value < 0 then
            if labelValue.positive then
                labelValue:setFillColor(1, 0, 0)
                labelValue.positive = false
            end
        else
            if not labelValue.positive then
                labelValue:setFillColor(1, 1, 1)
                labelValue.positive = true
            end

        end
    end

    function private.showLabelMessage(str, location, scrTime, size, color, font)
        local size = tonumber(size) or 24
        local color = color or {255/255, 255/255, 255/255}
        local font = font or native.systemFont
        local labelMessage = display.newText(str, 0, 0, font, size)

        labelMessage.x = screen.centerX

        if type(location) == "string"  then
            if location == "Top" then
                labelMessage.y = screen.height/4
            elseif location == "Bottom" then
                labelMessage.y = (screen.height/4)*3
            else
                labelMessage.y = screen.centerY
            end
        else
            labelMessage.y = tonumber(location) or screen.centerY
        end

        labelMessage:setFillColor(color[1], color[2], color[3])

        scrTime = (tonumber(scrTime) or 3) * 1000

        if scrTime ~= 0 then
            timer.performWithDelay(scrTime, function()
                                                transition.to(labelMessage, {time = 500, alpha = 0}, function() labelMessage.removeSelf() end)
                                             end)
        end

        return labelMessage
    end

    function public:destroy()
        Runtime:removeEventListener("accelerometer", private.onAccelerate)
        Runtime:removeEventListener("enterFrame", private.onFrame)

        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelMessage:removeSelf()
        labelMessage = nil

        labelGravityX:removeSelf()
        labelGravityX = nil

        labelGravityY:removeSelf()
        labelGravityY = nil

        labelGravityZ:removeSelf()
        labelGravityZ = nil

        labelInstantX:removeSelf()
        labelInstantX = nil

        labelInstantY:removeSelf()
        labelInstantY = nil

        labelInstantZ:removeSelf()
        labelInstantZ = nil

        labelValueGravityX:removeSelf()
        labelValueGravityX = nil

        labelValueGravityY:removeSelf()
        labelValueGravityY = nil

        labelValueGravityZ:removeSelf()
        labelValueGravityZ = nil

        labelValueInstantX:removeSelf()
        labelValueInstantX = nil

        labelValueInstantY:removeSelf()
        labelValueInstantY = nil

        labelValueInstantZ:removeSelf()
        labelValueInstantZ = nil

        circle:removeSelf()
        circle = nil

        this:removeSelf()
        this = nil
    end

    private.Accelerometer()
    return this
end
return Accelerometer
