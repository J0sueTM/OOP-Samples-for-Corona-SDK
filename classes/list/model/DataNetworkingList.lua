require "classes.constants.screen"
require "classes.samples.Networking.AsynchHTTP"
require "classes.samples.Networking.AsynchImageDownload"
require "classes.samples.Networking.SimpleImageDownload"

DataNetworkingList={}

function DataNetworkingList:new()
    local this = {
                      {img = "", title = "AsynchHTTP", isList = false, execute=function() return AsynchHTTP:new() end},
                      {img = "", title = "AsynchImageDownload", isList = false, execute=function() return AsynchImageDownload:new() end},
                      {img = "", title = "SimpleImageDownload", isList = false, execute=function() return SimpleImageDownload:new() end},
                 }
    local public = this
    local private = {}

    function private.DataNetworkingList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataNetworkingList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataNetworkingList()
    return this
end
return DataNetworkingList
