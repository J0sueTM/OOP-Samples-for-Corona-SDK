require "classes.constants.screen"

HelloWorldLocalized={}

function HelloWorldLocalized:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundHelloWorldLocalized.png", 360, 570)
    local labelTitle = display.newText("", 0, 0, native.systemFontBold, 24)
    local translations = {
                             ["pl"] = "Witaj świecie!",
                             ["en"] = "Hello, world!",
                             ["hu"] = "Helló Világ!",
                             ["cs"] = "Ahoj světe!",
                             ["sk"] = "Ahoj světe!",
                             ["es"] = "¡Hola mundo!",
                             ["it"] = "Salve, mondo!",
                             ["ja"] = "世界よ、こんにちは！",
                             ["ru"] = "Привет, Мир!",
                             ["pt"] = "Olá mundo!",
                             ["zh-Hant"] = "世界你好！",
                             ["zh-Hans"] = "世界你好！",
                         }
    local language = system.getPreference("locale", "language")
    local message = translations[language]
    local titleGroup = display.newGroup()
    local radius = 10
    local fieldTitle = display.newRoundedRect(0, 0, 0, 0, radius)

    function private.HelloWorldLocalized()

        background.x = screen.centerX
        background.y = screen.centerY

        if not message then
            message = "qo' vIvan" --Klingon 'Hello, world'
        end

        labelTitle.text = message
        labelTitle:setFillColor(255/255, 255/255, 255/255)

        fieldTitle.width=labelTitle.contentWidth + 2*radius
        fieldTitle.height=labelTitle.contentHeight + 2*radius
        fieldTitle:setFillColor(155/255, 155/255, 155/255, 190/255)

        titleGroup.x = screen.centerX
        titleGroup.y = screen.top+fieldTitle.height

        titleGroup:insert(fieldTitle)
        titleGroup:insert(labelTitle)
        this:insert(background)
        this:insert(titleGroup)

    end

    function public:destroy()
        background:removeSelf()
        background = nil

        fieldTitle:removeSelf()
        fieldTitle = nil

        labelTitle:removeSelf()
        labelTitle = nil

        titleGroup:removeSelf()
        titleGroup = nil

        this:removeSelf()
        this = nil
    end

    private.HelloWorldLocalized()
    return this
end
return HelloWorldLocalized
