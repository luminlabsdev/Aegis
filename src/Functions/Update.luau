-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
--[[
	@param instance The instance to update the properties of
	@return Instance
]]
local function update(instance: Instance, propertyTable: { [any]: any }?): Instance
	propertyTable = propertyTable or {}

	for property: any, value: any in propertyTable :: {} do
		if property == "Parent" then
			continue
		end

		Utils.ApplyProperty(instance, property, value)
	end

	if (propertyTable :: any).Parent then
		Utils.ApplyProperty(instance, "Parent", (propertyTable :: any).Parent)
	end

	return instance
end

-- // Returning
return update
