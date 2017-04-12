require "classes.constants.screen"

StatusBar={}

function StatusBar:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelInfo = display.newText("Mode changes every 2 seconds", 0, 0, native.systemFontBold, 18)
    local timerID
    local modes = {
        display.HiddenStatusBar,
        display.DefaultStatusBar,
        display.DarkStatusBar,
        display.TranslucentStatusBar,
    }
    local modeNames = {
        "display.HiddenStatusBar",
        "display.DefaultStatusBar",
        "display.DarkStatusBar",
        "display.TranslucentStatusBar",
    }

    function private.StatusBar()

        background.x = screen.centerX
        background.y = screen.centerY

        labelInfo.x = screen.centerX
        labelInfo.y = screen.height*0.8
        labelInfo:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelInfo)

        timerID = timer.performWithDelay(2000, private.changeStatusBarMode, 0)

    end

    function private.changeStatusBarMode(event)
        local numModes = #modes
        local index = event.count % numModes + 1

        labelInfo.text = modeNames[index]
        display.setStatusBar(modes[index])
    end

    function public:destroy()
        display.setStatusBar(display.HiddenStatusBar)

        timer.cancel(timerID)

        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        this:removeSelf()
        this = nil
    end

    private.StatusBar()
    return this
end
return StatusBar
