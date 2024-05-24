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
local function new(className: string, propertyTable: { [any]: any }): Instance
	local Success, Result = pcall(Instance.new, className) -- Create the instance wrapped inside pcall

	if Success == true then
		for property: any, value: any in propertyTable do
			Utils.ApplyProperty(Result, property, value)
		end

		if propertyTable.Parent then
			Utils.ApplyProperty(Result, "Parent", propertyTable.Parent)
		end
	else -- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToBuild", className, Result)
	end

	return Result
end

-- // Returning
return new
