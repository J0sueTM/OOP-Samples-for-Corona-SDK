require "classes.constants.screen"
require "classes.list.model.DataAnimationList"
require "classes.list.model.DataGettingStartedList"
require "classes.list.model.DataGraphicsList"
require "classes.list.model.DataHardwareList"
require "classes.list.model.DataInterfaceList"
require "classes.list.model.DataMediaList"
require "classes.list.model.DataMonetizationList"
require "classes.list.model.DataNetworkingList"
require "classes.list.model.DataPhysicsList"
require "classes.list.model.DataStorageList"
require "classes.list.model.DataSystemList"

DataAllTopicList={}

function DataAllTopicList:new()
    local this = {
                      {img = "", title = "GETTING STARTED", isList = true, execute=function() return DataGettingStartedList:new() end},
                      {img = "", title = "ANIMATION", isList = true, execute=function() return DataAnimationList:new() end},
                      {img = "", title = "GRAPHICS", isList = true, execute=function() return DataGraphicsList:new() end},
                      {img = "", title = "HARDWARE", isList = true, execute=function() return DataHardwareList:new() end},
                      {img = "", title = "INTERFACE", isList = true, execute=function() return DataInterfaceList:new() end},
                      {img = "", title = "MEDIA", isList = true, execute=function() return DataMediaList:new() end},
                      {img = "", title = "MONETIZATION", isList = true, execute=function() return DataMonetizationList:new() end},
                      {img = "", title = "NETWORKING", isList = true, execute=function() return DataNetworkingList:new() end},
                      {img = "", title = "PHYSICS", isList = true, execute=function() return DataPhysicsList:new() end},
                      {img = "", title = "STORAGE", isList = true, execute=function() return DataStorageList:new() end},
                      {img = "", title = "SYSTEM", isList = true, execute=function() return DataSystemList:new() end},
                 }
    local public = this
    local private = {}

    function private.DataAllTopicList()
        this.isList = true
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataAllTopicList()
    return this
end
return DataAllTopicList
