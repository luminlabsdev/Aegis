-- // Services
local RunService = game:GetService("RunService")

-- // Dependencies
local PublicTypes = require(script.Parent.Parent.Utility.PublicTypes)

-- // Returning
return {
	AegisClass = "Key",
	AegisName = "Ref",
	Apply = function(instance: Instance, _, value: PublicTypes.State)
		if value.AegisClass == "API" and value.AegisName == "State" then
			value._protectType = false
			value:Set(instance)
			RunService[RunService:IsClient() and "RenderStepped" or "Heartbeat"]:Wait()
			value._protectType = true
		end
	end,
}
