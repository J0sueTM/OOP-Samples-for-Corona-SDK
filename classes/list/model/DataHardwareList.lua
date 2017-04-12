require "classes.constants.screen"
require "classes.samples.Hardware.Accelerometer"
require "classes.samples.Hardware.DeviceInfo"
require "classes.samples.Hardware.KeyEvents"

DataHardwareList={}

function DataHardwareList:new()
    local this = {
                      {img = "", title = "Accelerometer", isList = false, execute=function() return Accelerometer:new() end},
                      {img = "", title = "DeviceInfo", isList = false, execute=function() return DeviceInfo:new() end},
                      {img = "", title = "KeyEvents", isList = false, execute=function() return KeyEvents:new() end},
                 }
    local public = this
    local private = {}

    function private.DataHardwareList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataHardwareList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataHardwareList()
    return this
end
return DataHardwareList
