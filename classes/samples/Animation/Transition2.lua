require "classes.constants.screen"

Transition2={}

function Transition2:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect( "img/backgroundTransition2.png", 360, 570)
    local square = display.newRect(0, 0, 100, 100)

    function private.Transition2()

        background.x = screen.centerX
        background.y = screen.centerY

        square.anchorChildren = true
        square:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(square)

        transition.to(square, {time=1500, alpha=0, x=(display.contentWidth-50), y=(display.contentHeight-50)})
        transition.to(square, {time=500, delay=2500, alpha=1.0})

    end

    function public:destroy()
        transition.cancel()

        background:removeSelf()
        background = nil

        square:removeSelf()
        square = nil

        this:removeSelf()
        this = nil
    end

    private.Transition2()
    return this
end
return Transition2
