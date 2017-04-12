require "classes.constants.screen"

HelloPhysics={}

function HelloPhysics:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect( "img/backgroundNotifications.png", 360, 570)
    local ground = display.newImageRect("img/groundDebugDraw.png", 360, 72)
    local crate = display.newImageRect("img/crateCube.png", 60, 60)

    function private.HelloPhysics()
        physics.start()

        background.x = screen.centerX
        background.y = screen.centerY

        ground.x = screen.centerX
        ground.y = 445
        ground.id = "ground"
        physics.addBody(ground, "static", {friction=0.5, bounce=0.3})

        crate.x = screen.centerX
        crate.y = screen.top
        crate.rotation = 5
        physics.addBody(crate, {density=3.0, friction=0.5, bounce=0.3})

        this:insert(background)
        this:insert(ground)
        this:insert(crate)

    end

    function public:destroy()
        background:removeSelf()
        background = nil

        ground:removeSelf()
        ground = nil

        crate:removeSelf()
        crate = nil

        this:removeSelf()
        this = nil
    end

    private.HelloPhysics()
    return this
end
return HelloPhysics
