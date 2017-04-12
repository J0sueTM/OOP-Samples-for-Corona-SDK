require "classes.constants.screen"
require "classes.samples.Graphics.AnchorPoints"
require "classes.samples.Graphics.EasingExamples"
require "classes.samples.Graphics.Molecules"
require "classes.samples.Graphics.Flashlight"
require "classes.samples.Graphics.Polylynes"
require "classes.samples.Graphics.XRay"

DataGraphicsList={}

function DataGraphicsList:new()
    local this = {
                      {img = "", title = "AnchorPoints", isList = false, execute=function() return AnchorPoints:new() end},
                      {img = "", title = "EasingExamples", isList = false, execute=function() return EasingExamples:new() end},
                      {img = "", title = "Flashlight", isList = false, execute=function() return Flashlight:new() end},
                      {img = "", title = "Molecules", isList = false, execute=function() return Molecules:new() end},
                      {img = "", title = "Polylynes", isList = false, execute=function() return Polylynes:new() end},
                      {img = "", title = "XRay", isList = false, execute=function() return XRay:new() end},
                 }
    local public = this
    local private = {}

    function private.DataGraphicsList()
        this.isList = true
        this.hasBackButton = true
    end
    function public.goCurrent()
        return DataGraphicsList:new()
    end
    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataGraphicsList()
    return this
end
return DataGraphicsList
