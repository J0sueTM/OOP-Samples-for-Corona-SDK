require "classes.constants.screen"
require "classes.samples.Storage.SQLite"

DataStorageList={}

function DataStorageList:new()
    local this = {
                      {img = "", title = "SQLite", isList = false, execute=function() return SQLite:new() end},
                 }
    local public = this
    local private = {}

    function private.DataStorageList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataStorageList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataStorageList()
    return this
end
return DataStorageList
