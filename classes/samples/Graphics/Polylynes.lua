require "classes.constants.screen"

Polylynes={}

function Polylynes:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundPolylynes.png", 360, 570)
    local stars = {}

    function private.Polylynes()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        for i = 1, 20 do
            stars[#stars+1] = private.newStar()

            stars[#stars]:setStrokeColor(math.random(255)/255, math.random(255)/255, math.random(255)/255, math.random(200)/255 + 55/255)
            stars[#stars].strokeWidth = math.random(10)
            stars[#stars].x = math.random(screen.width)
            stars[#stars].y = math.random(screen.height)
            stars[#stars].rotation = math.random(360)
            stars[#stars].xScale = math.random(150)/100 + 0.5
            stars[#stars].yScale = stars[#stars].xScale
            stars[#stars].dr = math.random(1, 4)

            if math.random() < 0.5 then
                stars[#stars].dr = -stars[#stars].dr
            end
        end

        for i = 1, #stars do
            this:insert(stars[i])
        end

        Runtime:addEventListener("enterFrame", stars)

    end

    function stars:enterFrame(event)
        for i,v in ipairs(self) do
            v.rotation = v.rotation + v.dr
        end

        return true
    end

    function private.newStar()
        local star = display.newLine(0,-110, 27,-35)
        star:append(105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, 0,-110)
        star:setStrokeColor( 255/255, 255/255, 255/255, 255/255 )
        star.strokeWidth = 3

        return star
    end

    function public:destroy()
        Runtime:removeEventListener("enterFrame", stars)

        background:removeSelf()
        background = nil

        for i = 1, #stars do
            this:remove(stars[i])
        end
        stars = nil

        this:removeSelf()
        this = nil
    end

    private.Polylynes()
    return this
end
return Polylynes
