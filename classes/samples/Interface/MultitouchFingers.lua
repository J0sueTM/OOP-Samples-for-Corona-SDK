require "classes.constants.screen"

MultitouchFingers={}

function MultitouchFingers:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local arguments = {
        {x=100, y=60, w=100, h=100, r=10, red=0/255, green=158/255, blue=255/255},
        {x=60, y=100, w=100, h=100, r=10, red=146/255, green=197/255, blue=255/255},
        {x=140, y=140, w=100, h=100, r=10, red=0/255, green=87/255, blue=184/255}
    }
    local labelPhase = display.newText("Phase: _____", 55, 450, native.systemFontBold, 12)
    local labelXY = display.newText("(___,___)", 45, 465, native.systemFontBold, 12)
    local labelId = display.newText("Id: ______", 225, 450, native.systemFontBold, 12)
    local labelInfo = display.newText("", screen.centerX, 400, native.systemFontBold, 14)
    local isSimulator = "simulator" == system.getInfo("environment")

    function private.MultitouchFingers()

        system.activate("multitouch")

        background.x = screen.centerX
        background.y = screen.centerY


        this:insert(background)
        this:insert(labelPhase)
        this:insert(labelXY)
        this:insert(labelId)
        this:insert(labelInfo)

        for i,item in ipairs(arguments) do
            local button = display.newRoundedRect(item.x, item.y, item.w, item.h, item.r)
            button:setFillColor(item.red, item.green, item.blue)
            button.strokeWidth = 6
            button:setStrokeColor(200/255, 200/255, 200/255)

            this:insert(button)

            button:addEventListener("touch", private.onTouch)
        end

        if isSimulator then
            labelInfo.text = "Multitouch not supported on Simulator!"
            labelInfo:setFillColor(255/255 , 255/255, 0/255)
        end

        Runtime:addEventListener("touch", private.otherTouch)

    end

    function private.printTouch(event)
        if event.target then
            local bounds = event.target.contentBounds
            print("event(" .. event.phase .. ") ("..event.x..","..event.y..") bounds: "..bounds.xMin..","..bounds.yMin..","..bounds.xMax..","..bounds.yMax)
        end
    end

    function private.showEvent(event)
        labelPhase.text = "Phase: " .. event.phase
        labelXY.text = "(" .. event.x .. "," .. event.y .. ")"
        labelId.text = "Id: " .. tostring(event.id)
    end

    function private.onTouch(event)
        local t = event.target
        private.showEvent(event)

        print ("onTouch - event: " .. tostring(event.target), event.phase, event.target.x, tostring(event.id))

        private.printTouch(event)

        local phase = event.phase

        if phase == "began" then
            local parent = t.parent
            parent:insert(t)
            display.getCurrentStage():setFocus(t, event.id)

            t.isFocus = true

            t.x0 = event.x - t.x
            t.y0 = event.y - t.y
        elseif t.isFocus then
            if phase == "moved" then
                t.x = event.x - t.x0
                t.y = event.y - t.y0
            elseif phase == "ended" or phase == "cancelled" then
                if t.id then
                    t:removeSelf()
                else
                    display.getCurrentStage():setFocus(t, nil)
                    t.isFocus = false
                end
            end
        end

        return true
    end

    function private.otherTouch(event)
        print("otherTouch: event(" .. event.phase .. ") ("..event.x..","..event.y..")" .. tostring(event.id))

        if event.phase == "began" then
            private.showEvent(event)

            local circle = display.newCircle(event.x, event.y, 45)
            circle:setFillColor(0/255, 0/255, 255/255, 1)

            circle.x0 = event.x - circle.x
            circle.y0 = event.y - circle.y
            circle.isFocus = true
            touchCircle = circle
            circle.id = event.id

            circle:addEventListener("touch", private.onTouch)
            event.target = circle
            private.onTouch(event)
        end
    end

    function public:destroy()
        Runtime:removeEventListener("touch", private.otherTouch)

        background:removeSelf()
        background = nil

        labelPhase:removeSelf()
        labelPhase = nil

        labelXY:removeSelf()
        labelXY = nil

        labelId:removeSelf()
        labelId = nil

        labelInfo:removeSelf()
        labelInfo = nil

        this:removeSelf()
        this = nil
    end

    private.MultitouchFingers()
    return this
end
return MultitouchFingers
