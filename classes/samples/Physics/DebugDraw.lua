require "classes.constants.screen"

DebugDraw={}

function DebugDraw:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect("img/backgroundDebugDraw.png", 360, 570)
    local labelInfo = display.newText("drag any object", screen.centerX, 25, native.systemFontBold, 20)
    local ground = display.newImageRect("img/groundDebugDraw.png", 360, 125)
    local timerID

    function private.DebugDraw()
        physics.start()
        system.activate("multitouch")

        background.x = screen.centerX
        background.y = screen.centerY

        labelInfo.x = screen.centerX
        labelInfo.y = screen.centerY-50
        labelInfo:setFillColor(255/255, 255/255, 255/255, 40/255)

        ground.x = 160
        ground.y = screen.bottom
        ground.anchorY = 1
        physics.addBody(ground, "static", {friction=0.5, bounce=0.3})

        buttonNormal = display.newImageRect("img/smallButton.png", 96, 36)
        buttonNormal.drawMode = "normal"
        buttonNormal.label = display.newText("Normal", 0, 0, native.systemFont, 16)
        buttonNormal.x = 55
        buttonNormal.y = 450
        buttonNormal.label.x = buttonNormal.x
        buttonNormal.label.y = buttonNormal.y

        buttonDebug = display.newImageRect("img/smallButton.png", 96, 36)
        buttonDebug.drawMode = "debug"
        buttonDebug.label = display.newText("Debug", 0, 0, native.systemFont, 16)
        buttonDebug.x = 160
        buttonDebug.y = 450
        buttonDebug.label.x = buttonDebug.x
        buttonDebug.label.y = buttonDebug.y

        buttonHybrid = display.newImageRect("img/smallButton.png", 96, 36)
        buttonHybrid.drawMode = "hybrid"
        buttonHybrid.label = display.newText("Hybrid", 0, 0, native.systemFont, 16)
        buttonHybrid.x = 265
        buttonHybrid.y = 450
        buttonHybrid.label.x = buttonHybrid.x
        buttonHybrid.label.y = buttonHybrid.y


        this:insert(background)
        this:insert(labelInfo)
        this:insert(ground)
        this:insert(buttonNormal)
        this:insert(buttonDebug)
        this:insert(buttonHybrid)
        this:insert(buttonNormal.label)
        this:insert(buttonDebug.label)
        this:insert(buttonHybrid.label)


        physics.addBody(buttonNormal, "static", {density=1.0})
        buttonNormal:addEventListener("touch", private.setPhysicsDrawMode)

        physics.addBody(buttonDebug, "static", {density=1.0})
        buttonDebug:addEventListener("touch", private.setPhysicsDrawMode)

        physics.addBody(buttonHybrid, "static", {density=1.0})
        buttonHybrid:addEventListener("touch", private.setPhysicsDrawMode)

        timerID = timer.performWithDelay(500, private.newCrate, 120)

    end

    function private.newCrate()
        rand = math.random(100)
        local crate

        if rand < 45 then
            crate = display.newImageRect("img/crate.png", 62, 45);
            crate.x = 60 + math.random(160)
            crate.y = -100
            physics.addBody(crate, {density=0.9, friction=0.3, bounce=0.3})
        elseif rand < 60 then
            crate = display.newImageRect("img/crateB.png", 70, 71);
            crate.x = 60 + math.random(160)
            crate.y = -100
            physics.addBody(crate, {density=1.4, friction=0.3, bounce=0.2})
        elseif rand < 80 then
            crate = display.newImageRect("img/rock.png", 46, 53);
            crate.x = 60 + math.random(160)
            crate.y = -100
            physics.addBody(crate, {density=3.0, friction=0.3, bounce=0.1, radius=33})
        else
            crate = display.newImageRect("img/crateC.png", 26, 38);
            crate.x = 60 + math.random(160)
            crate.y = -100
            physics.addBody(crate, {density=0.3, friction=0.2, bounce=0.5})
        end

        this:insert(crate)
        crate:addEventListener("touch", private.dragBody)
    end

    function private.setPhysicsDrawMode(event)
        if event.phase == "began" then
            physics.setDrawMode(event.target.drawMode)
        end

        return true
    end

    function private.dragBody(event, params)
        local body = event.target
        local phase = event.phase
        local stage = display.getCurrentStage()

        if phase == "began"then
            stage:setFocus( body, event.id )
            body.isFocus = true

            if params and params.center then
                body.tempJoint = physics.newJoint( "touch", body, body.x, body.y )
            else
                body.tempJoint = physics.newJoint( "touch", body, event.x, event.y )
            end

            if params then
                local maxForce, frequency, dampingRatio

                if params.maxForce then
                    body.tempJoint.maxForce = params.maxForce
                end

                if params.frequency then
                    body.tempJoint.frequency = params.frequency
                end

                if params.dampingRatio then
                    body.tempJoint.dampingRatio = params.dampingRatio
                end
            end

        elseif body.isFocus then
            if "moved" == phase then
                body.tempJoint:setTarget( event.x, event.y )
            elseif "ended" == phase or "cancelled" == phase then
                stage:setFocus( body, nil )
                body.isFocus = false

                body.tempJoint:removeSelf()
            end
        end

        return true
    end

    function public:destroy()
        buttonNormal:removeEventListener("touch", private.setPhysicsDrawMode)
        buttonDebug:removeEventListener("touch", private.setPhysicsDrawMode)
        buttonHybrid:removeEventListener("touch", private.setPhysicsDrawMode)
        timer.cancel(timerID)

        background:removeSelf()
        background = nil

        labelInfo:removeSelf()
        labelInfo = nil

        ground:removeSelf()
        ground = nil

        buttonNormal.label:removeSelf()
        buttonNormal.label = nil

        buttonDebug.label:removeSelf()
        buttonDebug.label = nil

        buttonHybrid.label:removeSelf()
        buttonHybrid.label = nil

        buttonNormal:removeSelf()
        buttonNormal = nil

        buttonDebug:removeSelf()
        buttonDebug = nil

        buttonHybrid:removeSelf()
        buttonHybrid = nil

        this:removeSelf()
        this = nil
    end

    private.DebugDraw()
    return this
end
return DebugDraw
