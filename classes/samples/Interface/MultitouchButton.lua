require "classes.constants.screen"

MultitouchButton={}

function MultitouchButton:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelTitle = display.newText("Multitouch Buttons", screen.centerX, 50, native.systemFontBold, 20)
    local button1 = widget.newButton({
        width = 178,
        height = 56,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Button 1",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        emboss = true
    })
    local button2 = widget.newButton({
        width = 178,
        height = 56,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Button 2",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        emboss = true
    })
    local button3 = widget.newButton({
        width = 178,
        height = 56,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Button 3",
        labelColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255, 0.5 } },
        emboss = true
    })

    function private.MultitouchButton()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle:setFillColor(255/255, 255/255, 255/255)

        button1.x = 160
        button1.y = 160
        button2.x = 160
        button2.y = 240
        button3.x = 160
        button3.y = 320

        this:insert(background)
        this:insert(labelTitle)
        this:insert(button1)
        this:insert(button2)
        this:insert(button3)

        system.activate("multitouch")

    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        button1:removeSelf()
        button1 = nil

        button2:removeSelf()
        button2 = nil

        button3:removeSelf()
        button3 = nil

        this:removeSelf()
        this = nil
    end

    private.MultitouchButton()
    return this
end
return MultitouchButton
