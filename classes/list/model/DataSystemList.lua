require "classes.constants.screen"
require "classes.samples.System.LocalNotifications"

DataSystemList={}

function DataSystemList:new()
    local this = {
                      {img = "", title = "LocalNotifications", isList = false, execute=function() return LocalNotifications:new() end},
                 }
    local public = this
    local private = {}

    function private.DataSystemList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataSystemList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataSystemList()
    return this
end
return DataSystemList
