-- // Dependencies
local Debugger = require(script.Parent.Parent.Debugger)

-- // Returning
return {
	SubClass = "Events",
	Apply = function(instance: Instance, _, value: { [string]: () -> () })
		local CurrentType: string

		for eventName, fn in value do
			CurrentType = typeof((instance :: any)[eventName])
			if CurrentType == "RBXScriptSignal" then
				(instance :: any)[eventName]:Connect(fn)
			else
				Debugger.Warn("TypeMismatch", "RBXScriptSignal", CurrentType)
			end
		end
	end,
}
