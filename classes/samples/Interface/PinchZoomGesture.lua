require "classes.constants.screen"

PinchZoomGesture={}

function PinchZoomGesture:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local backgroundBlack = display.newRect(0, 0, 360, 570)
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)

    function private.PinchZoomGesture()
        system.activate("multitouch")

        backgroundBlack.x = screen.centerX
        backgroundBlack.y = screen.centerY
        backgroundBlack:setFillColor(0/255, 0/255, 0/255)

        background.x = screen.centerX
        background.y = screen.centerY


        this:insert(backgroundBlack)
        this:insert(background)


        background:addEventListener("touch", background)

    end

    function private.calculateDelta(previousTouches, event)
        local id,touch = next(previousTouches)
        if event.id == id then
            id,touch = next(previousTouches, id)
            assert(id ~= event.id)
        end

        return touch.x - event.x, touch.y - event.y
    end

    function background:touch(event)
        local previousTouches = self.previousTouches
        local numTotalTouches = 1

        if previousTouches then
            numTotalTouches = numTotalTouches + self.numPreviousTouches
            if previousTouches[event.id] then
                numTotalTouches = numTotalTouches - 1
            end
        end

        if event.phase == "began" then
            if not self.isFocus then
                display.getCurrentStage():setFocus(self)
                self.isFocus = true

                previousTouches = {}
                self.previousTouches = previousTouches
                self.numPreviousTouches = 0
            elseif not self.distance then
                local dx,dy

                if previousTouches and numTotalTouches >= 2 then
                    dx,dy = private.calculateDelta(previousTouches, event)
                end

                if dx and dy then
                    local d = math.sqrt(dx*dx + dy*dy)
                    if d > 0 then
                        self.distance = d
                        self.xScaleOriginal = self.xScale
                        self.yScaleOriginal = self.yScale
                        print("distance = " .. self.distance)
                    end
                end
            end

            if not previousTouches[event.id] then
                self.numPreviousTouches = self.numPreviousTouches + 1
            end

            previousTouches[event.id] = event
        elseif self.isFocus then
            if event.phase == "moved" then
                if self.distance then
                    local dx,dy
                    if previousTouches and numTotalTouches >= 2 then
                        dx,dy = private.calculateDelta(previousTouches, event)
                    end

                    if dx and dy then
                        local newDistance = math.sqrt(dx*dx + dy*dy)
                        local scale = newDistance / self.distance
                        print("newDistance(" ..newDistance .. ") / distance(" .. self.distance .. ") = scale("..  scale ..")")
                        if scale > 0 then
                            self.xScale = self.xScaleOriginal * scale
                            self.yScale = self.yScaleOriginal * scale
                        end
                    end
                end

                if not previousTouches[event.id] then
                    self.numPreviousTouches = self.numPreviousTouches + 1
                end

                previousTouches[event.id] = event
            elseif event.phase == "ended" or event.phase == "cancelled" then
                if previousTouches[event.id] then
                    self.numPreviousTouches = self.numPreviousTouches - 1
                    previousTouches[event.id] = nil
                end

                if #previousTouches > 0 then
                    self.distance = nil
                else
                    display.getCurrentStage():setFocus(nil)

                    self.isFocus = false
                    self.distance = nil
                    self.xScaleOriginal = nil
                    self.yScaleOriginal = nil

                    self.previousTouches = nil
                    self.numPreviousTouches = nil
                end
            end
        end

        return true
    end

    function public:destroy()
        background:removeEventListener("touch", background)

        backgroundBlack:removeSelf()
        backgroundBlack = nil

        background:removeSelf()
        background = nil

        this:removeSelf()
        this = nil
    end

    private.PinchZoomGesture()
    return this
end
return PinchZoomGesture
