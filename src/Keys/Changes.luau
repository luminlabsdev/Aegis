-- // Dependencies
local Debugger = require(script.Parent.Parent.Debugger)

-- // Returning
return {
	SubClass = "Changes",
	Apply = function(instance: Instance, _, value: { [string]: () -> () })
		local CurrentType: string

		for propertyName, fn in value do
			CurrentType = typeof((instance :: any)[propertyName])
			if CurrentType == "RBXScriptSignal" then
				instance:GetPropertyChangedSignal(propertyName):Connect(fn)
			else
				Debugger.Warn("TypeMismatch", "RBXScriptSignal", CurrentType)
			end
		end
	end,
}
