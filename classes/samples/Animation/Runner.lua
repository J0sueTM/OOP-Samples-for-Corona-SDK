require "classes.constants.screen"

Runner={}

function Runner:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundRunner.png", 360, 570)
    local moon = display.newImageRect("img/moon.png", 65, 65)
    local mountainImage = { type="image", filename="img/mountain.png" }
    local mountain1
    local mountain2
    local labelRunningImage = { type="image", filename="img/labelRunning.png" }
    local labelRunning1
    local labelRunning2
    local fogImage = { type="image", filename="img/Fog2.png" }
    local fog1
    local fog2
    local boatSmall = display.newImageRect("img/boatSmall.png", 81, 64)
    local boatLarge = display.newImageRect("img/boatLarge.png", 101, 94)
    local sheetData = { frames = {
        {x = 5, y = 5, width = 428, height = 328, sourceX = 0, sourceY = 4, sourceWidth = 428, sourceHeight = 328,},
        {x = 5, y = 343, width = 428, height = 328, sourceX = 5, sourceY = 1, sourceWidth = 428, sourceHeight = 328,},
        {x = 443, y = 5, width = 428, height = 328, sourceX = 12, sourceY = 2, sourceWidth = 428, sourceHeight = 328,},
        {x = 443, y = 343, width = 428, height = 328, sourceX = 11, sourceY = 0, sourceWidth = 428, sourceHeight = 328,},
        {x = 5, y = 681, width = 428, height = 328, sourceX = 12, sourceY = 2, sourceWidth = 428, sourceHeight = 328,},
    }}
    local runnerSheet = graphics.newImageSheet("img/runnerHero.png", {frames=sheetData.frames})
    local runnerHero = display.newSprite(runnerSheet, {name="runnerHero", start=1, count=5, time=1000})
    local crateBig = display.newImageRect("img/crateBig.png", 174, 57)
    local crateSmall = display.newImageRect("img/crateSmall.png", 111, 84)
    local scrollMoonSpeed = 0.3
    local scrollMountainSpeed = 0.65
    local scrollLabelRunningSpeed = 1
    local scrollFogSpeed = 4
    local scrollBoatSmallSpeed = 2
    local scrollBoatLargeSpeed = 2.53
    local scrollCrateBigSpeed = 5
    local scrollCrateSmallSpeed = 5
    local runtime = 0

    function private.Runner()
        print(display.actualContentHeight)
        print(display.contentWidth - display.actualContentWidth)

        background.x = screen.centerX
        background.y = screen.centerY

        moon.x = screen.centerX + 96
        moon.y = screen.centerY

        -- Add First mountain image
        mountain1 = display.newRect(0, 0, 93, display.actualContentHeight )
        mountain1.fill = mountainImage
        mountain1.x = display.contentCenterX+54
        mountain1.y = display.contentCenterY

        -- Add Second mountain image
        mountain2 = display.newRect(0, 0, 93, display.actualContentHeight )
        mountain2.fill = mountainImage
        mountain2.x = display.contentCenterX + 54
        mountain2.y = display.contentCenterY+ display.actualContentHeight


        ---- Add First labelRunning image
        labelRunning1 = display.newRect(0, 0, 131, display.actualContentHeight)
        labelRunning1.fill = labelRunningImage
        labelRunning1.x = display.contentCenterX+74
        labelRunning1.y = display.contentCenterY

        ---- Add Second labelRunning image
        labelRunning2 = display.newRect(0, 0, 131, display.actualContentHeight)
        labelRunning2.fill = labelRunningImage
        labelRunning2.x = display.contentCenterX + 74
        labelRunning2.y = display.contentCenterY + display.actualContentHeight

        ---- Add First fog image
        fog1 = display.newRect(0, 0, 133, display.actualContentHeight)
        fog1.fill = fogImage
        fog1.x = display.contentCenterX - 120
        fog1.y = display.contentCenterY
        --fog1.alpha = 0

        ---- Add Second fog image
        fog2 = display.newRect(0, 0, 133, display.actualContentHeight)
        fog2.fill = fogImage
        fog2.x = display.contentCenterX - 120
        fog2.y = display.contentCenterY + display.actualContentHeight
        --fog2.alpha = 0

        boatSmall.x = screen.centerX-35
        boatSmall.y = 129-30
        boatSmall.anchorX = 0
        boatSmall.anchorY = 0

        boatLarge.x = screen.centerX-50
        boatLarge.y = screen.centerY+45
        boatLarge.anchorX = 0
        boatLarge.anchorY = 0

        runnerHero.anchorX = 1
        runnerHero.anchorY = 0
        runnerHero.x = screen.left+150-22
        runnerHero.y = screen.centerY-115
        runnerHero.xScale = 0.25
        runnerHero.yScale = 0.25
        runnerHero.rotation = 90

        crateBig.x = screen.left--23
        crateBig.y = 23
        crateBig.anchorX = 0
        crateBig.anchorY = 1

        crateSmall.x = screen.left
        crateSmall.y = 151+100
        crateSmall.anchorX = 0
        crateSmall.anchorY = 1


        this:insert(background)
        this:insert(labelRunning1)
        this:insert(labelRunning2)
        this:insert(moon)
        this:insert(mountain1)
        this:insert(mountain2)
        this:insert(boatSmall)
        this:insert(boatLarge)
        this:insert(fog1)
        this:insert(fog2)
        this:insert(runnerHero)
        this:insert(crateBig)
        this:insert(crateSmall)

        runnerHero:play()

        Runtime:addEventListener("enterFrame", private.moveItems)
    end

    function private.moveItems()
        local dt = private.getDeltaTime()

        mountain1.y = mountain1.y - scrollMountainSpeed * dt
        mountain2.y = mountain2.y - scrollMountainSpeed * dt

        if (mountain1.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            mountain1:translate(0, mountain1.contentHeight * 2 )
        end
        if (mountain2.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            mountain2:translate(0, mountain2.contentHeight * 2)
        end

        fog1.y = fog1.y - scrollFogSpeed * dt
        fog2.y = fog2.y - scrollFogSpeed * dt

        if (fog1.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            fog1:translate(0, fog1.contentHeight * 2 )
        end
        if (fog2.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            fog2:translate(0, fog2.contentHeight * 2)
        end

        labelRunning1.y = labelRunning1.y - scrollLabelRunningSpeed * dt
        labelRunning2.y = labelRunning2.y - scrollLabelRunningSpeed * dt

        if (labelRunning1.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            labelRunning1:translate(0, labelRunning1.contentHeight * 2 )
        end
        if (labelRunning2.y + display.contentHeight/2) < display.contentHeight - display.actualContentHeight then
            labelRunning2:translate(0, labelRunning2.contentHeight * 2)
        end

        moon.y = moon.y - scrollMoonSpeed * dt
        if moon.y < screen.top - moon.height / 2 then
            moon:translate (0, screen.height*2)
        end

        crateBig.y = crateBig.y - scrollCrateBigSpeed * dt
        if crateBig.y < screen.top - crateBig.height / 2 then
            crateBig:translate(0, screen.height*4)
        end

        crateSmall.y = crateSmall.y - scrollCrateSmallSpeed * dt
        if crateSmall.y < screen.top - crateSmall.height / 2 then
            crateSmall:translate(0, screen.height*5)
        end

        boatSmall.y = boatSmall.y - scrollBoatSmallSpeed * dt
        if boatSmall.y < screen.top - boatSmall.height then
            boatSmall:translate(0, screen.height*5)
        end

        boatLarge.y = boatLarge.y - scrollBoatLargeSpeed * dt
        if boatLarge.y < screen.top - boatLarge.height then
            boatLarge:translate(0, screen.height*5)
        end
    end

    function private.getDeltaTime()
        local temp = system.getTimer()
        local dt = (temp-runtime) / (1000/60)
        runtime = temp
        return dt
    end

    function public:destroy()
        Runtime:removeEventListener("enterFrame",private.moveItems)

        background:removeSelf()
        background = nil

        mountain1:removeSelf()
        mountain1 = nil

        mountain2:removeSelf()
        mountain2 = nil

        moon:removeSelf()
        moon = nil

        labelRunning1:removeSelf()
        labelRunning1 = nil

        labelRunning2:removeSelf()
        labelRunning2 = nil

        boatSmall:removeSelf()
        boatSmall = nil

        boatLarge:removeSelf()
        boatLarge = nil

        --fog1:removeSelf()
        --fog1 = nil

        --fog2:removeSelf()
        --fog2 = nil

        runnerHero:removeSelf()
        runnerHero = nil

        crateBig:removeSelf()
        crateBig = nil

        crateSmall:removeSelf()
        crateSmall = nil

        this:removeSelf()
        this = nil
    end


    private.Runner()
    return this
end
return Runner
