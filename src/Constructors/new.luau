-- Folder
local Utility = script.Parent.Parent.Utility
local Root = script.Parent.Parent

-- Dependencies
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Types = require(Root.Types)

-- Functions
--[[
	@param classOrComponent The class name of the instance to create, or a provided component
	@param properties Properties to be passed to the `classOrComponent` created
	@param children Children to be parented to `classOrComponent`
	@return Instance
]]
return function <T>(
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
