require "classes.constants.screen"

DeviceInfo={}

function DeviceInfo:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local store = require("store")
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local labelDeviceInfo = display.newText("Device Info",screen.centerX, 15, native.systemFont, 24)
    local labelName = display.newText("name:", screen.centerX-20, 60, native.systemFont, 16)
    local labelModel = display.newText("model:", screen.centerX-20, 90, native.systemFont, 16)
    local labelEnvironment = display.newText("environment:", screen.centerX-20, 120, native.systemFont, 16)
    local labelPlatformName = display.newText("platformName:", screen.centerX-20, 150, native.systemFont, 16)
    local labelPlatformVersion = display.newText("platformVersion:", screen.centerX-20, 180, native.systemFont, 16)
    local labelCoronaVersion = display.newText("version (Corona):", screen.centerX-20, 210, native.systemFont, 16)
    local labelCoronaBuild = display.newText("build (Corona):", screen.centerX-20, 240, native.systemFont, 16)
    local labelDeviceId = display.newText("deviceID:", screen.centerX-20, 270, native.systemFont, 16)
    local labelLanguage = display.newText("language:", screen.centerX-20, 330, native.systemFont, 16)
    local labelCountry = display.newText("country:", screen.centerX-20, 360, native.systemFont, 16)
    local labelLocale = display.newText("locale:", screen.centerX-20, 390, native.systemFont, 16)
    local labelLanguageCode = display.newText("language code:", screen.centerX-20, 420, native.systemFont, 16)
    local labelTargetStrore = display.newText("target store:", screen.centerX-20, 450, native.systemFont, 16)
    local labelValueName = display.newText(system.getInfo("name"), screen.centerX, 60, native.systemFont, 16)
    local labelValueModel = display.newText(system.getInfo("model"), screen.centerX, 90, native.systemFont, 16)
    local labelValueEnvironment = display.newText(system.getInfo("environment"), screen.centerX, 120, native.systemFont, 16)
    local labelValuePlatformName = display.newText(system.getInfo("platformName"), screen.centerX, 150, native.systemFont, 16)
    local labelValuePlatformVersion = display.newText(system.getInfo("platformVersion"), screen.centerX, 180, native.systemFont, 16)
    local labelValueCoronaVersion = display.newText(system.getInfo("version"), screen.centerX, 210, native.systemFont, 16)
    local labelValueCoronaBuild = display.newText(system.getInfo("build"), screen.centerX, 240, native.systemFont, 16)
    local labelValueDeviceId = display.newText(system.getInfo("deviceID"), screen.centerX, 295, native.systemFont, 14)
    local labelValueLanguage = display.newText(system.getPreference("ui", "language"), screen.centerX, 330, native.systemFont, 16)
    local labelValueCountry = display.newText(system.getPreference("locale", "country"), screen.centerX, 360, native.systemFont, 16)
    local labelValueLocale = display.newText(system.getPreference("locale", "identifier"), screen.centerX, 390, native.systemFont, 16)
    local labelValueLanguageCode = display.newText(system.getPreference("locale", "language"), screen.centerX, 420, native.systemFont, 16)
    local labelValueTargetStore = display.newText(store.target, screen.centerX, 450, native.systemFont, 16) --The following will generate a warning message if using a "starter" account. "restricted library (store)"

    function private.DeviceInfo()

        background.x = screen.centerX
        background.y = screen.centerY

        labelDeviceInfo.anchorX = 0.5
        labelDeviceInfo.anchorY = 0.5
        labelDeviceInfo:setFillColor(255/255, 255/255, 255/255)

        labelName.anchorX = 1
        labelName.anchorY = 0
        labelName:setFillColor(255/255, 180/255, 90/255)

        labelModel.anchorX = 1
        labelModel.anchorY = 0
        labelModel:setFillColor(255/255, 180/255, 90/255)

        labelEnvironment.anchorX = 1
        labelEnvironment.anchorY = 0
        labelEnvironment:setFillColor(255/255, 180/255, 90/255)

        labelPlatformName.anchorX = 1
        labelPlatformName.anchorY = 0
        labelPlatformName:setFillColor(255/255, 180/255, 90/255)

        labelPlatformVersion.anchorX = 1
        labelPlatformVersion.anchorY = 0
        labelPlatformVersion:setFillColor(255/255, 180/255, 90/255)

        labelCoronaVersion.anchorX = 1
        labelCoronaVersion.anchorY = 0
        labelCoronaVersion:setFillColor(255/255, 180/255, 90/255)

        labelCoronaBuild.anchorX = 1
        labelCoronaBuild.anchorY = 0
        labelCoronaBuild:setFillColor(255/255, 180/255, 90/255)

        labelDeviceId.anchorX = 1
        labelDeviceId.anchorY = 0
        labelDeviceId:setFillColor(255/255, 180/255, 90/255)

        labelLanguage.anchorX = 1
        labelLanguage.anchorY = 0
        labelLanguage:setFillColor(255/255, 180/255, 90/255)

        labelCountry.anchorX = 1
        labelCountry.anchorY = 0
        labelCountry:setFillColor(255/255, 180/255, 90/255)

        labelLocale.anchorX = 1
        labelLocale.anchorY = 0
        labelLocale:setFillColor(255/255, 180/255, 90/255)

        labelLanguageCode.anchorX = 1
        labelLanguageCode.anchorY = 0
        labelLanguageCode:setFillColor(255/255, 180/255, 90/255)

        labelTargetStrore.anchorX = 1
        labelTargetStrore.anchorY = 0
        labelTargetStrore:setFillColor(255/255, 180/255, 90/255)

        labelValueName.anchorX = 0
        labelValueName.anchorY = 0
        labelValueName:setFillColor(255/255, 255/255, 255/255)

        labelValueModel.anchorX = 0
        labelValueModel.anchorY = 0
        labelValueModel:setFillColor(255/255, 255/255, 255/255)

        labelValueEnvironment.anchorX = 0
        labelValueEnvironment.anchorY = 0
        labelValueEnvironment:setFillColor(255/255, 255/255, 255/255)

        labelValuePlatformName.anchorX = 0
        labelValuePlatformName.anchorY = 0
        labelValuePlatformName:setFillColor(255/255, 255/255, 255/255)

        labelValuePlatformVersion.anchorX = 0
        labelValuePlatformVersion.anchorY = 0
        labelValuePlatformVersion:setFillColor(255/255, 255/255, 255/255)

        labelValueCoronaVersion.anchorX = 0
        labelValueCoronaVersion.anchorY = 0
        labelValueCoronaVersion:setFillColor(255/255, 255/255, 255/255)

        labelValueCoronaBuild.anchorX = 0
        labelValueCoronaBuild.anchorY = 0
        labelValueCoronaBuild:setFillColor(255/255, 255/255, 255/255)

        labelValueDeviceId.anchorX = 0.5
        labelValueDeviceId.anchorY = 0
        labelValueDeviceId:setFillColor(255/255, 255/255, 255/255)

        labelValueLanguage.anchorX = 0
        labelValueLanguage.anchorY = 0
        labelValueLanguage:setFillColor(255/255, 255/255, 255/255)

        labelValueCountry.anchorX = 0
        labelValueCountry.anchorY = 0
        labelValueCountry:setFillColor(255/255, 255/255, 255/255)

        labelValueLocale.anchorX = 0
        labelValueLocale.anchorY = 0
        labelValueLocale:setFillColor(255/255, 255/255, 255/255)

        labelValueLanguageCode.anchorX = 0
        labelValueLanguageCode.anchorY = 0
        labelValueLanguageCode:setFillColor(255/255, 255/255, 255/255)

        labelValueTargetStore.anchorX = 0
        labelValueTargetStore.anchorY = 0
        labelValueTargetStore:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelDeviceInfo)
        this:insert(labelName)
        this:insert(labelModel)
        this:insert(labelEnvironment)
        this:insert(labelPlatformName)
        this:insert(labelPlatformVersion)
        this:insert(labelCoronaVersion)
        this:insert(labelCoronaBuild)
        this:insert(labelDeviceId)
        this:insert(labelLanguage)
        this:insert(labelCountry)
        this:insert(labelLocale)
        this:insert(labelLanguageCode)
        this:insert(labelTargetStrore)
        this:insert(labelValueName)
        this:insert(labelValueModel)
        this:insert(labelValueEnvironment)
        this:insert(labelValuePlatformName)
        this:insert(labelValuePlatformVersion)
        this:insert(labelValueCoronaVersion)
        this:insert(labelValueCoronaBuild)
        this:insert(labelValueDeviceId)
        this:insert(labelValueLanguage)
        this:insert(labelValueCountry)
        this:insert(labelValueLocale)
        this:insert(labelValueLanguageCode)
        this:insert(labelValueTargetStore)

    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelDeviceInfo:removeSelf()
        labelDeviceInfo = nil

        labelName:removeSelf()
        labelName = nil

        labelModel:removeSelf()
        labelModel = nil

        labelEnvironment:removeSelf()
        labelEnvironment = nil

        labelPlatformName:removeSelf()
        labelPlatformName = nil

        labelPlatformVersion:removeSelf()
        labelPlatformVersion = nil

        labelCoronaVersion:removeSelf()
        labelCoronaVersion = nil

        labelCoronaBuild:removeSelf()
        labelCoronaBuild = nil

        labelDeviceId:removeSelf()
        labelDeviceId = nil

        labelLanguage:removeSelf()
        labelLanguage = nil

        labelCountry:removeSelf()
        labelCountry = nil

        labelLocale:removeSelf()
        labelLocale = nil

        labelLanguageCode:removeSelf()
        labelLanguageCode = nil

        labelTargetStrore:removeSelf()
        labelTargetStrore = nil

        labelValueName:removeSelf()
        labelValueName = nil

        labelValueModel:removeSelf()
        labelValueModel = nil

        labelValueEnvironment:removeSelf()
        labelValueEnvironment = nil

        labelValuePlatformName:removeSelf()
        labelValuePlatformName = nil

        labelValuePlatformVersion:removeSelf()
        labelValuePlatformVersion = nil

        labelValueCoronaVersion:removeSelf()
        labelValueCoronaVersion = nil

        labelValueCoronaBuild:removeSelf()
        labelValueCoronaBuild = nil

        labelValueDeviceId:removeSelf()
        labelValueDeviceId = nil

        labelValueLanguage:removeSelf()
        labelValueLanguage = nil

        labelValueCountry:removeSelf()
        labelValueCountry = nil

        labelValueLocale:removeSelf()
        labelValueLocale = nil

        labelValueLanguageCode:removeSelf()
        labelValuelanguagecode = nil

        labelValueTargetStore:removeSelf()
        labelValueTargetStore = nil

        this:removeSelf()
        this = nil
    end

    private.DeviceInfo()
    return this
end
return DeviceInfo
