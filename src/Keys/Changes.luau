-- // Dependencies
-- local Debugger = require(script.Parent.Parent.Debugger)

-- // Returning
return {
	ClassName = "Robax.Keys",
	SubClass = "Changes",
	Apply = function(instance: Instance, _, value: { [string]: () -> () })
		for propertyName, fn in value do
			if type(propertyName) == "string" and type(fn) == "function" then
				-- Check the types and connect
				instance:GetPropertyChangedSignal(propertyName):Connect(fn)
			end
		end
	end,
}
