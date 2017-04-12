require "classes.constants.screen"

CollisionDetection={}

function CollisionDetection:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect( "img/backgroundCollision.png", 360, 570)
    local ground = display.newImageRect("img/groundDebugDraw.png", 360, 72)
    local crate1 = display.newImageRect("img/crateCube.png", 60, 60)
    local crate2 = display.newImageRect("img/crateCube.png", 60, 60)

    function private.CollisionDetection()
        physics.start()

        background.x = screen.centerX
        background.y = screen.centerY

        ground.x = screen.centerX
        ground.y = 445
        ground.id = "ground"
        physics.addBody(ground, "static", {friction=0.5, bounce=0.3 })

        crate1.x = 180
        crate1.y = -50
        crate1.id = "first crate"
        physics.addBody(crate1, {density=3.0, friction=0.5, bounce=0.3})

        crate2.x = 180
        crate2.y = -150
        crate2.id = "second crate"
        physics.addBody(crate2, {density=3.0, friction=0.5, bounce=0.3})


        this:insert(background)
        this:insert(ground)
        this:insert(crate1)
        this:insert(crate2)


        crate1.collision = private.onLocalCollision
        crate1:addEventListener("collision")

        crate2.collision = private.onLocalCollision
        crate2:addEventListener("collision")

        crate1.preCollision = private.onLocalPreCollision
        crate1:addEventListener("preCollision", crate1)
        crate1.postCollision = private.onLocalPostCollision
        crate1:addEventListener("postCollision", crate1)

        Runtime:addEventListener("collision", private.onGlobalCollision)

    end

    function private.onLocalCollision(self, event) --Method 1
        if event.phase == "began" then
            print(self.id .. ": collision began with " .. event.other.id)
        elseif event.phase == "ended" then
            print(self.id .. ": collision ended with " .. event.other.id)
        end
    end

    function private.onGlobalCollision(event) --Method 2
        if event.phase == "began" then
            print("Global report: " .. event.object1.id .. " & " .. event.object2.id .. " collision began")
        elseif event.phase == "ended" then
            print("Global report: " .. event.object1.id .. " & " .. event.object2.id .. " collision ended")
        end

        print("**** " .. event.element1 .. " -- " .. event.element2)
    end

    function private.onLocalPreCollision(self, event)
        print("preCollision: " .. self.id .. " is about to collide with " .. event.other.id)
    end

    function private.onLocalPostCollision(self, event)
        if event.force > 5.0 then
            print("postCollision force: " .. event.force .. ", friction: " .. event.friction)
        end
    end

    function public:destroy()
        crate1:removeEventListener("collision")
        crate2:removeEventListener("collision")
        crate1:removeEventListener("preCollision", crate1)
        crate1:removeEventListener("postCollision", crate1)
        Runtime:removeEventListener("collision", private.onGlobalCollision)

        background:removeSelf()
        background = nil

        ground:removeSelf()
        ground = nil

        crate1:removeSelf()
        crate1 = nil

        crate2:removeSelf()
        crate2 = nil

        this:removeSelf()
        this = nil
    end

    private.CollisionDetection()
    return this
end
return CollisionDetection
