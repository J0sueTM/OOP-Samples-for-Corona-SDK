require "classes.constants.screen"

FacebookMessenger={}

function FacebookMessenger:new()
    local this = {}
    local public = this
    local private={}
    local facebook = require("plugin.facebook.v4")
    local json = require("json")
    local fbAppID = "XXXXXXXXXXXXXXX" -- Your FB App ID from facebook developer's panel
    local userFB_ID
    local nameFB
    local descriptionFB
    local fbCommand -- Facebook Commands
    local SHOW_FEED_DIALOG = 2
    local POST_MSG = 4
    local GET_PHOTO = 8
    local GET_FRIENDS = 9
    local POST_SCORE = 10
    local GET_USERSSCORE = 11
    local postMessage = ""
    local postScore = 6
    local controller
    local users
    local currentAccessToken
    local alreadyLogin = false

    function private.FacebookMessenger()


    end

    function public.setResponseObjects(newController, newUsers)
        controller = newController
        users = newUsers
    end

    function public.login()
        private.enforceFacebookLogin()
    end

    function public.logout()
        facebook.logout()
    end

    function public.postMessage(newPostMessage)
        postMessage = newPostMessage
        private.postMsg_onRelease()
    end

    function public.inviteFriends()
        private.showFeedDialog_onRelease()
    end

    function public.postScore(newPostScore)
        postScore = newPostScore
        private.postScore()
    end

    function public.getUsersScore()
        private.getUsersScore()
    end

    function private.listener(event) -- New Facebook Connection listener
        if event.type == "session" then

            if event.phase ~= "login" then
                return -- Exit if login error
            else
                currentAccessToken = event.token
                alreadyLogin = true
            end
        elseif event.type == "request" then
            local response = event.response -- event.response is a JSON object from the FB server

            if not event.isError then
                response = json.decode( event.response )

                if fbCommand == POST_MSG then

                elseif fbCommand == GET_PHOTO then
                    users[1].userName = ""..response.first_name.." "..response.last_name
                    users[1].points = hudModel.getScoreValue()
                    controller.showList(users)

                    local function fbNetworkImageDownload( event )
                        users[1].imgUser = "fbPic.png" --event.response.filename
                        controller.showList(users)
                    end
                    network.download(response.picture.data.url,
                                     "GET",
                                     fbNetworkImageDownload,
                                     {},
                                     "fbPic.png",
                                     system.DocumentDirectory
                                    )
                elseif fbCommand == GET_FRIENDS then
                    for i=1, #response.data do
                        if users[i] then
                            users[i].userName = ""..response.data[i].name
                            users[i].points = hudModel.getScoreValue()
                        else
                            users[i]= {imgUser = "img/userdefault.png", userName = response.data[i].name, points = 23}
                        end

                        local function fbNetworkImageDownload( event )
                            users[i].imgUser = "fbPic"..response.data[i].id..".png" --event.response.filename
                            controller.showList(users)
                        end
                        network.download(response.data[i].picture.data.url,
                                         "GET",
                                         fbNetworkImageDownload,
                                         {},
                                         "fbPic"..response.data[i].id..".png",
                                         system.DocumentDirectory
                                        )
                    end

                    controller.showList(users)
                elseif fbCommand == GET_USERSSCORE then

                    for i=1, #response.data do
                        if users[i] then
                            users[i].userName = ""..response.data[i].user.name
                            users[i].points = response.data[i].score
                        else
                            users[i]= {imgUser = "img/userdefault.png", userName = response.data[i].user.name, points = response.data[i].score}
                        end

                        local function fbNetworkImageDownload( event )
                            users[i].imgUser = "fbPic"..response.data[i].user.id..".png" --event.response.filename
                            controller.showList(users)
                        end
                        network.download(
                                            "https://graph.facebook.com/"..response.data[i].user.id.."/picture",
                                            "GET",
                                            fbNetworkImageDownload,
                                            {},
                                            "fbPic"..response.data[i].user.id..".png",
                                            system.DocumentDirectory
                                        )
                    end
                    controller.showList(users)

                elseif fbCommand == POST_SCORE then
                    --print("Post Score")
                else
                    -- Unknown command response
                end

            else
                -- Post Failed
            end

        elseif ( "dialog" == event.type ) then
            -- showDialog response
            --print( "dialog response:", event.response )
        end
    end

    function private.processFBCommand(event) -- Runs the desired facebook command
        if fbCommand == SHOW_FEED_DIALOG then -- The following displays a Facebook dialog box for posting to your Facebook Wall -- "feed" is the standard "post status message" dialog
            facebook.showDialog("requests", {message = "You should download this game!", filter = "APP_NON_USERS"})
        end

        if fbCommand == POST_MSG then -- This code posts a message to your Facebook Wall
            local faceMessage = {
                        name = "OOP Samples for Corona SDK",
                        link = "https://play.google.com/store/apps/details?id=com.gmail.lis.a.sebastian.oopsamplesforcoronasdk",
                        message = postMessage --"Got ".. hudModel.getScoreValue().." points how about you?",
                        --picture =pictureFB
                }
            local response = facebook.request( "me/feed", "POST", faceMessage )
        end

        if fbCommand == GET_PHOTO then -- This code gets a photo image from your Facebook Wall
            facebook.request("me","GET",{fields="name,first_name, last_name, id, picture"})
        end

        if fbCommand == GET_USERSSCORE then -- This code gets a friends invited by you
            local response = facebook.request("/"..fbAppID.."/scores","GET");
        end

        if fbCommand == POST_SCORE then
            local params = {
                score=tostring(postScore),  --hudModel.getScoreValue()
                access_token=currentAccessToken--accessToken--event.token
            }
            facebook.request("me/scores" , "POST", params)
        end

        if fbCommand == GET_FRIENDS then -- This code gets a friends invited by you
            local response = facebook.request("/me/taggable_friends", "GET")
        end

    end

    function private.enforceFacebookLogin()
        if facebook.isActive then
            local accessToken = facebook.getCurrentAccessToken()
            if accessToken == nil then
                facebook.login( private.listener ) --print( "Need to log in" )
            elseif not private.inTable( accessToken.grantedPermissions, "publish_actions" ) then
                facebook.login( private.listener, {"publish_actions"} ) --print( "Logged in, but need permissions" )
            else
                --print( "Already logged in with needed permissions" )

                private.processFBCommand()
            end
        else
            --print( "Please wait for facebook to finish initializing before checking the current access token" );
        end
    end

    function private.inTable( table, item ) -- Check for an item inside the provided table -- Based on implementation at: https://www.omnimaga.org/other-computer-languages-help/(lua)-check-if-array-contains-given-value/
        for k,v in pairs(table) do
            if v == item then
                return true
            end
        end
        return false
    end

    function private.postMsg_onRelease(event)
        fbCommand = POST_MSG
        private.enforceFacebookLogin()
    end

    function private.showFeedDialog_onRelease(event)
        fbCommand = SHOW_FEED_DIALOG
        private.enforceFacebookLogin()
    end

    function private.getPhoto(event)
        fbCommand = GET_PHOTO
        private.enforceFacebookLogin()
    end

    function private.getFriends(event)
        fbCommand = GET_FRIENDS
        private.enforceFacebookLogin()
    end

    function private.getUsersScore(event)
        fbCommand = GET_USERSSCORE
        private.enforceFacebookLogin()
    end

    function private.postScore(event)
        fbCommand = POST_SCORE
        private.enforceFacebookLogin()
    end

    function public.alreadyLogin()
        return alreadyLogin
    end


    private.FacebookMessenger()
    return this
end
return FacebookMessenger
