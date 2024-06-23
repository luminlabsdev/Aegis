-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Is = require(Utility.Is)
local Utils = require(Utility.Utils)
local Types = require(script.Parent.Parent.Types)

-- // Functions
local function CleanupElement(value: any, type: string)
	if Is.AegisConstructor(value) == true then
		(value :: Types.Constructor):Destroy()
	elseif type == "Instance" then
		(value :: Instance):Destroy()
	elseif type == "RBXScriptConnection" then
		(value :: RBXScriptConnection):Disconnect()
	elseif type == "function" then
		Utils.Spawn(value)
	end
end

-- // Returning
return {
	KeyName = "Cleanup",
	ApplyKey = function(instance: Instance, value: any): ()
		local Type = typeof(value)

		instance.Destroying:Connect(function(): ()
			if Type == "table" then
				for _, v in value do
					CleanupElement(v, Type)
				end

				table.clear(value)
			else
				CleanupElement(value, Type)
			end
		end)
	end,
}
