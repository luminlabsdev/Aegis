-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
--[[
	@param instance The instance to update the properties of
	@return Instance
]]
local function ApplyProperties(instance: Instance, propertyTable: { [any]: any })
	for property: any, value: any in propertyTable :: {} do
		if property == "Parent" then
			continue
		end

		Utils.ApplyProperty(instance :: Instance, property, value)
	end

	if (propertyTable :: any).Parent then
		Utils.ApplyProperty(instance :: Instance, "Parent", (propertyTable :: any).Parent)
	end
end

local function Update(instance: Instance | { Instance }, propertyTable: { [any]: any }?): Instance | { Instance }
	propertyTable = propertyTable or {}

	local Type = typeof(instance)

	if Type == "table" then
		for _, descendant in instance :: { Instance } do
			ApplyProperties(descendant, propertyTable :: { [any]: any })
		end
	elseif Type == "Instance" then
		ApplyProperties(instance :: Instance, propertyTable :: { [any]: any })
	end

	return instance
end

-- // Returning
return Update
