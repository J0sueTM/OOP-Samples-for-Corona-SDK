require "classes.constants.screen"
require "classes.samples.Media.AudioPlayer"

DataMediaList={}

function DataMediaList:new()
    local this = {
                      {img = "", title = "AudioPlayer", isList = false, execute=function() return AudioPlayer:new() end},
                 }
    local public = this
    local private = {}

    function private.DataMediaList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataMediaList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataMediaList()
    return this
end
return DataMediaList
