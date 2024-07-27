-- DEPENDENCIES >
local Utils = require(script.Parent.Parent.Utility.Utils)
local Types = require(script.Parent.Parent.Types)

-- FUNCTIONS >
--[[
	## `Aegis.Update`
	A function to update the passed instance.
	#### Parameters
	- **instance:** The instance to update the properties of.
	- **propertyTable:** A table of properties to be applied to the parent instance.
	- **childrenTable:** A table of descendant instances to be parented to the parent instance.
	#### Returns
	- [`Instance`](https://create.roblox.com/docs/reference/engine/classes/Instance) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/updating-instances)
	#### Example
	```luau
	local UI = PlayerGui:WaitForChild("LoadingUI")

	Aegis.Update(UI, {
		Name = "MenuGUI",
		IgnoreGuiInset = true,
	})
	```
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
