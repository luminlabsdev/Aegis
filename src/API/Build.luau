-- // Folder
local Types = script.Parent.Parent.Types
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

-- // Functions
--[[
	@param className The class name of the instance to create
	@param props The property table of the instance which is to be applied
	@return Instance
]]
local function Build(className: string, propertyFunction: ((instance: Instance) -> { [any]: any }?)?): Instance?
	local Success, Result = pcall(Instance.new, className) -- Create the instance wrapped inside pcall

	if Success == true then -- if it's successfully created
		local PropertyTable = (
			if type(propertyFunction) == "function" then propertyFunction(Result) else {}
		) :: { [any]: any }

		for property: any, value: any in PropertyTable do
			if Is.Key(property) == true then
				(property :: InternalTypes.Key).Apply(Result, property, value)
			elseif type(property) == "string" then
				if property == "Parent" then
					continue
				else
					local Property = (Result :: any)[property]
					local IsAPI = Is.API(value)

					if IsAPI == true then
						-- Call the _apply method of the API class.
						Utils.CheckTypeAndCall(Property, value:Get(), function()
							(value :: InternalTypes.API<typeof(value)>):_apply(property, Result)
						end)
					elseif not IsAPI then
						-- Meaning, the index is a string and the value is the actual property type
						Utils.CheckTypeAndCall(Property, value, function()
							(Result :: any)[property] = value
						end)
					end
				end
			end
		end

		if PropertyTable.Parent ~= nil then
			Result.Parent = PropertyTable.Parent
		end

		return Result
	else
		-- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToBuild", className, Result)
		return nil
	end
end

-- // Returning
return Build
