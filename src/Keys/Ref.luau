-- // Folders
local Utility = script.Parent.Parent.Utility
local Types = script.Parent.Parent.Types

-- // Dependencies
local Is = require(Utility.Is)
local Debugger = require(Utility.Debugger)
local InternalTypes = require(Types.InternalTypes)

-- // Returning
return {
	KeyName = "Ref",
	ApplyKey = function(instance: Instance, value: any)
		if Is.API(value) == true and (value :: InternalTypes.API<typeof(value)>).APIName == "Aegis.state" then
			value:Set(instance)
		else
			Debugger.Warn("APIExpected", "state", typeof(value))
		end
	end,
}
