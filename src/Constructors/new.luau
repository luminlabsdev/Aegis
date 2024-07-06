-- Folder
local Utility = script.Parent.Parent.Utility
local Root = script.Parent.Parent

-- Dependencies
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Types = require(Root.Types)

-- Functions
--[[
	@param objectOrClass The class name of the instance to create
	@param propertyTable Properties to be passed to the `objectOrClass` created
	@param childrenTable A table of children to be parented to `objectOrClass`
	@return Instance
]]
local function new(
	objectOrClass: Types.ClassName | ((props: Types.PropertyTable) -> Instance),
	propertyTable: Types.PropertyTable?,
	childrenTable: Types.ChildrenTable?
): Instance
	local Object

	if type(objectOrClass) == "string" then
		local Success, Result = pcall(Instance.new, objectOrClass) -- Create the instance wrapped inside pcall

		if Success == true then
			if propertyTable then
				for property, value in propertyTable do
					if property == "Parent" then
						continue
					end

					Utils.ApplyProperty(Result, property, value)
				end

				if (propertyTable :: any).Parent then
					Utils.ApplyProperty(Result, "Parent", (propertyTable :: any).Parent)
				end
			end

			if childrenTable then
				for name, value in childrenTable do
					value.Parent = Result
					value.Name = if type(name) == "string" then name else value.Name
				end
			end

			Object = Result
		else -- If it wasn't successful, error it because instance creation has to be complete.
			Debugger.Error("FailedToCreate", objectOrClass, Result)
		end
	else
		if childrenTable then
			if not propertyTable then
				propertyTable = {}
			end
			(propertyTable :: Types.PropertyTable).Children = childrenTable
		end

		Object = objectOrClass(propertyTable :: any)
	end

	return Object
end

-- Returning
return new
