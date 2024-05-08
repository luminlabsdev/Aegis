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
local function ApplyNormalProperty(instance: Instance, prop: string, value: any)
	local Property = (instance :: any)[prop]
	local IsAPI = Is.API(value)

	if IsAPI == true then
		-- Call the _apply method of the API class.
		Utils.CheckTypeAndCall(Property, value:Get(), function()
			(value :: InternalTypes.API<typeof(value)>):_apply(prop, instance)
		end)
	elseif IsAPI == false then
		-- Meaning, the index is a string and the value is the actual property type
		Utils.CheckTypeAndCall(Property, value, function()
			(instance :: any)[prop] = value
		end)
	end
end

function Class._apply(self: InternalTypes.InstanceInternal, prop: string, instance: Instance)
	(instance :: any)[prop] = self.Instance
end

--[[
	@param component Read an AegisComponent and attach it to the instance
	@return AegisInstance
]]
function Class.ReadComponent(self: InternalTypes.InstanceInternal, component: PublicTypes.Component)
	self.Component = component

	if not table.find(component.AcceptedClasses, self.Instance.ClassName) then
		Debugger.Warn("ClassNotAccepted", self.Instance.ClassName, table.concat(component.AcceptedClasses, ", "))
	else
		self:ApplyProps(component.Properties)
	end

	return self
end

function Class.Get(self: InternalTypes.InstanceInternal)
	return self.Instance
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
				ApplyNormalProperty(self.Instance, property, value)
			end
		end
	end

	if propertyTable.Parent then
		ApplyNormalProperty(self.Instance, "Parent", propertyTable.Parent)
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
		self.Component = {} :: any
	else
		-- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToBuild", className, Result)
	end

	return self
end

-- // Returning
return new
