require "classes.constants.screen"

Info={}

function Info:new(facebookMessenger)
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundInfo.png", 360, 570)
    local labelTitle = display.newText("", 0, 0, "CommodorePixelized", 40)
    local textParagraphs = "Welcome to Object Oriented Programming Samples for Corona SDK*.\n\nWhen I started making this app my idea was of course practicing OOP Lua myself (using earlier experience with the other oop languages) but also preparing some helpful stuff for the others, to let them introduce OOP to their Corona programming easily. I assumed that the best way to do this, would be using samples very similar to the original Corona's ones.\n\nAll the code is OOP rewritten, a bit changed and with some gfx upgrade - just to make work with it more likable - but still possible to compare with the original ones. Due to this method  you can analyze both codes (original and mine) to get an idea how it works.\n\nI hope you will find it helpful in your everyday work or fun with programming. My samples are kind of ‘practical guide’ with all the source to get from GitHub, a bit later I will add some short explanations on my blog, but if you need more theoretical knowledge at the moment I recommend you to check:"
    local labelParagraphs = display.newText(textParagraphs, screen.centerX, 0, 300, 0, native.systemFont, 12)
    local textParagraphsBottom = "Feel free to contact with me: \nSebastian Lis\nsebastian.a.lis@gmail.com"
    local labelParagraphsBottom = display.newText(textParagraphsBottom, screen.centerX, 0, 300, 0, native.systemFont, 14)
    local linkWebPage = display.newText({text="jessewarden.com", x = screen.centerX+40, y = 440, font = native.systemFont, fontSize = 12})
    local underlineLinkWebPage
    local textRights = "* All names and brand marks are property of Corona Labs Inc.\n\nSounds by (Flashkit - freeware):\n\nSamuel Pardee\nJohnny Brewton\nRepaidGateman"
    local labelRights = display.newText(textRights, screen.centerX, 0, 300, 0, native.systemFont, 14)
    local scrollView = widget.newScrollView({
        left = 0,
        top = screen.top+57,
        width = screen.width,
        height = screen.bottom-display.screenOriginY-(screen.top+57),
        bottomPadding = 50,
        hideBackground = true,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
    })
    local buttonBack = widget.newButton({
        width = 40,
        height = 36,
        defaultFile = "img/buttonBack.png",
        overFile = "img/buttonBack.png",
        onEvent = function(event)
            if event.phase == "ended" then
                --clickSoundHandler = audio.play(clickSound, {channel=2})
                private.onButtonBack(event)
            end
        end
    })
    local buttonFacebookShare = widget.newButton({
        width = 158,
        height = 40,
        defaultFile = "img/buttonFacebookShare.png",
        overFile = "img/buttonFacebookShare.png",
        onEvent = function(event)
            if event.phase == "ended" then
                --clickSoundHandler = audio.play(clickSound, {channel=2})
                private.onFacebookShare(event)
            end
        end
    })

    function private.Info()
        print(screen.top)
        background.x = screen.centerX
        background.y = screen.centerY

        buttonBack.x=screen.left + 20
        buttonBack.y=screen.top + 30

        labelTitle.x = screen.centerX
        labelTitle.y = screen.top+5
        labelTitle.anchorX = 0.5
        labelTitle.anchorY = 0
        labelTitle:setFillColor(255/255, 255/255, 255/255)
        labelTitle.text = "INFO"

        labelParagraphs.anchorY = 0
        labelParagraphs:setFillColor(255/255, 255/255, 255/255)
        labelParagraphs.alpha = 1


        linkWebPage.x = screen.centerX
        linkWebPage.y = labelParagraphs.y + labelParagraphs.contentHeight + linkWebPage.contentHeight/2-1

        underlineLinkWebPage = display.newLine(linkWebPage.x - linkWebPage.width/2,
                                               linkWebPage.y + linkWebPage.height/2,
                                               linkWebPage.x + linkWebPage.width/2,
                                               linkWebPage.y + linkWebPage.height/2)

        labelParagraphsBottom.y = linkWebPage.y + linkWebPage.height+10
        labelParagraphsBottom.anchorY = 0
        labelParagraphsBottom:setFillColor(255/255, 255/255, 255/255)
        labelParagraphsBottom.alpha = 1

        buttonFacebookShare.x = screen.centerX
        buttonFacebookShare.y = labelParagraphsBottom.y + labelParagraphsBottom.height + 50--screen.top + buttonFacebookShare.height/2

        labelRights.x = screen.centerX
        labelRights.y = buttonFacebookShare.y + buttonFacebookShare.height + 72

        scrollView:insert(labelParagraphs)
        scrollView:insert(linkWebPage)
        scrollView:insert(underlineLinkWebPage)
        scrollView:insert(labelParagraphsBottom)
        scrollView:insert(buttonFacebookShare)
        scrollView:insert(labelRights)

        this:insert(background)
        this:insert(labelTitle)
        this:insert(scrollView)
        this:insert(buttonBack)


        this:addEventListener("touch", function() return true end)
        this:addEventListener("tap", function() return true end)

        linkWebPage:addEventListener("tap", private.onLinkTap)
        Runtime:addEventListener("key", private.onBackHardwareKey)
    end

    function private.onLinkTap(event)
        system.openURL("http://jessewarden.com/2011/10/lua-classes-and-packages-in-corona.html")
        return true
    end

    function private.onButtonBack(event)
        this:dispatchEvent({name="EXITINFO", target=this})
        this:destroy()
        return true
    end

    function private.onFacebookShare(event)
        if not facebookMessenger.alreadyLogin() then
            facebookMessenger.logout()
            transition.to(this, {delay=0, time = 1000, onComplete = function()
                facebookMessenger.login()
                private.showDialogBox()
            end})
        else
            private.showDialogBox()
        end

        return true
    end

    function private.showDialogBox()
        native.showAlert("OOP Samples for Corona SDK", "I'm learning Lua programming with OOP Samples for Corona SDK app.  You can also try it here!:", {"OK", "Cancel"}, function(event)
            if event.action == "clicked" then
                if event.index == 1 then
                    facebookMessenger.postMessage("I'm learning Lua programming with OOP Samples for Corona SDK app.  You can also try it here!: https://play.google.com/store/apps/details?id=com.gmail.lis.a.sebastian.oopsamplesforcoronasdk")
                elseif event.index == 2 then
                    -- "Cancel" - do nothing
                end
            end
        end)
    end

    function private.onBackHardwareKey(event)
        if event.phase == "up" and event.keyName == "back" then
            private.onButtonBack(event)
            return true
        end
    end

    function public:destroy()
        Runtime:removeEventListener("key", private.onBackHardwareKey)

        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelParagraphs:removeSelf()
        labelParagraphs = nil

        linkWebPage:removeSelf()
        linkWebPage = nil

        underlineLinkWebPage:removeSelf()
        underlineLinkWebPage = nil

        labelParagraphsBottom:removeSelf()
        labelParagraphsBottom = nil

        scrollView:removeSelf()
        scrollView = nil

        buttonBack:removeSelf()
        buttonBack = nil

        buttonFacebookShare:removeSelf()
        buttonFacebookShare = nil

        this:removeSelf()
        this = nil
    end

    private.Info()
    return this
end
return Info
