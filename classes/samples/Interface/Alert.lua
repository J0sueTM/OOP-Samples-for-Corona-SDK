require "classes.constants.screen"

Alert={}

function Alert:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local alert
    local timerID

    function private.Alert()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        alert = native.showAlert("Corona", "Dream. Build. Ship.", {"OK", "Learn More"}, private.onComplete)

        timerID = timer.performWithDelay(10000, private.cancelAlert)

    end

    function private.onComplete(event)
        if event.action == "clicked" then
            if event.index == 2 then
                system.openURL("http://www.coronalabs.com")
            end
        end
    end

    function private.cancelAlert()
        native.cancelAlert(alert)
    end

    function public:destroy()
        timer.cancel(timerID)
        timerID = nil

        background:removeSelf()
        background = nil

        alert = nil

        this:removeSelf()
        this = nil
    end

    private.Alert()
    return this
end
return Alert
