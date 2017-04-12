require "classes.constants.screen"

KeyEvents={}

function KeyEvents:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local labelTitle = display.newText("Press a key or button", screen.centerX, 40, nil, 20)
    local labelEvent = display.newText({text = "Waiting for key event...", x = screen.centerX, y = screen.centerY, fontSize = 20, align = "center",})

    function private.KeyEvents()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(labelTitle)
        this:insert(labelEvent)

        if  system.getInfo("platformName") ~= "Android" and system.getInfo("platformName") ~= "Win"  then
            labelEvent.text = "Build for Android Device!"
        end

        Runtime:addEventListener("key", private.onKeyEvent)

    end

    function private.onKeyEvent(event)
        local message = "'" .. event.keyName .. "' is " .. event.phase
        print(message)

        if event.device then
            message = event.device.displayName .. "\n" .. message
        end

        labelEvent.text = message

        if event.keyName == "back" and system.getInfo("platformName") == "Android" then
            return true
        end

        return false
    end

    function public:destroy()
        Runtime:removeEventListener("key", private.onKeyEvent)

        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelEvent:removeSelf()
        labelEvent = nil

        this:removeSelf()
        this = nil
    end

    private.KeyEvents()
    return this
end
return KeyEvents
