require "classes.constants.screen"

ScrollView={}

function ScrollView:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect("img/backgroundEasingExamples.png", 360, 570)
    local labelTitle = display.newText("Move Up to Scroll", screen.centerX, 48, native.systemFontBold, 16)
    local textParagraphs = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris. "
    local labelParagraphs = display.newText(textParagraphs, screen.centerX, 0, 300, 0, native.systemFont, 14)
    local scrollView = widget.newScrollView({
        left = 0,
        top = 0,
        width = screen.width,
        height = screen.height,
        bottomPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = function(event)
            private.onScrollView(event)
        end
    })

    function private.ScrollView()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle:setFillColor(0/255, 0/255, 0/255)

        labelParagraphs.y = labelTitle.y + labelTitle.contentHeight + 10
        labelParagraphs.anchorY = 0
        labelParagraphs:setFillColor(0/255, 0/255, 0/255)

        scrollView:insert(labelTitle)
        scrollView:insert(labelParagraphs)

        this:insert(background)
        this:insert(scrollView)

    end

    function private.onScrollView(event)
        if event.limitReached then
            if event.direction == "up" then
                print("Top limit")
            elseif event.direction == "down" then
                print("Bottom limit")
            elseif event.direction == "left" then
                print("Left limit")
            elseif event.direction == "right" then
                print("Right limit")
            end
        end

        return true
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelParagraphs:removeSelf()
        labelParagraphs = nil

        scrollView:removeSelf()
        scrollView = nil

        this:removeSelf()
        this = nil
    end

    private.ScrollView()
    return this
end
return ScrollView
