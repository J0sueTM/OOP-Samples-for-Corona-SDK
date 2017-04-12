require "classes.constants.screen"

ButtonEvents={}

function ButtonEvents:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local fieldInfo = display.newRoundedRect(10, 50, 300, 40, 8)
    local labelInfo = display.newText("Waiting for button event...", 0, 0, native.systemFont, 18)
    local button1 = widget.newButton({
        id = "button1",
        width = 178,
        height = 56,
        defaultFile = "img/buttonBlue1Default.png",
        overFile = "img/buttonBlue1Pressed.png",
        label = "Button 1 Label",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        emboss = true,
        onPress = function(event)
            if event.phase == "ended" then
                private.onButton1Press(event)
            end
        end,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButton1Release(event)
            end
        end
    })

    local button2 = widget.newButton({
        id = "button2",
        width = 298,
        height = 56,
        defaultFile = "img/buttonBlue2Default.png",
        overFile = "img/buttonBlue2Pressed.png",
        label = "Button 2 Label",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        font = native.systemFont,
        fontSize = 22,
        emboss = true,
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonClick(event)
            end
        end
    })

    local button3 = widget.newButton({
        id = "button3",
        width = 298,
        height = 56,
        defaultFile = "img/buttonBlue3Default.png",
        overFile = "img/buttonBlue3Pressed.png",
        label = "Button 3 Label",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        font = native.systemFont,
        fontSize = 28,
        emboss = true,
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonClick(event)
            end
        end
    })

    local buttonSmall = widget.newButton({
        id = "buttonSmall",
        width = 73,
        height = 32,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = " I'm Small",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        fontSize = 12,
        emboss = true,
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonClick(event)
            end
        end
    })

    local buttonArrow = widget.newButton({
        id = "buttonArrow",
        width = 40,
        height = 40,
        defaultFile = "img/buttonArrowDefault.png",
        overFile = "img/buttonArrowPressed.png",
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonClick(event)
            end
        end
    })

    function private.ButtonEvents()

        background.x = screen.centerX
        background.y = screen.centerY

        fieldInfo.anchorX = 0
        fieldInfo.anchorY = 0
        fieldInfo:setFillColor(0/255, 0/255, 0/255, 170/255)

        labelInfo.x = screen.centerX
        labelInfo.y = 70

        button1.x = 160
        button1.y = 160
        button2.x = 160
        button2.y = 240
        button3.x = 160
        button3.y = 320
        buttonSmall.x = 85
        buttonSmall.y = 400
        buttonArrow.x = 250
        buttonArrow.y = 400


        this:insert(background)
        this:insert(fieldInfo)
        this:insert(labelInfo)
        this:insert(button1)
        this:insert(button2)
        this:insert(button3)
        this:insert(buttonSmall)
        this:insert(buttonArrow)

    end

    function private.onButton1Press(event)
        labelInfo.text = "Button 1 pressed"
    end

    function private.onButton1Release(event)
        labelInfo.text = "Button 1 released"
    end

    function private.onButtonClick(event)
        labelInfo.text = "id = " .. event.target.id .. ", phase = " .. event.phase
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        fieldInfo:removeSelf()
        fieldInfo = nil

        labelInfo:removeSelf()
        labelInfo = nil

        button1:removeSelf()
        button1 = nil

        button2:removeSelf()
        button2 = nil

        button3:removeSelf()
        button3 = nil

        buttonSmall:removeSelf()
        buttonSmall = nil

        buttonArrow:removeSelf()
        buttonArrow = nil

        this:removeSelf()
        this = nil
    end

    private.ButtonEvents()
    return this
end
return ButtonEvents
