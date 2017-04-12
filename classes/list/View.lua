require "classes.constants.screen"

View={}

function View:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local tableView = widget.newTableView({
        left = screen.left,
        top = screen.top+67,
        width = screen.right-display.screenOriginX,
        height = screen.bottom-display.screenOriginY-67-146,
        hideBackground=true,
        onRowRender = function(event)
            public.onRowRender(event)
        end,
        onRowTouch = function(event)
            public.onRowTouch(event)
        end,
    })
    local buttonBack = widget.newButton({
        width = 40,
        height = 36,
        defaultFile = "img/buttonBack.png",
        overFile = "img/buttonBack.png",
        onEvent = function(event)
            if event.phase == "ended" then
                --clickSoundHandler = audio.play(clickSound, {channel=2})
                public.onButtonBack(event)
            end
        end
    })


    function private.View()

        buttonBack.x = screen.left + 20
        buttonBack.y = screen.top + 30
        buttonBack.alpha = 0


        this:insert(tableView)
        this:insert(buttonBack)

    end

    function public.onRowRender(event)
    end

    function public.onRowTouch(event)
    end

    function public.getTableView()
        return tableView
    end

    function public.getButtonBack()
        return buttonBack
    end

    function public.onButtonBack(event)
    end

    function public:destroy()
        tableView:removeSelf()
        tableView = nil

        this:removeSelf()
        this = nil
    end

    private.View()
    return this
end
return View
