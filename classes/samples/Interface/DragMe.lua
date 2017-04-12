require "classes.constants.screen"

DragMe={}

function DragMe:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local propertiesRectangle = {
        {x=100, y=60, w=100, h=100, r=10, red=0/255, green=158/255, blue=255/255},
        {x=60, y=100, w=100, h=100, r=10, red=146/255, green=197/255, blue=255/255},
        {x=140, y=140, w=100, h=100, r=10, red=0/255, green=87/255, blue=184/255}
    }

    function private.DragMe()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        for i, item in ipairs(propertiesRectangle) do
            local rectangle = display.newRoundedRect(item.x, item.y, item.w, item.h, item.r)
            rectangle:setFillColor(item.red, item.green, item.blue)
            rectangle.strokeWidth = 6
            rectangle:setStrokeColor(200/255, 200/255, 200/255, 255/255)

            this:insert(rectangle)

            rectangle:addEventListener("touch", private.onTouch)
        end

    end

    function private.onTouch(event)
        local target = event.target
        local phase = event.phase

        if phase == "began" then
            local parent = target.parent
            parent:insert(target)
            display.getCurrentStage():setFocus(target)

            target.isFocus = true

            target.x0 = event.x - target.x
            target.y0 = event.y - target.y
        elseif target.isFocus then
            if phase == "moved" then
                target.x = event.x - target.x0
                target.y = event.y - target.y0
            elseif phase == "ended" or phase == "cancelled" then
                display.getCurrentStage():setFocus(nil)
                target.isFocus = false
            end
        end

        return true
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        this:removeSelf()
        this = nil
    end


    private.DragMe()
    return this
end
return DragMe
