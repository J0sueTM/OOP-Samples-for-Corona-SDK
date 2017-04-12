require "classes.constants.screen"

NativeOrientation={}

function NativeOrientation:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelInfo = display.newText("Position (0,0) is the top left in all orientations.", 160, 90, native.systemFont, 13)
    local labelOrientation = display.newText("Orientation: (default)", 0, 90, native.systemFont, 15)
    local buttonAlert = widget.newButton({
        width = 298,
        height = 56,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Press for Alert",
        labelColor = {default={255/255, 255/255, 255/255}, over={255/255, 255/255, 255/255, 0.5}},
        font = native.systemFontBold,
        fontSize = 18,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonAlert(event)
            end
        end
    })

    function private.NativeOrientation()

        background.x = screen.centerX
        background.y = screen.centerY

        buttonAlert.x = 160
        buttonAlert.y = 50

        labelInfo:setFillColor(255/255, 255/255, 255/255)

        labelOrientation.x = labelInfo.x
        labelOrientation.y = labelInfo.y + labelInfo.contentHeight
        labelOrientation:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelInfo)
        this:insert(labelOrientation)
        this:insert(buttonAlert)

        Runtime:addEventListener("orientation", private.onOrientationChange)

    end

    function private.onButtonAlert(event)
        native.showAlert( "Alert!",
                           "This is either a desktop or device native alert dialog.",
                           {"Cancel", "OK"})
    end

    function private.onOrientationChange(event)
        labelOrientation.text = "Orientation: " .. system.orientation
    end

    function public:destroy()
        Runtime:removeEventListener("orientation", private.onOrientationChange)

        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        labelOrientation:removeSelf()
        labelOrientation = nil

        buttonAlert:removeSelf()
        buttonAlert = nil

        this:removeSelf()
        this = nil
    end

    private.NativeOrientation()
    return this
end
return NativeOrientation
