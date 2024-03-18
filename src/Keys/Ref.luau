-- // Returning
return {
	AegisClass = "Key",
	AegisName = "Ref",
	Apply = function(instance: Instance, _, value: any)
		if value.AegisClass == "API" and value.AegisName == "State" then
			value._protectType = false
			value:Set(instance)
		end
	end,
}
