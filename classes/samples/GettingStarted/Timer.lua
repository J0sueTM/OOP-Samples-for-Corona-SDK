require "classes.constants.screen"

Timer={}

function Timer:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundTimer.png", 360, 570)
    local timeDelay = 500
    local timerID
    local isPaused = false
    local isRunning = true
    local labelCounter = display.newText("0", 0, 0, native.systemFontBold, 160)
    local yLabelMessagePosition = 40
    local buttonChangeState = widget.newButton({
        id = "buttonChangeState",
        width = 171,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Pause",
        labelColor = {default={1, 1, 1}, over={0, 0, 0, 0.5}},
        font = native.systemFontBold,
        fontSize = 22,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonChangeStateClick(event)
            end
        end
    })
    local buttonCancel = widget.newButton({
        id = "buttonCancel",
        width = 171,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Cancel",
        labelColor = {default={1,1,1}, over={0, 0, 0, 0.5}},
        font = native.systemFontBold,
        fontSize = 22,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonCancelClick(event)
            end
        end
    })

    function private.Timer()

        background.x = screen.centerX
        background.y = screen.centerY

        buttonChangeState.x = screen.centerX
        buttonChangeState.y = 360

        buttonCancel.x = screen.centerX
        buttonCancel.y = 430

        labelCounter.x = screen.centerX
        labelCounter.y = 105
        labelCounter:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelCounter)
        this:insert(buttonChangeState)
        this:insert(buttonCancel)

        timerID = timer.performWithDelay(timeDelay, labelCounter, 50)

    end

    function labelCounter:timer(event)
        local count = event.count

        print("Called " .. count .. " time(s)")
        self.text = count

        if count >= 20 then
            timer.cancel(event.source)
        end
    end

    function private.onButtonChangeStateClick(event)
        local result

        if isPaused then
            buttonChangeState:setLabel("Pause")
            isPaused = false
            result = timer.resume(timerID)
            private.printMessage("Resume: " .. result)
        else
            buttonChangeState:setLabel("Resume")
            isPaused = true
            result = timer.pause(timerID)
            private.printMessage("Pause: " .. result)
        end

        if not isRunning then
            buttonChangeState:setLabel("Pause")
            isPaused = false
            timerID = timer.performWithDelay(timeDelay, labelCounter, 50)
            isRunning = true
            private.printMessage("Resume: " .. result)
        end
    end

    function private.onButtonCancelClick(event)
        local result1, result2 = timer.cancel(timerID)

        buttonChangeState:setLabel("Start")
        isRunning = false
        labelCounter.text = "0"

        private.printMessage("Cancel: " .. tostring(result1) ..", " .. tostring(result2))
    end

    function private.printMessage(msg)
        print(msg)
        local labelMessage = display.newText(" "..msg, 0, yLabelMessagePosition, native.systemFont, 13)
        labelMessage.anchorX = 0
        this:insert(labelMessage)
        yLabelMessagePosition = yLabelMessagePosition + 20
    end

    function public:destroy()
        timer.cancel(timerID)
        timerID = nil

        background:removeSelf()
        background = nil

        labelCounter:removeSelf()
        labelCounter = nil

        buttonChangeState:removeSelf()
        buttonChangeState = nil

        buttonCancel:removeSelf()
        buttonCancel = nil

        this:removeSelf()
        this = nil
    end

    private.Timer()
    return this
end
return Timer
