require "classes.constants.screen"
require "classes.list.model.DataAllTopicList"

Controller={}

function Controller:new(view, model)
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local currentTopic
    local currentScreen


    function private.Controller()
        view.onRowRender = public.onRowRender
        view.onRowTouch = public.onRowTouch
        view.onButtonBack = public.onButtonBack

        private.showTopic()

        Runtime:addEventListener("key", private.onBackHardwareKey)
    end

    function public.onRowRender(event)
        local row = event.row
        local rowTitle = display.newText(row, " " .. model.getData()[row.index].title, 0, 0, "CommodorePixelized", 15)
        rowTitle.x = row.contentWidth*0.5
        rowTitle.y = row.contentHeight*0.5
        rowTitle.anchorX = 0.78
        rowTitle:setFillColor(255/255, 255/255, 255/255)

        if currentTopic.hasBackButton then
            view.getButtonBack().alpha = 1
        else
            view.getButtonBack().alpha = 0
        end

        return true
    end

    function public.onRowTouch(event)
        local row = event.target

        if event.phase == "press" then
        elseif event.phase == "swipeLeft" then
            print("Swiped left.")
        elseif event.phase == "swipeRight" then
            print( "Swiped right." )
        elseif event.phase == "tap" then
            print("tap")
            if currentTopic.isList then
                timer.performWithDelay(50, function() private.showTopic(currentTopic[event.target.index]) end) --trick for avoid event propagation
                return true
            end
        elseif event.phase == "release" then
            print("release")
            --print(event.target.index)
            if currentTopic.isList then
                timer.performWithDelay(50, function() private.showTopic(currentTopic[event.target.index]) end) --trick for avoid event propagation
                return true
            end
        end
        return true
    end

    function public.onButtonBack(event)
        currentTopic = currentTopic.goBack()
        view.getTableView():deleteAllRows()
        model.setData(currentTopic)

        for i = 1, #model.getData() do
            local rowColor = {28/255, 142/255, 255/255, 0.2}

            if i%2 == 0 then rowColor = {128/255, 255/255, 255/255, 0} end

            view.getTableView():insertRow({
                isCategory = false,
                rowHeight = 49,
                rowColor = {
                    default = rowColor,
                    over = {28/255, 142/255, 255/255, 0.5},
                },
                lineColor = {220/255, 220/255, 220/255,0},
            })
        end
    end

    function private.showTopic(clickedTarget)
        if clickedTarget ~= nil then
            local goBack =currentTopic.goCurrent
            currentTopic = clickedTarget.execute()
            view.getTableView():deleteAllRows()
            if currentTopic.isList then
                model.setData(currentTopic)
                goBack=nil
            else
                currentTopic:addEventListener("touch", function() return true end)
                currentTopic:addEventListener("tap", function() return true end)
                currentScreen:insert(currentTopic)
                view.getTableView():deleteAllRows()
                view.getTableView().alpha=0
                model.setData(currentTopic)
                currentTopic.hasBackButton = true
                currentTopic.goBack = function()
                    view.getTableView().alpha=1
                    currentScreen:remove(currentTopic)
                    currentTopic:destroy()
                    currentTopic = nil
                    return goBack()--> currentTopic.goCurrent()-->DataGettingStarted().goCurrent()-->DataGettingStartedList:new()
                end
                view:toFront()
            end
        else
            currentTopic = DataAllTopicList:new()
            view.getButtonBack().alpha = 0
            if currentTopic.isList then
                view.getTableView():deleteAllRows()
                model.setData(currentTopic)
            end
        end

        for i = 1, #model.getData() do
            local rowColor = {28/255, 142/255, 255/255, 0.2}

            if i%2 == 0 then rowColor = {128/255, 255/255, 255/255, 0} end

            view.getTableView():insertRow({
                isCategory = false,
                rowHeight = 49,
                rowColor = {
                    default = rowColor,
                    over = {28/255, 142/255, 255/255, 0.5},
                },
                lineColor = {220/255, 220/255, 220/255,0},
            })
        end
        return true
    end

    function public.setCurrentScreen(newScreen)
        currentScreen = newScreen
    end

    function private.onBackHardwareKey(event)
        if event.phase == "up" and event.keyName == "back" then
            if currentTopic.hasBackButton then
                public.onButtonBack(event)
                return true
            end
        end
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.Controller()
    return this
end
return Controller
