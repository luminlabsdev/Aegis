-- // Folder
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)

-- // Functions
--[[
	@param className The class name of the instance to create
	@return Instance
]]
local function new(className: string, propertyTable: { [any]: any }?, childrenTable: { [any]: Instance }?): Instance
	local Success, Result = pcall(Instance.new, className) -- Create the instance wrapped inside pcall

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
				value.Name = type(name) == "string" and name or value.Name
			end
		end
	else -- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToCreate", className, Result)
	end

	return Result
end

-- // Returning
return new
