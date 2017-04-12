require "classes.constants.screen"
require "classes.samples.Interface.ActivityIndicator"
require "classes.samples.Interface.Alert"
require "classes.samples.Interface.ButtonEvents"
require "classes.samples.Interface.DragMe"
require "classes.samples.Interface.DragMeMultitouch"
require "classes.samples.Interface.MapView"
require "classes.samples.Interface.MultitouchButton"
require "classes.samples.Interface.MultitouchFingers"
require "classes.samples.Interface.NativeOrientation"
require "classes.samples.Interface.Orientation"
require "classes.samples.Interface.PinchZoomGesture"
require "classes.samples.Interface.ScrollView"
require "classes.samples.Interface.StatusBar"
require "classes.samples.Interface.TableView"

DataInterfaceList={}

function DataInterfaceList:new()
    local this = {
                      {img = "", title = "ActivityIndicator", isList = false, execute=function() return ActivityIndicator:new() end},
                      {img = "", title = "Alert", isList = false, execute=function() return Alert:new() end},
                      {img = "", title = "ButtonEvents", isList = false, execute=function() return ButtonEvents:new() end},
                      {img = "", title = "DragMe", isList = false, execute=function() return DragMe:new() end},
                      {img = "", title = "DragMeMultitouch", isList = false, execute=function() return DragMeMultitouch:new() end},
                      {img = "", title = "MapView", isList = false, execute=function() return MapView:new() end},
                      {img = "", title = "MultitouchButton", isList = false, execute=function() return MultitouchButton:new() end},
                      {img = "", title = "MultitouchFingers", isList = false, execute=function() return MultitouchFingers:new() end},
                      {img = "", title = "NativeOrientation", isList = false, execute=function() return NativeOrientation:new() end},
                      {img = "", title = "Orientation", isList = false, execute=function() return Orientation:new() end},
                      {img = "", title = "PinchZoomGesture", isList = false, execute=function() return PinchZoomGesture:new() end},
                      {img = "", title = "ScrollView", isList = false, execute=function() return ScrollView:new() end},
                      {img = "", title = "StatusBar", isList = false, execute=function() return StatusBar:new() end},
                      {img = "", title = "TableView", isList = false, execute=function() return TableView:new() end},
                 }
    local public = this
    local private = {}

    function private.DataInterfaceList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataInterfaceList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataInterfaceList()
    return this
end
return DataInterfaceList
