require "classes.constants.screen"

AnchorPoints={}

function AnchorPoints:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundAnchorPoints.png", 360, 570)
    local secondHand = display.newImageRect("img/clockHand.png", 190, 31)
    local timerID

    function private.AnchorPoints()

        background.x = screen.centerX
        background.y = screen.centerY

        secondHand.x = screen.centerX
        secondHand.y = screen.centerY
        secondHand.anchorX = 0.2257
        secondHand.anchorY = 0.5

        this:insert(background)
        this:insert(secondHand)

        timerID = timer.performWithDelay(1000, function()
            secondHand.rotation = secondHand.rotation + 6
        end,
        0)

    end

    function public:destroy()
        timer.cancel(timerID)
        timerID = nil

        background:removeSelf()
        background = nil

        secondHand:removeSelf()
        secondHand = nil

        this:removeSelf()
        this = nil
    end

    private.AnchorPoints()
    return this
end
return AnchorPoints
