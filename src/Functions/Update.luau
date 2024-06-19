-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
--[[
	@param instance The instance to update the properties of
	@return Instance
]]
local function Update(instance: Instance | { Instance }, propertyTable: { [any]: any }?): Instance | { Instance }
	propertyTable = propertyTable or {}

	Utils.LoopAndInteract(typeof(instance), instance, function()
		for property: any, value: any in propertyTable :: {} do
			if property == "Parent" then
				continue
			end

			Utils.ApplyProperty(instance :: Instance, property, value)
		end

		if (propertyTable :: any).Parent then
			Utils.ApplyProperty(instance :: Instance, "Parent", (propertyTable :: any).Parent)
		end
	end)

	return instance
end

-- // Returning
return Update
