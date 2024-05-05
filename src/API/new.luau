-- // Folder
local Types = script.Parent.Parent.Types
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

-- // Variables
local Class = {}

-- // Functions
--[[
	@param component Read an AegisComponent and attach it to the instance
	@return AegisInstance
]]
function Class.ReadComponent(self: InternalTypes.InstanceInternal, component: PublicTypes.Component)
	self.Component = component
	self:ApplyProps(self.Component)

	return self
end

--[[
	@param propertyTable The property table of the instance which is to be applied
	@return AegisInstance
]]
function Class.ApplyProps(self: InternalTypes.InstanceInternal, propertyTable: { [any]: any })
	for property: any, value: any in propertyTable do
		if Is.Key(property) == true then
			(property :: InternalTypes.Key).Apply(self.Instance, property, value)
		elseif type(property) == "string" then
			if property == "Parent" then
				continue
			else
				local Property = (self.Instance :: any)[property]
				local IsAPI = Is.API(value)

				if IsAPI == true then
					-- Call the _apply method of the API class.
					Utils.CheckTypeAndCall(Property, value:Get(), function()
						(value :: InternalTypes.API<typeof(value)>):_apply(property, self.Instance)
					end)
				elseif not IsAPI then
					-- Meaning, the index is a string and the value is the actual property type
					Utils.CheckTypeAndCall(Property, value, function()
						(self.Instance :: any)[property] = value
					end)
				end
			end
		end
	end

	if propertyTable.Parent then
		self.Instance.Parent = propertyTable.Parent
	end

	return self
end

--[[
	@param className The class name of the instance to create
	@return AegisInstance
]]
local function new(className: string): PublicTypes.AegisInstance
	local self
	local Success, Result = pcall(Instance.new, className) -- Create the instance wrapped inside pcall

	if Success == true then
		self = setmetatable({} :: InternalTypes.InstanceInternal, { __index = Class })

		self.AegisClass = "API"
		self.AegisName = "Instance"

		self.Instance = Result
		self.Component = {}
	else
		-- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToBuild", className, Result)
	end

	return self
end

-- // Returning
return new
