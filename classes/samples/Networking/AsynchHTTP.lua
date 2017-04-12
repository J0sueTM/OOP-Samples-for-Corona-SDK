require "classes.constants.screen"

AsynchHTTP={}

function AsynchHTTP:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local labelMessage = display.newText("(Waiting for response)", screen.centerX, 120, native.systemFont, 16)

    function private.AsynchHTTP()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(labelMessage)

        network.request("https://encrypted.google.com", "GET", private.networkListener)

    end

    function private.networkListener(event)
        if event.isError then
            labelMessage.text = "Network error!"
        else
            labelMessage.text = "See Corona Terminal for response"
            print("RESPONSE: " .. event.response)
        end
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelMessage:removeSelf()
        labelMessage = nil

        this:removeSelf()
        this = nil
    end

    private.AsynchHTTP()
    return this
end
return AsynchHTTP
