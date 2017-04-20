require "classes.constants.screen"
require "classes.list.View"
require "classes.list.Model"
require "classes.list.Controller"
require "classes.info.SupportUs"
require "classes.info.Info"
require "classes.lib.FacebookMessenger"

MainClass={}

function MainClass:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundMenu.png", 360, 570)
    local title = display.newImageRect("img/header.png", 360, 67)
    local infoBottom = display.newImageRect("img/infoBottom.png", 360, 146)
    local iconRocketLeft = display.newImageRect("img/iconRocket.png", 27, 28)
    local iconRocketRight = display.newImageRect("img/iconRocket.png", 27, 28)
    local iconHeart = display.newImageRect("img/iconHeart.png", 45, 35)
    local iconInfo = display.newImageRect("img/iconInfo.png", 43, 43)
    local listView = View:new()
    local listModel = Model:new()
    local listController = Controller:new(listView, listModel)
    local facebookMessenger = FacebookMessenger:new()
    local buttonGithub = widget.newButton({
        width = 93,
        height = 36,
        defaultFile = "img/buttonGithub.png",
        overFile = "img/buttonGithub.png",
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonGithub(event)
            end
        end
    })
    local buttonSupport = widget.newButton({
        width = 171,
        height = 36,
        defaultFile = "img/buttonSupport.png",
        overFile = "img/buttonSupport.png",
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonSupportUs(event)
            end
        end
    })
    local buttonInfo = widget.newButton({
        width = 130,
        height = 36,
        defaultFile = "img/buttonInfo.png",
        overFile = "img/buttonInfo.png",
        onEvent = function(event)
            if event.phase == "ended" then
                private.onButtonInfo(event)
            end
        end
    })


    function private.MainClass()

        background.x = screen.centerX
        background.y = screen.centerY

        title.x = screen.centerX
        title.y = screen.top+title.height/2

        iconRocketRight.x = screen.right - 20
        iconRocketRight.y = screen.top + 30

        iconRocketLeft.x = screen.left + 20
        iconRocketLeft.y = screen.top + 30

        infoBottom.x = screen.centerX
        infoBottom.y = screen.bottom
        infoBottom.anchorY = 1

        buttonGithub.anchorX = 1
        buttonGithub.anchorY = 1
        buttonGithub.x = screen.right
        buttonGithub.y = screen.bottom-infoBottom.height+36

        buttonSupport.x = screen.left+5
        buttonSupport.y = screen.bottom-30
        buttonSupport.anchorX = 0

        buttonInfo.x = screen.right-5
        buttonInfo.y = screen.bottom-30
        buttonInfo.anchorX = 1

        iconHeart.x = buttonSupport.x + buttonSupport.width/2
        iconHeart.y = screen.bottom-80

        iconInfo.x = buttonInfo.x - buttonInfo.width/2
        iconInfo.y = screen.bottom-80


        this:insert(background)
        this:insert(title)
        this:insert(iconRocketRight)
        this:insert(iconRocketLeft)
        this:insert(listView)
        this:insert(infoBottom)
        this:insert(iconHeart)
        this:insert(iconInfo)
        this:insert(buttonGithub)
        this:insert(buttonSupport)
        this:insert(buttonInfo)

        listController.setCurrentScreen(this)

    end

    function private.onButtonGithub(event)
        system.openURL( "https://github.com/sebastianlis/OOP-Samples-for-Corona-SDK" )
    end

    function private.onButtonSupportUs(event)
        local supportUs = SupportUs:new()
        
        supportUs:addEventListener("touch", function() return true end)
        supportUs:addEventListener("tap", function() return true end)

        supportUs:addEventListener("EXITSUPPORTUS", function()
            this:remove(supportUs)
            supportUs=nil
        end)

        this:insert(supportUs)
        return true
    end

    function private.onButtonInfo(event)
        local info = Info:new(facebookMessenger)
        
        info:addEventListener("touch", function() return true end)
        info:addEventListener("tap", function() return true end)

        info:addEventListener("EXITINFO", function()
            this:remove(info)
            info=nil
        end)

        this:insert(info)
        return true
    end


    private.MainClass()
    return this
end
return MainClass
