require "classes.constants.screen"

LocalNotifications={}

function LocalNotifications:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local notifications = require( "plugin.notifications" )
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local launchArgs -- = ...
    local notificationID
    local notificationTime = 10
    local time = notificationTime
    local timerID
    local badge = "none"
    local setBadge = 0
    local running = false
    local startTime
    local labelTitle = display.newText("Local Notification Test", 0, 0, native.systemFontBold, 18)
    local labelInfoStart = display.newText("", 10, 400, nil, 14)
    local labelInfoCancel = display.newText("", 10, 400+20, nil, 14)
    local labelNotification = display.newText("", 10, 400+35, nil, 14)
    local labelMessage = display.newText("", 10, 400+55, nil, 14)
    local options = {
        alert = "Wake up!",
        badge = 1,
        sound = "sound/notification.wav",
        custom = {msg = "bar"}
    }
    local buttonStartTime = widget.newButton({
        width = 171,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Start With Time",
        labelColor = {
            default = {255/255, 255/255, 255/255},
        },
        fontSize = 18,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.startTimePress(event)
            end
        end
    })
    local buttonCancelAll = widget.newButton({
        width = 171,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Cancel All",
        labelColor = {
            default = {255/255, 255/255, 255/255},
        },
        fontSize = 18,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.cancelAllNotificationPress(event)
            end
        end
    })

    function private.LocalNotifications()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle.x = screen.centerX
        labelTitle.y = 23

        buttonStartTime.x = screen.centerX
        buttonStartTime.y = 70 + 45
        buttonCancelAll.x = screen.centerX
        buttonCancelAll.y = 70 + 60*2

        labelInfoStart.x = 10
        labelInfoStart.y = 400
        labelInfoStart.anchorX = 0
        labelInfoStart.anchorY = 0
        labelInfoCancel.x = 10
        labelInfoCancel.y = 420
        labelInfoCancel.anchorX = 0
        labelInfoCancel.anchorY = 0
        labelNotification.x = 10
        labelNotification.y = 435
        labelNotification.anchorX = 0
        labelNotification.anchorY = 0
        labelNotification:setFillColor(255/255,255/255,0/255)
        labelMessage.x = 10
        labelMessage.y = 455
        labelMessage.anchorX = 0
        labelMessage.anchorY = 0
        labelMessage:setFillColor(255/255,255/255,0/255)

        this:insert(background)
        this:insert(labelTitle)
        this:insert(labelInfoStart)
        this:insert(labelInfoCancel)
        this:insert(labelNotification)
        this:insert(labelMessage)
        this:insert(buttonStartTime)
        this:insert(buttonCancelAll)

        if launchArgs and launchArgs.notification then
            native.showAlert("LaunchArgs Found", launchArgs.notification.alert, {"OK"})
            private.notificationListener( launchArgs.notification )
        end

        Runtime:addEventListener("notification", private.notificationListener)
        timerID = timer.performWithDelay(1000, private.secondTimer, 0)

    end

    function private.startTimePress(event)
        time = notificationTime

        if badge ~= "none" then
            options.badge = badge
        end

        options.custom.msg = "Time Notification"

        notificationID = notifications.scheduleNotification(time, options)
        local textMessage = "Notification using Time: " .. tostring(notificationID)
        labelInfoStart.text = textMessage

        labelNotification.text = ""
        labelInfoCancel.text = ""

        startTime = os.time((os.date('*t')))
        running = true

        print(textMessage)
    end

    function private.cancelAllNotificationPress(event)
        notifications.cancelNotification()

        labelInfoCancel.text = "Notification Cancel All"
    end

    function private.notificationListener(event)
        print("Notification Listener event:")
        local maxStr = 20
        local endStr

        for k,v in pairs(event) do
            local valueString = tostring(v)
            if string.len(valueString) > maxStr then
                endStr = " ... #" .. tostring(string.len(valueString)) .. ")"
            else
                endStr = ")"
            end
            print("   " .. tostring(k) .. "(" .. tostring(string.sub(valueString, 1, maxStr)) .. endStr)
        end

        local badgeOld = native.getProperty("applicationIconBadgeNumber")

        labelNotification.x = 10
        labelNotification.anchorX = 0
        labelNotification.anchorY = 0
        labelNotification.text = "Notification fired: getProperty " ..  tostring(badgeOld) .. ", event.badge " .. tostring(event.badge)

        labelMessage.x = 10
        labelMessage.anchorX = 0
        labelMessage.anchorY = 0
        labelMessage.text = "custom.msg = " .. tostring(event.custom.msg) ..  ", " .. tostring(event.applicationState)
        print("event.custom.msg = ", event.custom.msg, event.applicationState)
    end

    function private.secondTimer(event)
        if running then
            local startTime = notificationTime - tonumber(os.time((os.date('*t'))) - startTime)

            if startTime < 0 then
                running = false
                startTime = 0
            end

            buttonStartTime:setLabel("Start With Time - " .. startTime)
        end
    end

    function public:destroy()
        Runtime:removeEventListener("notification", private.notificationListener)
        timer.cancel(timerID)

        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelInfoStart:removeSelf()
        labelInfoStart = nil

        labelInfoCancel:removeSelf()
        labelInfoCancel = nil

        labelNotification:removeSelf()
        labelNotification = nil

        labelMessage:removeSelf()
        labelMessage = nil

        buttonStartTime:removeSelf()
        buttonStartTime = nil

        buttonCancelAll:removeSelf()
        buttonCancelAll = nil

        this:removeSelf()
        this = nil
    end

    private.LocalNotifications()
    return this
end
return LocalNotifications
