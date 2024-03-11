-- // Dependencies
local Debugger = require(script.Parent.Parent.Debugger)

-- // Returning
return {
	ClassName = "Robax.Keys",
	SubClass = "Events",
	Apply = function(instance: Instance, _, value: { [string]: () -> () })
		local CurrentType: string -- A variable so that same types do not take extra memory

		for eventName, fn in value do
			CurrentType = typeof((instance :: any)[eventName])
			if CurrentType == "RBXScriptSignal" then -- Check type
				(instance :: any)[eventName]:Connect(fn) -- and connect
			else
				Debugger.Warn("TypeMismatch", "RBXScriptSignal", CurrentType) -- else just warn it
			end
		end
	end,
}
