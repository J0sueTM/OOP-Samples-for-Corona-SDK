require "classes.constants.screen"

Model={}

function Model:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local data = {}


    function private.Model()

    end

    function public.getData()
        return data
    end

    function public.setData(newData)
        data = newData
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.Model()
    return this
end
return Model
