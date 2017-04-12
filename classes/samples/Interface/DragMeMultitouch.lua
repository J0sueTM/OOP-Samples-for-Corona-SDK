require "classes.constants.screen"

DragMeMultitouch={}

function DragMeMultitouch:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local propertiesRectangle = {
        {x=75, y=135, w=50, h=50, r=10, red=0/255, green=158/255, blue=255/255},
        {x=47, y=175, w=75, h=50, r=10, red=146/255, green=197/255, blue=255/255},
        {x=140, y=215, w=100, h=50, r=10, red=0/255, green=87/255, blue=184/255}
    }
    local labelInfoTop = display.newText("", 100,300, native.systemFont, 12)
    local labelInfoBottom = display.newText("", 100,320, native.systemFont, 12)

    function private.DragMeMultitouch()

        system.activate("multitouch")

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(labelInfoTop)
        this:insert(labelInfoBottom)

        labelInfoTop:setFillColor(100,255,255)
        labelInfoBottom:setFillColor(100,255,255)

        for i,item in ipairs(propertiesRectangle) do
            local rectangle = display.newRoundedRect(item.x, item.y, item.w, item.h, item.r)
            rectangle:setFillColor(item.red, item.green, item.blue)
            rectangle.strokeWidth = 6
            rectangle:setStrokeColor(200,200,200,255)

            this:insert(rectangle)

            rectangle:addEventListener("touch", private.onTouch)
        end

        Runtime:addEventListener("touch", private.printTouch2)

    end

    function private.printTouch(event)
        if event.target then
            local bounds = event.target.contentBounds
            print("event(" .. event.phase .. ") ("..event.x..","..event.y..") bounds: "..bounds.xMin..","..bounds.yMin..","..bounds.xMax..","..bounds.yMax)
            labelInfoTop.x = event.x
            labelInfoTop.y = bounds.yMin - 30
            labelInfoTop.text = "event(" .. event.phase .. ") ("..event.x..","..event.y..")"
            labelInfoBottom.x = event.x
            labelInfoBottom.y = bounds.yMin - 10
            labelInfoBottom.text = "bounds: "..bounds.xMin..","..bounds.yMin..","..bounds.xMax..","..bounds.yMax
        end
    end

    function private.onTouch(event)
        local target = event.target
        private.printTouch(event)

        local phase = event.phase
        if phase == "began" then
            local parent = target.parent
            parent:insert(target)
            display.getCurrentStage():setFocus(target, event.id)

            target.isFocus = true

            target.x0 = event.x - target.x
            target.y0 = event.y - target.y
        elseif target.isFocus then
            if phase == "moved" then
                target.x = event.x - target.x0
                target.y = event.y - target.y0
            elseif phase == "ended" or phase == "cancelled" then
                display.getCurrentStage():setFocus(target, nil)
                target.isFocus = false
            end
        end

        return true
    end

    function private.printTouch2(event)
        print("event(" .. event.phase .. ") ("..event.x..","..event.y..")")
        labelInfoTop.x = event.x
        labelInfoTop.y = event.y
        labelInfoTop.text = "event(" .. event.phase .. ") ("..event.x..","..event.y..")"
        labelInfoBottom.text = " "
    end

    function public:destroy()
        Runtime:removeEventListener("touch", private.printTouch2)

        background:removeSelf()
        background = nil

        labelInfoTop:removeSelf()
        labelInfoTop = nil

        labelInfoBottom:removeSelf()
        labelInfoBottom = nil

        this:removeSelf()
        this = nil
    end

    private.DragMeMultitouch()
    return this
end
return DragMeMultitouch
