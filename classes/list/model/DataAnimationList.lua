require "classes.constants.screen"
require "classes.samples.Animation.Runner"
require "classes.samples.Animation.Transition1"
require "classes.samples.Animation.Transition2"

DataAnimationList={}

function DataAnimationList:new()
    local this = {
                      {img = "", title = "Runner", isList = false, execute=function() return Runner:new() end},
                      {img = "", title = "Transition1", isList = false, execute=function() return Transition1:new() end},
                      {img = "", title = "Transition2", isList = false, execute=function() return Transition2:new() end},
                 }
    local public = this
    local private = {}

    function private.DataAnimationList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataAnimationList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataAnimationList()
    return this
end
return DataAnimationList
