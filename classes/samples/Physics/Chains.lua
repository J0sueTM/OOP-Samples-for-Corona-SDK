require "classes.constants.screen"

Chains={}

function Chains:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local physics = require("physics")
    local background = display.newImageRect("img/backgroundChains.png", 360, 570)
    local ground = display.newImageRect("img/groundChains.png", 360, 101)
    local beam1 = display.newImageRect("img/beam.png", 28, 150)
    local beam2 = display.newImageRect("img/beam.png", 28, 150)
    local beam3 = display.newImageRect("img/beam_long.png", 291, 28)


    local myJoints = {}
    local timerID

    function private.Chains()
        physics.start()
        physics.setScale(60)

        background.x = screen.centerX
        background.y = screen.centerY

        ground.x = screen.centerX
        ground.y = screen.bottom-25
        ground.anchorX = 0.5
        ground.anchorY = 0.5

        physics.addBody(ground, "static", {friction=0.5})

        beam1.x = 20
        beam1.y = 350
        beam1.rotation = -40
        physics.addBody(beam1, "static", {friction=0.5})

        beam2.x = 410
        beam2.y = 340
        beam2.rotation = 20
        physics.addBody(beam2, "static", {friction=0.5})

        beam3.x = 280
        beam3.y = 50
        physics.addBody(beam3, "static", {friction=0.5})

        this:insert(background)
        this:insert(ground)
        this:insert(beam1)
        this:insert(beam2)
        this:insert(beam3)

        for i = 1,5 do
            local link = {}
            for j = 1,17 do
                link[j] = display.newImageRect("img/link.png", 14, 24)
                link[j].x = 121 + (i*34)
                link[j].y = 55 + (j*17)
                physics.addBody(link[j], {density=2.0, friction=0, bounce=0})
                this:insert(link[j])

                if j > 1 then
                    prevLink = link[j-1]
                else
                    prevLink = beam3
                end

                myJoints[#myJoints + 1] = physics.newJoint("pivot", prevLink, link[j], 121 + (i*34), 46 + (j*17))
            end
        end


        timerID = timer.performWithDelay(1500, private.randomBall, 12)

    end

    function private.randomBall()
        local ball = display.newImageRect("img/super_ball.png", 48, 48)

        ball.x = 10 + math.random(60)
        ball.y = -20
        physics.addBody(ball, {density=2.9, friction=0.5, bounce=0.7, radius=24})
        this:insert(ball)
    end

    function public:destroy()
        timer.cancel(timerID)
        timerID = nil

        background:removeSelf()
        background = nil

        ground:removeSelf()
        ground = nil

        beam1:removeSelf()
        beam1 = nil

        beam2:removeSelf()
        beam2 = nil

        beam3:removeSelf()
        beam3 = nil

        this:removeSelf()
        this = nil
    end

    private.Chains()
    return this
end
return Chains
