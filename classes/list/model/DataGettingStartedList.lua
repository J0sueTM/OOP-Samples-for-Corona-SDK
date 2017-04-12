require "classes.constants.screen"
require "classes.samples.GettingStarted.Clock"
require "classes.samples.GettingStarted.FrameAnimation1"
require "classes.samples.GettingStarted.FrameAnimation2"
require "classes.samples.GettingStarted.HelloWorld"
require "classes.samples.GettingStarted.HelloWorldLocalized"
require "classes.samples.GettingStarted.TimeAnimation"
require "classes.samples.GettingStarted.Timer"

DataGettingStartedList={}

function DataGettingStartedList:new()
    local this = {
                      {img = "", title = "Clock", isList = false, execute=function() return Clock:new() end},
                      {img = "", title = "FrameAnimation1", isList = false, execute=function() return FrameAnimation1:new() end},
                      {img = "", title = "FrameAnimation2", isList = false, execute=function() return FrameAnimation2:new() end},
                      {img = "", title = "HelloWorld", isList = false, execute=function() return HelloWorld:new() end},
                      {img = "", title = "HelloWorldLocalized", isList = false, execute=function() return HelloWorldLocalized:new() end},
                      {img = "", title = "TimeAnimation", isList = false, execute=function() return TimeAnimation:new() end},
                      {img = "", title = "Timer", isList = false, execute=function() return Timer:new() end},
                 }
    local public = this
    local private = {}

    function private.DataGettingStartedList()
        this.isList = true
        this.hasBackButton = true
    end

    function public.goCurrent()
        return DataGettingStartedList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataGettingStartedList()
    return this
end
return DataGettingStartedList
