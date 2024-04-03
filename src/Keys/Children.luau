-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Returning
return {
	AegisClass = "Key",
	AegisName = "Children",
	Apply = function(instance: Instance, _, value: any)
		if type(value) == "table" then
			for _, descendant: Instance in value do
				Utils.CheckTypeAndCall(descendant, instance, function()
					descendant.Parent = instance
				end)
			end
		elseif typeof(value) == "Instance" then
			Utils.CheckTypeAndCall(value, instance, function()
				value.Parent = instance
			end)
		end
	end,
}
