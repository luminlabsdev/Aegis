-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Returning
return {
	KeyName = "Children",
	ApplyKey = function(instance: Instance, value: any)
		Utils.LoopAndInteract(typeof(value), value, function()
			value.Parent = instance
		end, true, instance)
	end,
}
