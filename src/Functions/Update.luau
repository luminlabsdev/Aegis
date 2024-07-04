-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
--[[
	@param instance The instance to update the properties of.
	@param propertyTable Table of properties to be applied to the instance.
	@param childrenTable Table of instances to be parented to the instance.
	@return Instance
]]
local function Update(instance: Instance, propertyTable: { [any]: any }?, childrenTable: { [any]: Instance }?): Instance
	if propertyTable then
		for property, value in propertyTable do
			if property == "Parent" then
				continue
			end

			Utils.ApplyProperty(instance, property, value)
		end
		if (propertyTable :: any).Parent then
			Utils.ApplyProperty(instance, "Parent", (propertyTable :: any).Parent)
		end
	end

	if childrenTable then
		for name, value in childrenTable do
			value.Parent = instance
			value.Name = type(name) == "string" and name or value.Name
		end
	end

	return instance
end

-- // Returning
return Update
