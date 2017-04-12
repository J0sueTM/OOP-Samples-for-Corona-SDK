require "classes.constants.screen"

SimpleImageDownload={}

function SimpleImageDownload:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local http = require("socket.http")
    local ltn12 = require("ltn12")
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local labelTitle = display.newText("Simple Image Download", 0, 30, native.systemFontBold, 20)
    local image
    local buttonLoad = widget.newButton({
        id = "buttonLoad",
        width = 171,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Click To Load",
        labelColor = {default={1, 1, 1}, over={0, 0, 0, 0.5}},
        font = native.systemFontBold,
        fontSize = 22,
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.loadImage(event)
            end
        end
    })

    function private.SimpleImageDownload()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle.x = screen.centerX
        labelTitle:setFillColor(255/255, 255/255, 255/255)

        buttonLoad.x = screen.centerX
        buttonLoad.y = 360


        this:insert(background)
        this:insert(labelTitle)
        this:insert(buttonLoad)

    end

    function private.loadImage()
        local path = system.pathForFile("hello.jpg", system.DocumentsDirectory)
        local file = io.open(path, "w+b")

        native.setActivityIndicator(true)

        http.request{
            url = "http://xxxxxxxx.xxx.xx/img/icon.jpg",
            sink = ltn12.sink.file(file),
        }

        timer.performWithDelay(400, private.showImage)
    end

    function private.showImage()
        native.setActivityIndicator(false)

        image = display.newImageRect("hello.jpg", system.DocumentsDirectory, 200, 200)
        image.x=screen.centerX
        image.y=screen.centerY-50
        this:insert(image)
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        buttonLoad:removeSelf()
        buttonLoad = nil

        this:removeSelf()
        this = nil
    end

    private.SimpleImageDownload()
    return this
end
return SimpleImageDownload
