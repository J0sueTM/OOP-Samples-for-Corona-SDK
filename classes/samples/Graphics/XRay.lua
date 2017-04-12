require "classes.constants.screen"

XRay={}

function XRay:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require "widget"
    local background = display.newImageRect("img/backgroundXRay.png", 360, 570)
    local image = display.newImageRect("img/skeletonXRay.png", 360, 570)
    local labelInfo = display.newText("Move circle to see behind paper", 0, 0, native.systemFont, 20)
    local circleMask = graphics.newMask("img/circlemask.png")
    local buttonTestMask = widget.newButton({
        width = 230,
        height = 60,
        defaultFile = "img/buttonBlueDefault.png",
        overFile = "img/buttonBluePressed.png",
        label = "Enable Hit Test Mask",
        labelColor = {default={1, 1, 1}, over={0, 0, 0, 0.5}},
        font = native.systemFontBold,
        fontSize = 22,
        emboss = true,
        onRelease = function(event)
            private.onHitButton(event)
        end
    })

    function private.XRay()

        background.x = screen.centerX
        background.y = screen.centerY

        image.x = screen.centerX
        image.y = screen.centerY
        image.anchorX = 0.5
        image.anchorY = 0.5
        image.alpha = 0.7
        image:setMask(circleMask)
        image.isHitTestMasked = false

        labelInfo.x = screen.centerX
        labelInfo.y = 200
        labelInfo.anchorX = 0.5
        labelInfo.anchorY = 0.5
        labelInfo:setFillColor(255/255, 255/255, 255/255, 180/255)

        buttonTestMask.x = screen.centerX
        buttonTestMask.y = screen.height - 60

        this:insert(background)
        this:insert(image)
        this:insert(labelInfo)
        this:insert(buttonTestMask)

        image:addEventListener("touch", private.onTouch)

    end

    function private.onTouch(event)
        local t = event.target
        local phase = event.phase

        if phase == "began" then
            display.getCurrentStage():setFocus(t)

            t.isFocus = true
            t.x0 = event.x - t.maskX
            t.y0 = event.y - t.maskY
        elseif t.isFocus then
            if phase == "moved" then
                t.maskX = event.x - t.x0
                t.maskY = event.y - t.y0
            elseif phase == "ended" or phase == "cancelled" then
                display.getCurrentStage():setFocus(nil)
                t.isFocus = false
            end
        end

        return true
    end

    function private.onHitButton(event)
        if image.isHitTestMasked then
            buttonTestMask:setLabel("Enable Hit Test Mask")
            image.isHitTestMasked = false
        else
            buttonTestMask:setLabel("Disable Hit Test Mask")
            image.isHitTestMasked = true
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

        buttonTestMask:removeSelf()
        buttonTestMask = nil

        this:removeSelf()
        this = nil
    end

    private.XRay()
    return this
end
return XRay
