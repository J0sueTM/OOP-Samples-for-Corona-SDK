require "classes.constants.screen"
require "classes.samples.Monetization.InAppPurchase"

DataMonetizationList={}

function DataMonetizationList:new()
    local this = {
                      {img = "", title = "InAppPurchase", isList = false, execute=function() return InAppPurchase:new() end},
                 }
    local public = this
    local private = {}

    function private.DataMonetizationList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataMonetizationList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataMonetizationList()
    return this
end
return DataMonetizationList
