require "classes.constants.screen"

AudioPlayer={}

function AudioPlayer:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundAudio.png", 360, 570)
    local fieldStatus = display.newRect(screen.centerX, 20, screen.width, 44)
    local labelStatus = display.newText("Audio Player Sample", screen.centerX, 20, native.systemFontBold, 18)
    local labelVolume = display.newText("", screen.centerX, 190, native.systemFontBold, 18)
    local audioFiles = {"sound/note2", "sound/bouncing"}
    local audioLoaded = nil
    local audioHandle = nil
    local audioLoops = 0
    local audioVolume = 0.5
    local audioWasStopped = false
    local supportedAudio = {
        ["Mac"] = {extensions = {".aac", ".aif", ".caf", ".wav", ".mp3", ".ogg"}},
        ["IOS"] = {extensions = {".aac", ".aif", ".caf", ".wav", ".mp3"}},
        ["Win"] = {extensions = {".wav", ".mp3", ".ogg"}},
        ["Android"] = {extensions = {".wav", ".mp3", ".ogg"}},
    }
    local loadTypes = {
        ["sound"] = {extensions = {".aac", ".aif", ".caf", ".wav"}},
        ["stream"] = {extensions = {".mp3", ".ogg"}},
    }
    local audioPicker = widget.newPickerWheel({
        top = screen.height - 222,
        width = 300,
        font = native.systemFontBold,
        columns = {
            {
                align = "left",
                width = 190,
                startIndex = 1,
                labels = audioFiles,
            },
            {
                align = "right",
                width = 90,
                startIndex = 1,
                labels = (function ()
                    if system.getInfo("platformName") == "Android" then
                        return supportedAudio["Android"].extensions
                    elseif system.getInfo("platformName") == "Mac OS X" then
                        return supportedAudio["Mac"].extensions
                    elseif system.getInfo("platformName") == "Win" then
                        return supportedAudio["Win"].extensions
                    else
                        return supportedAudio["IOS"].extensions
                    end
                end)()
            },
        }
    })
    local sliderVolume = widget.newSlider({
        left = 50,
        top = 210,
        width = screen.width - 80,
        orientation = "horizontal",
        listener = function(event)
            if event.phase == "ended" then
                private.sliderListener(event)
            end
        end
    })
    local buttonPlay = widget.newButton({
        id = "buttonPlay",
        style = "sheetBlack",
        label = "Play",
        yOffset = - 3,
        fontSize = 24,
        emboss = true,
        width = 140,
        onEvent = function(event)
            private.manageButtonEvents(event)
        end
    })
    local buttonStop = widget.newButton({
        id = "buttonStop",
        style = "sheetBlack",
        label = "Stop",
        yOffset = - 3,
        fontSize = 24,
        emboss = true,
        width = 140,
        onEvent = function(event)
            private.manageButtonEvents(event)
        end
    })
    local buttonLoop = widget.newButton({
        id = "buttonLoop",
        style = "sheetBlack",
        label = "Loop: No",
        yOffset = -3,
        fontSize = 24,
        emboss = true,
        width = 140,
        onEvent = function(event)
            private.manageButtonEvents(event)
        end
    })

    function private.AudioPlayer()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(fieldStatus)
        this:insert(labelStatus)
        this:insert(labelVolume)
        this:insert(sliderVolume)
        this:insert(buttonPlay)
        this:insert(buttonStop)
        this:insert(buttonLoop)

        fieldStatus:setFillColor({type = 'gradient', color1 = {255/255, 255/255, 255/255}, color2 = {117/255, 139/255, 168/255}, direction = "down"})
        fieldStatus.alpha = 0.7

        buttonPlay.toggle = 0
        buttonPlay.x = buttonPlay.contentWidth * 0.5 + 10
        buttonPlay.y = 80

        buttonStop.x = screen.width - buttonStop.contentWidth * 0.5 - 10
        buttonStop.y = 80

        buttonLoop.toggle = 0
        buttonLoop.x = screen.centerX
        buttonLoop.y = buttonStop.y + buttonStop.contentHeight + buttonLoop.contentHeight * 0.5 - 10

        labelVolume.text = "Volume: " .. audioVolume .. "0"

        audio.setVolume(audioVolume, {channel = 1})


        this:insert(audioPicker)

    end

    function private.manageButtonEvents(event)
        if event.phase == "began" then
            if event.target.id == "buttonLoop" then
                buttonLoop.toggle = 1 - buttonLoop.toggle

                if buttonLoop.toggle == 1 then
                    audioLoops = -1

                    buttonLoop:setLabel("Loop: Yes")

                    labelStatus.text = "Audio will loop forever"

                    if audio.isChannelPlaying(1) then
                        audio.stop(1)
                    end
                else
                    audioLoops = 0

                    buttonLoop:setLabel("Loop: No")

                    labelStatus.text = "Audio will play once"

                    if audio.isChannelPlaying(1) then
                        audio.stop(1)
                    end
                end
            elseif event.target.id == "buttonPlay" then
                buttonPlay.toggle = 1 - buttonPlay.toggle

                if buttonPlay.toggle == 0 then
                    if audio.isChannelPlaying(1) then
                        audio.pause(1)
                    end

                    buttonPlay:setLabel("Resume")

                    labelStatus.text = "Audio paused on channel 1"
                else
                    if audio.isChannelPaused(1) then
                        audio.resume(1)

                        labelStatus.text = "Audio resumed on channel 1"
                    else
                        local audioFileSelected = audioPicker:getValues()[1].index
                        local audioExtensionSelected = audioPicker:getValues()[2].index

                        print("Loaded sound:", audioFiles[audioFileSelected] .. supportedAudio[private.getPlatformName()].extensions[audioExtensionSelected])

                        if supportedAudio[private.getPlatformName()].extensions[audioFileSelected] == loadTypes["sound"].extensions[audioExtensionSelected] then
                            audioLoaded = audio.loadSound(audioFiles[audioFileSelected] .. supportedAudio[private.getPlatformName()].extensions[audioExtensionSelected])
                            audioHandle = audio.play(audioLoaded, {channel = 1, loops = audioLoops, onComplete = private.resetButtonState})
                        else
                            audioLoaded = audio.loadStream(audioFiles[audioFileSelected] .. supportedAudio[private.getPlatformName()].extensions[audioExtensionSelected])
                            audioHandle = audio.play(audioLoaded, {channel = 1, loops = audioLoops, onComplete = private.resetButtonState})
                        end

                        labelStatus.text = "Audio playing on channel 1"
                    end

                    buttonPlay:setLabel("Pause")
                end
            elseif event.target.id == "buttonStop" then
                if audio.isChannelPlaying(1) then
                    audio.stop(1)

                    audioWasStopped = true

                    labelStatus.text = "Stopped Audio on channel 1"
                else
                    labelStatus.text = "No Audio playing to stop!"
                end
            end
        end

        return true
    end

    function private.sliderListener(event)
        audioVolume = event.value / 100
        audioVolume = string.format('%.02f', audioVolume )

        labelVolume.text = "Volume: " .. audioVolume

        audio.setVolume(audioVolume, {channel = 1})
    end

    function private.getPlatformName()
        local platformName
        if system.getInfo("platformName") == "Android" then
            platformName = "Android"
        elseif system.getInfo("platformName") == "Mac OS X" then
            platformName = "Mac"
        elseif system.getInfo("platformName") == "Win" then
            platformName = "Win"
        else
            platformName = "IOS"
        end

        return platformName
    end

    function private.resetButtonState()
        if buttonPlay then
            buttonPlay:setLabel("Play")
            buttonPlay.toggle = 0

            if audioWasStopped == false then
                labelStatus.text = "Playback finished on channel 1"
            end

            audioWasStopped = false
        end
    end

    function public:destroy()
        if audio.isChannelPlaying(1) then
            audio.stop(1)
        end
        audio.dispose(1)
        audioHandle=nil

        background:removeSelf()
        background = nil

        fieldStatus:removeSelf()
        fieldStatus = nil

        labelStatus:removeSelf()
        labelStatus = nil

        labelVolume:removeSelf()
        labelVolume = nil

        sliderVolume:removeSelf()
        sliderVolume = nil

        audioPicker:removeSelf()
        audioPicker = nil

        buttonPlay:removeSelf()
        buttonPlay = nil

        buttonStop:removeSelf()
        buttonStop = nil

        buttonLoop:removeSelf()
        buttonLoop = nil

        this:removeSelf()
        this = nil
    end

    private.AudioPlayer()
    return this
end
return AudioPlayer
