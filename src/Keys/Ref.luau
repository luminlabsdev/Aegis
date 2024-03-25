-- // Dependencies
local Is = require(script.Parent.Parent.Utility.Is)
local PublicTypes = require(script.Parent.Parent.Utility.PublicTypes)

-- // Returning
return {
	AegisClass = "Key",
	AegisName = "Ref",
	Apply = function(instance: Instance, _, value: PublicTypes.State)
		if Is.API(value) == true and value.AegisClass == "API" and value.AegisName == "State" then
			value._protectType = false
			value:Set(instance)
			value._protectType = true
		end
	end,
}
