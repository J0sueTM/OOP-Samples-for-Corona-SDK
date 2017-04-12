require "classes.constants.screen"
require "classes.samples.Physics.Chains"
require "classes.samples.Physics.CollisionDetection"
require "classes.samples.Physics.CollisionFilter"
require "classes.samples.Physics.DebugDraw"
require "classes.samples.Physics.DragPlatforms"
require "classes.samples.Physics.HelloPhysics"

DataPhysicsList={}

function DataPhysicsList:new()
    local this = {
        {img = "", title = "Chains", isList = false, execute=function() return Chains:new() end},
        {img = "", title = "CollisionDetection", isList = false, execute=function() return CollisionDetection:new() end},
        {img = "", title = "CollisionFilter", isList = false, execute=function() return CollisionFilter:new() end},
        {img = "", title = "DebugDraw", isList = false, execute=function() return DebugDraw:new() end},
        {img = "", title = "DragPlatforms", isList = false, execute=function() return DragPlatforms:new() end},
        {img = "", title = "HelloPhysics", isList = false, execute=function() return HelloPhysics:new() end},
    }
    local public = this
    local private = {}

    function private.DataPhysicsList()

        this.isList = true
        this.hasBackButton = true

    end

    function public.goCurrent()
        return DataPhysicsList:new()
    end

    function public.goBack()
        return DataAllTopicList:new()
    end

    function public:destroy()
        this:removeSelf()
        this = nil
    end

    private.DataPhysicsList()
    return this
end
return DataPhysicsList
