require "classes.constants.screen"

AsynchImageDownload={}

function AsynchImageDownload:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local image1
    local image2

    function private.AsynchImageDownload()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)

        --Method 1
        network.download(
            "http://xxxxxxxx.xxx.xx/img/icon.jpg",
            "GET",
            private.networkListener1,
            "helloCopy.jpg",
            system.TemporaryDirectory
        )

        --Method 2
        image2 = display.loadRemoteImage(
            "http://xxxxxxxx.xxx.xx/img/icon.jpg",
            "GET",
            private.networkListener2,
            "helloCopy2.jpg",
            system.TemporaryDirectory,
            screen.centerX,
            screen.centerY+120
        )

    end

    function private.networkListener1(event)
        if event.isError then
            print("Network error - download failed")
        else
            image1 = display.newImageRect(event.response.filename, event.response.baseDirectory, 200, 200)
            image1.x = screen.centerX
            image1.y = screen.centerY-120
            image1.alpha = 0
            this:insert(image1)
            transition.to(image1, { alpha = 1.0 })
            print ("RESPONSE: ", event.response.filename)
        end
    end

    function private.networkListener2(event)
        if event.isError then
            print("Network error - download failed")
        else
            event.target.alpha = 0
            event.target.width = 200
            event.target.height = 200
            transition.to(event.target, {alpha = 1.0})
            this:insert(event.target)
        end

        print ("RESPONSE: ", event.response.filename)
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        if image1 then
            image1:removeSelf()
            image1 = nil
        end

        if image2 then
            image2:removeSelf()
            image2 = nil
        end

        this:removeSelf()
        this = nil
    end

    private.AsynchImageDownload()
    return this
end
return AsynchImageDownload
