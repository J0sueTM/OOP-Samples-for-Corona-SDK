require "classes.constants.screen"

MapView={}

function MapView:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local locationNumber = 1
    local currentLocation
    local currentLatitude
    local currentLongitude
    local fieldInfo = display.newRect(7, 7, 306, 226)
    local textMessage = "Maps not supported in Corona Simulator.\n\nYou must build for iOS or Android to test MapView support."
    local labelInfo = display.newText(textMessage, 20, 70, fieldInfo.contentWidth - 10, 0, native.systemFont, 14)
    local map = native.newMapView(20, 20, 300, 220)
    local inputField = native.newTextField(10, 247, 300, 38)
    local buttonFindLocation = widget.newButton({
        width = 298,
        height = 56,
        defaultFile = "img/buttonBlue1Default.png",
        overFile = "img/buttonBlue1Pressed.png",
        label = "Find Location",
        labelColor = {default={255/255, 255/255, 255/255}, over={255/255, 255/255, 255/255, 0.5}},
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonFindLocation(event)
            end
        end
    })

    local buttonCurrentLocation = widget.newButton({
        width = 298,
        height = 56,
        defaultFile = "img/buttonBlue2Default.png",
        overFile = "img/buttonBlue2Pressed.png",
        label = "Current Location",
        labelColor = {default={ 255/255, 255/255, 255/255}, over={255/255, 255/255, 255/255, 0.5}},
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonCurrentLocation(event)
            end
        end
    })

    local buttonRemoveAllMarkers = widget.newButton({
        width = 200,
        height = 56,
        defaultFile = "img/buttonBlue3Default.png",
        overFile = "img/buttonBlue3Pressed.png",
        label = "Remove All Markers",
        labelColor = {default={255/255, 255/255, 255/255}, over={255/255, 255/255, 255/255, 0.5}},
        emboss = true,
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonRemoveAllMarkers(event)
            end
        end
    })

    function private.MapView()

        background.x = screen.centerX
        background.y = screen.centerY

        fieldInfo.anchorX = 0
        fieldInfo.anchorY = 0
        fieldInfo:setFillColor(0/255, 0/255, 0/255, 120/255)

        labelInfo.anchorX = 0
        labelInfo.anchorY = 0

        inputField.anchorX=0
        inputField.anchorY=0
        inputField.font = native.newFont(native.systemFont, 16)
        inputField.text = "Broadway and Columbus, San Francisco"
        inputField:setTextColor(45/255, 45/255, 45/255)

        buttonFindLocation.x = screen.centerX
        buttonFindLocation.y = 320
        buttonCurrentLocation.x = screen.centerX
        buttonCurrentLocation.y = 380
        buttonRemoveAllMarkers.x = screen.centerX
        buttonRemoveAllMarkers.y = 440

        this:insert(background)
        this:insert(fieldInfo)
        this:insert(labelInfo)
        this:insert(inputField)
        this:insert(buttonFindLocation)
        this:insert(buttonCurrentLocation)
        this:insert(buttonRemoveAllMarkers)

        if map then
            map.mapType = "normal"
            map.x = screen.centerX
            map.y = 120
            map:setCenter(37.331692, -122.030456)
        end

        inputField:addEventListener("userInput", private.onUserInput)

    end

    function private.onUserInput(event)
        if event.phase == "submitted" then
            native.setKeyboardFocus(nil)
        end
    end

    function private.mapAddressHandler(event)
        if event.isError then
            native.showAlert("Error", event.errorMessage, {"OK"})
        else
            native.showAlert("You Are Here",
                             "Latitude: " .. currentLatitude ..
                             ", Longitude: " .. currentLongitude ..
                             ", Address: " .. (event.streetDetail or "") ..
                             " " .. (event.street or "") ..
                             ", " .. (event.city or "") ..
                             ", " .. (event.region or "") ..
                             ", " .. (event.country or "") ..
                             ", " .. (event.postalCode or ""),
                             locationText, {"OK"})
        end
    end

    function private.mapLocationHandler(event)
        if event.isError then
            native.showAlert("Error", event.errorMessage, {"OK"})
        else
            map:setCenter(event.latitude, event.longitude, true)
            markerTitle = "Location " .. locationNumber
            locationNumber = locationNumber + 1
            map:addMarker(event.latitude, event.longitude, {title=markerTitle, subtitle=inputField.text})
        end
    end

    function private.onButtonFindLocation(event)
        if map then
            map:requestLocation(inputField.text, private.mapLocationHandler)
        end
    end

    function private.onButtonCurrentLocation(event)
        if map == nil then
            return
        end

        currentLocation = map:getUserLocation()

        if currentLocation.errorCode then
            currentLatitude = 0
            currentLongitude = 0
            native.showAlert("Error", currentLocation.errorMessage, {"OK"})
        else
            currentLatitude = currentLocation.latitude
            currentLongitude = currentLocation.longitude
            map:setRegion(currentLatitude, currentLongitude, 0.01, 0.01, true)
            map:nearestAddress(currentLatitude, currentLongitude, private.mapAddressHandler)
        end
    end

    function private.onButtonRemoveAllMarkers(event)
        if map then
            map:removeAllMarkers()
            locationNumber = 1
        end
    end

    function public:destroy()
        inputField:removeEventListener("userInput", private.onUserInput)

        if map then
            map:removeSelf()
            map = nil
        end

        background:removeSelf()
        background = nil

        fieldInfo:removeSelf()
        fieldInfo = nil

        labelInfo:removeSelf()
        labelInfo = nil

        inputField:removeSelf()
        inputField = nil

        buttonFindLocation:removeSelf()
        buttonFindLocation = nil

        buttonCurrentLocation:removeSelf()
        buttonCurrentLocation = nil

        buttonRemoveAllMarkers:removeSelf()
        buttonRemoveAllMarkers = nil

        this:removeSelf()
        this = nil
    end

    private.MapView()
    return this
end
return MapView
