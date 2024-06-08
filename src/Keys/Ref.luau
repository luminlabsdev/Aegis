-- // Folders
local Utility = script.Parent.Parent.Utility
local Types = script.Parent.Parent.Types

-- // Dependencies
local Is = require(Utility.Is)
local Debugger = require(Utility.Debugger)
local InternalTypes = require(Types.Internal)

-- // Returning
return {
	KeyName = "Ref",
	ApplyKey = function(instance: Instance, value: any)
		if Is.AegisConstructor(value) == true and (value :: InternalTypes.Constructor).ConstructorClass == "State" then
			value:Set(instance)
		else
			Debugger.Warn("ServiceExpected", "state", typeof(value))
		end
	end,
}
