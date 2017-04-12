require "classes.constants.screen"

ActivityIndicator={}

function ActivityIndicator:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelInfo = display.newText("Activity indicator will disappear in:", 0, 0, system.systemFont, 16)
    local numSeconds = 5
    local counter = display.newText(tostring(numSeconds), 0, 0, system.systemFontBold, 36)

    function private.ActivityIndicator()

        background.x = screen.centerX
        background.y = screen.centerY

        labelInfo.x = screen.centerX
        labelInfo.y = screen.top + 100
        labelInfo:setFillColor(255/255, 255/255, 255/255)

        counter.x = screen.centerX
        counter.y = labelInfo.y + 36
        counter:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelInfo)
        this:insert(counter)

        timer.performWithDelay(1000, counter, numSeconds)
        native.setActivityIndicator(true)

    end

    function counter:timer(event)
        numSeconds = numSeconds - 1
        counter.text = tostring(numSeconds)

        if numSeconds == 0 then
            native.setActivityIndicator(false)
        end
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        counter:removeSelf()
        counter = nil

        this:removeSelf()
        this = nil
    end

    private.ActivityIndicator()
    return this
end
return ActivityIndicator
