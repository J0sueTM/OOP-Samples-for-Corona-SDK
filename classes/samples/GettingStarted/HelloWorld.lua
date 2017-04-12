require "classes.constants.screen"

HelloWorld={}

function HelloWorld:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundHelloWord.png", 360, 570)
    local labelTitle = display.newText("", 0, 0, native.systemFont, 40)

    function private.HelloWorld()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle.x = screen.centerX
        labelTitle.y = screen.top
        labelTitle.anchorX = 0.5
        labelTitle.anchorY = 0
        labelTitle:setFillColor(255/255, 255/255, 255/255)
        labelTitle.text = "Hello World!"

        this:insert(background)
        this:insert(labelTitle)

    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        this:removeSelf()
        this = nil
    end

    private.HelloWorld()
    return this
end
return HelloWorld
