-- // Returning
return {
	KeyName = "Changes",
	ApplyKey = function(instance: Instance, value: { [string]: () -> () })
		for propertyName, fn in value do
			if type(propertyName) == "string" and type(fn) == "function" then
				-- Check the types and connect
				instance:GetPropertyChangedSignal(propertyName):Connect(fn)
			end
		end
	end,
}
