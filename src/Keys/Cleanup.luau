-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Is = require(Utility.Is)
local Types = require(script.Parent.Parent.Types)

-- // Returning
return {
	KeyName = "Cleanup",
	ApplyKey = function(instance: Instance, value: any): ()
		instance.Destroying:Connect(function(): ()
			if Is.AegisConstructor(value) == true then
				(value :: Types.Constructor):Destroy()
			end
		end)
	end,
}
