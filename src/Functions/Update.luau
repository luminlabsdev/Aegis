-- Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)
local Types = require(script.Parent.Parent.Types)

-- Functions
--[[
	@param instance The instance to update the properties of.
	@param properties Properties to be applied to the instance.
	@param children Children to be parented to the instance.
	@return Instance
]]
return function(component: Instance, properties: Types.Properties?, children: Types.Children?): Instance
	if properties then
		for property, value in properties do
			if property == "Parent" then
				continue
			end

			Utils.ApplyProperty(component, property, value)
		end
		if (properties :: any).Parent then
			Utils.ApplyProperty(component, "Parent", (properties :: any).Parent)
		end
	end

	if children then
		for name, value in children do
			value.Parent = component
			value.Name = type(name) == "string" and name or value.Name
		end
	end

	return component
end