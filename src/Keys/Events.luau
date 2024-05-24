-- // Dependencies
local Debugger = require(script.Parent.Parent.Utility.Debugger)

-- // Returning
return {
	KeyName = "Events",
	ApplyKey = function(instance: Instance, value: { [string]: (...any) -> () })
		local CurrentType: string -- A variable so that same types do not take extra memory

		for eventName, fn in value do
			CurrentType = typeof((instance :: any)[eventName])
			if CurrentType == "RBXScriptSignal" then -- Check type
				(instance :: any)[eventName]:Connect(function(...: any)
					fn(unpack({ ... }))
				end)
			else
				Debugger.Warn("TypeMismatch", "RBXScriptSignal", CurrentType) -- else just warn it
			end
		end
	end,
}
