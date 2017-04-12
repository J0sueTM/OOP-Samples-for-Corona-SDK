require "classes.constants.screen"

DragPlatforms={}

function DragPlatforms:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect("img/backgroundDragPlatforms.png", 360, 570)
    local ground = display.newImageRect("img/floor.png", 360, 75)
    local platform1 = display.newImageRect("img/platform1.png", 110, 26)
    local platform2 = display.newImageRect("img/platform2.png", 117, 25)
    local house = display.newImageRect("img/house.png", 61, 57)
    local crate = display.newImageRect("img/cratePlatforms.png", 57, 57)
    local books = display.newImageRect("img/wheel.png", 65, 65)

    function private.DragPlatforms()
        physics.start()

        background.x = screen.centerX
        background.y = screen.centerY

        ground.x = 160
        ground.y = 440

        platform1.x = 80
        platform1.y = 200

        platform2.x = 240
        platform2.y = 150

        house.x = 80
        house.y = 150

        crate.x = 90
        crate.y = 90

        books.x = 240
        books.y = 125

        physics.addBody(ground, "static", {friction=0.6})

        physics.addBody(platform1, "kinematic", {friction=0.7})
        platform1.isPlatform = true

        physics.addBody(house, {density=5.0, friction=0.3, bounce=0.4})

        physics.addBody(crate, {density=3.0, friction=0.4, bounce=0.2})

        physics.addBody(platform2, "kinematic", { friction=0.7})
        platform2.isPlatform = true

        physics.addBody(books, {density=1.0, bounce=0.4})
        books.isFixedRotation = true

        this:insert(background)
        this:insert(ground)
        this:insert(platform1)
        this:insert(platform2)
        this:insert(house)
        this:insert(crate)
        this:insert(books)

        platform1:addEventListener("touch", private.startDrag)
        platform2:addEventListener("touch", private.startDrag)
        house:addEventListener("touch", private.startDrag)
        crate:addEventListener("touch", private.startDrag)
        books:addEventListener("touch", private.startDrag)

    end

    function private.startDrag(event)
        local t = event.target
        local phase = event.phase

        if phase == "began" then
            display.getCurrentStage():setFocus(t)
            t.isFocus = true

            t.x0 = event.x - t.x
            t.y0 = event.y - t.y

            event.target.bodyType = "kinematic"
            event.target:setLinearVelocity(0, 0)
            event.target.angularVelocity = 0

        elseif t.isFocus then
            if phase == "moved" then
                t.x = event.x - t.x0
                t.y = event.y - t.y0

            elseif phase == "ended" or phase == "cancelled" then
                display.getCurrentStage():setFocus(nil)
                t.isFocus = false

                if not event.target.isPlatform then
                    event.target.bodyType = "dynamic"
                end
            end
        end

        return true
    end

    function public:destroy()
        platform1:removeEventListener("touch", private.startDrag)
        platform2:removeEventListener("touch", private.startDrag)
        house:removeEventListener("touch", private.startDrag)
        crate:removeEventListener("touch", private.startDrag)
        books:removeEventListener("touch", private.startDrag)

        background:removeSelf()
        background = nil

        ground:removeSelf()
        ground = nil

        platform1:removeSelf()
        platform1 = nil

        platform2:removeSelf()
        platform2 = nil

        house:removeSelf()
        house = nil

        crate:removeSelf()
        crate = nil

        books:removeSelf()
        books = nil

        this:removeSelf()
        this = nil
    end

    private.DragPlatforms()
    return this
end
return DragPlatforms
