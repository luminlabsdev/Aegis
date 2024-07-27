-- FOLDERS >
local Root = script.Parent.Parent
local Utility = Root.Utility

-- DEPENDENCIES >
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Types = require(Root.Types)

-- FUNCTIONS >
--[[
	## `Aegis.new`
	A constructor to create new instances.
	#### Parameters
	- **classOrComponent:** The class name of the instance or the component to create.
	- **properties:** A table of properties to be applied to the parent instance.
	- **children:** A table of descendant instances to be parented to the parent instance.
	#### Returns
	- [`Instance`](https://create.roblox.com/docs/reference/engine/classes/Instance) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/new-instances)
	#### Example
	```luau
	local BackgroundComponent = require(path.to.BackgroundComponent)

	local MenuUI = Aegis.new("ScreenGui", {
		Name = "MenuUI",
		IgnoreGuiInset = true,
		Parent = Player:WaitForChild("PlayerGui"),
	}, {
		Background = Aegis.new(BackgroundComponent, {
			Color = Color3.fromRGB(24, 24, 24),
		}),
	})
	```
]]
return function<T>(
	classOrComponent: string | Types.Component<T>,
	properties: (T & Types.Properties)?,
	children: Types.Children?
): Instance
	local Component
	if type(classOrComponent) == "string" then
		local Success, Result = pcall(Instance.new, classOrComponent) -- Create the instance wrapped inside pcall

		if Success then
			if properties then
				for property, value in properties :: any do
					if property == "Parent" then
						continue
					end

					Utils.ApplyProperty(Result, property, value)
				end

				if (properties :: any).Parent then
					Utils.ApplyProperty(Result, "Parent", (properties :: any).Parent)
				end
			end

			if children then
				for name, value in children do
					value.Parent = Result
					value.Name = if type(name) == "string" then name else value.Name
				end
			end

			Component = Result
		else -- If it wasn't successful, error it because instance creation has to be complete.
			Debugger.Error("FailedToCreate", classOrComponent, Result)
		end
	else
		if children then
			if not properties then
				properties = {} :: any
			end
			(properties :: any).Children = children
		end

		Component = classOrComponent(properties :: any)
	end
	return Component
end
