require "classes.constants.screen"

Molecules={}

function Molecules:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local seed = os.time()
    local soundID = audio.loadSound("sound/bubble_strong_wav.wav")
    local bounceAnimation = {
        container = display.newRect(screen.centerX, screen.centerY, display.viewableContentWidth, display.viewableContentHeight),
        reflectX = true,
    }
    local background = display.newImageRect("img/backgroundMoleculesPortrait.jpg", 360, 570)
    local numberOfMolecules = 10
    local molecules = {}

    function private.Molecules()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        math.randomseed(seed)

        for i=1, numberOfMolecules do
            molecules[#molecules+1] = display.newGroup()

            molecules[#molecules]:insert(display.newImageRect("img/molecule3D.png", 56, 66), true)
            molecules[#molecules]:insert(display.newImageRect("img/molecule2D.png", 56, 66), true)
            molecules[#molecules].x = molecules[#molecules].x + screen.centerX + math.random(-100, 100)
            molecules[#molecules].y = molecules[#molecules].y + screen.centerY + math.random(-100, 100)
            molecules[#molecules].xSpeed = math.random(1, 5)
            molecules[#molecules].ySpeed = math.random(-2, 2)

            molecules[#molecules][2].isVisible = false

            bounceAnimation[#bounceAnimation + 1] = molecules[#molecules]

            molecules[#molecules]:addEventListener("touch", private.onMoleculeTouch)
        end

        for i = 1, #molecules do
            this:insert(molecules[i])
        end

        Runtime:addEventListener("enterFrame", bounceAnimation)

    end

    function private.onMoleculeTouch(event)
        if event.phase == "ended" then
            local molecule = event.target

            if molecule[1].isVisible then
                local topColor = molecule[1]
                local bottomColor = molecule[2]

                transition.dissolve(topColor, bottomColor, 500)
                transition.dissolve(bottomColor, topColor, 500, math.random(3000, 10000))
            end

        end

        return true
    end

    function bounceAnimation:enterFrame(event)
        local container = self.container
        container:setFillColor(0/255, 0/255, 0/255, 0)
        local containerBounds = container.contentBounds
        local xMin = containerBounds.xMin
        local xMax = containerBounds.xMax
        local yMin = containerBounds.yMin
        local yMax = containerBounds.yMax
        local orientation = self.currentOrientation
        local isLandscape = "landscapeLeft" == orientation or "landscapeRight" == orientation
        local reflectX = nil ~= self.reflectX
        local reflectY = nil ~= self.reflectY

        for i,v in ipairs(self) do
            local molecule = v
            local xSpeed = molecule.xSpeed
            local ySpeed = molecule.ySpeed

            if isLandscape then
                if orientation == "landscapeLeft" then
                    local xSpeedOld = xSpeed
                    xSpeed = -ySpeed
                    ySpeed = -xSpeedOld
                elseif orientation == "landscapeRight" then
                    local xSpeedOld = xSpeed
                    xSpeed = ySpeed
                    ySpeed = xSpeedOld
                end
            elseif orientation == "portraitUpsideDown" then
                xSpeed = -xSpeed
                ySpeed = -ySpeed
            end

            local dx = xSpeed
            local dy = ySpeed
            local bounds = molecule.contentBounds
            local flipX = false
            local flipY = false

            if bounds.xMax + dx > xMax then
                flipX = true
                dx = xMax - bounds.xMax
            elseif bounds.xMin + dx < xMin then
                flipX = true
                dx = xMin - bounds.xMin
            end

            if bounds.yMax + dy > yMax then
                flipY = true
                dy = yMax - bounds.yMax
            elseif bounds.yMin + dy < yMin then
                flipY = true
                dy = yMin - bounds.yMin
            end

            if isLandscape then
                flipX,flipY = flipY,flipX
            end

            if flipX then
                molecule.xSpeed = -molecule.xSpeed
                if reflectX then
                    molecule:scale(-1, 1)
                end
            end
            if flipY then
                molecule.ySpeed = -molecule.ySpeed
                if reflectY then
                    molecule:scale(1, -1)
                end
            end

            molecule:translate(dx, dy)
        end

        return true
    end

    function public:destroy()
        Runtime:removeEventListener("enterFrame", bounceAnimation)

        background:removeSelf()
        background = nil

        for i = 1, #molecules do
            molecules[i]:removeEventListener("touch", private.onMoleculeTouch)
            this:remove(molecules[i])
            molecules[i] = nil
        end

        this:removeSelf()
        this = nil
    end


    private.Molecules()
    return this
end
return Molecules
