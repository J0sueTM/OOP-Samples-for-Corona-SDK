require "classes.constants.screen"

TableView={}

function TableView:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local background = display.newImageRect( "img/backgroundEasingExamples.png", 360, 570)
    local tableView = widget.newTableView({
        onRowRender = function (event)
            private.onRowRender(event)
        end
    })

    function private.TableView()

        background.x = screen.centerX
        background.y = screen.centerY

        this:insert(background)
        this:insert(tableView)

        for i = 1, 40 do
            tableView:insertRow{}
        end

    end

    function private.onRowRender(event)
        local row = event.row
        local rowTitle = display.newText(row, "Row " .. row.index, 0, 0, nil, 14)
        rowTitle.x = 0
        rowTitle.y = row.contentHeight*0.5
        rowTitle.anchorX = 0
        rowTitle:setFillColor(0/255, 0/255, 0/255)
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        tableView:removeSelf()
        tableView = nil

        this:removeSelf()
        this = nil
    end

    private.TableView()
    return this
end
return TableView
