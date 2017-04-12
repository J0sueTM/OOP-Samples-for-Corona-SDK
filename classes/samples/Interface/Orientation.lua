require "classes.constants.screen"

Orientation={}

function Orientation:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelOrientation = display.newText("portrait", screen.centerX, screen.centerY, nil, 30)
    local currentAngle = 0

    function private.Orientation()

        background.x = screen.centerX
        background.y = screen.centerY

        labelOrientation:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelOrientation)

        Runtime:addEventListener("orientation", private.onOrientationChange)

    end

    function private.onOrientationChange(event)
        local direction = event.type
        local angle = currentAngle - event.delta

        labelOrientation.text = event.type

        currentAngle = angle

        transition.to(labelOrientation, {time=150, rotation=angle})
    end

    function public:destroy()
        Runtime:removeEventListener("orientation", private.onOrientationChange)

        background:removeSelf()
        background = nil

        labelOrientation:removeSelf()
        labelOrientation = nil

        this:removeSelf()
        this = nil
    end

    private.Orientation()
    return this
end
return Orientation
