require "classes.constants.screen"

Flashlight={}

function Flashlight:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newRect(0, 0, 360, 570)
    local image = display.newImageRect("img/backgroundFlashlight.png", 360, 570)
    local circleMask = graphics.newMask("img/circlemask.png")
    local radiusMax = math.sqrt(screen.centerX*screen.centerX + screen.centerY*screen.centerY)
    local labelInfo = display.newText("Touch circle to move flashlight", 0, 0,native.systemFont , 20)

    function private.Flashlight()

        background.x = screen.centerX
        background.y = screen.centerY

        labelInfo.x = screen.centerX
        labelInfo.y = 200
        labelInfo.anchorX = 0.5
        labelInfo.anchorY = 0.5
        labelInfo:setFillColor(255/255, 110/255, 110/255)

        this:insert(background)
        this:insert(image)
        this:insert(labelInfo)

        background:setFillColor(0/255, 0/255, 0/255)
        image:translate(screen.centerX, screen.centerY)
        image:setMask(circleMask)

        image:addEventListener("touch", private.onTouch)
        image.isHitTestMasked = false
        labelInfo:setFillColor(255/255, 255/255, 255/255, 180/255)

    end

    function private.onTouch(event)
        local t = event.target

        if event.phase == "began" then
            display.getCurrentStage():setFocus(t)
            t.isFocus = true

            t.x0 = event.x - t.maskX
            t.y0 = event.y - t.maskY
        elseif t.isFocus then
            if event.phase == "moved" then
                local maskX = event.x - t.x0
                local maskY = event.y - t.y0
                t.maskX = maskX
                t.maskY = maskY

                local radius = math.sqrt(maskX*maskX + maskY*maskY) --Stretch the flashlight
                local scaleDelta = radius/radiusMax
                t.maskScaleX = 1 + scaleDelta
                t.maskScaleY = 1 + 0.2 * scaleDelta

                local rotation = math.deg(math.atan2(maskY, maskX)) --Rotate it
                t.maskRotation = rotation
            elseif event.phase == "ended" or event.phase == "cancelled" then
                display.getCurrentStage():setFocus(nil)
                t.isFocus = false
            end
        end

        return true
    end

    function public:destroy()
        image:removeEventListener("touch", private.onTouch)

        background:removeSelf()
        background = nil

        image:removeSelf()
        image = nil

        labelInfo:removeSelf()
        labelInfo = nil

        this:removeSelf()
        this = nil
    end

    private.Flashlight()
    return this
end
return Flashlight
