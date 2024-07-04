-- // Folders
local Aegis = script.Parent.Parent
local Utility = Aegis.Utility

-- // Dependencies
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

local Types = require(Aegis.Types)

-- // Variables
local Class = {}

-- // Functions
--[[
	@param value Either a constructor or any data type
	@return any
]]
local function get(value: Types.Constructor | any)
	if Is.AegisConstructor(value) then
		return (value :: Types.Constructor):Get()
	else
		return value
	end
end

local function ListenerFunction(self: Types.Compute)
	return function()
		self._result = self._processor(get)

		if self._instances ~= nil then
			for prop, instance in self._instances do
				(instance :: any)[prop] = self._result
			end
		end
	end
end

--[[
	@return any
]]
function Class.Get(self: Types.Compute): any
	return self._result
end

function Class._init(self: Types.Compute, prop: string, instance: Instance)
	if self._instances == nil then
		self._instances = {}
	end

	(self._instances :: {})[prop] = instance;
	(instance :: any)[prop] = self._result
end

--[[
	@return nil
]]
function Class.Destroy(self: Types.Compute): nil
	if self._dependencies then
		for dependency, disconnect in self._dependencies do
			disconnect()
			self._dependencies[dependency] = nil
		end
	end

	Utils.CleanMetatable(self :: any)

	return nil
end

--[[
	@param processor The main function which will be run everytime the value changes
	@param dependencies A table of dependencies whose values will be listened to
	@return compute
]]
local function compute(
	processor: (get: typeof(get)) -> (),
	dependencies: { Types.State | Types.Spring | Types.Constructor }?
): Types.Compute
	local Dependencies = nil :: { [Types.State | Types.Spring | Types.Constructor]: () -> () }?
	local self = setmetatable({} :: Types.ComputeProps, { __index = Class } :: { __index: Types.ComputeFunc })

	self.ConstructorClass = "compute"
	self._processor = processor
	self._dependencies = Dependencies
	self._result = self._processor(get)
	self._instances = {}

	if dependencies then
		local TypeOfDependencies = type(dependencies)

		if TypeOfDependencies == "table" then
			Dependencies = {
				-- [State]: DisconnectListenerFunction,
			} :: {}

			for _, v in dependencies do
				if Is.AegisConstructor(v :: any) then
					if (v :: Types.Constructor).ConstructorClass == "state" then
						(Dependencies :: {})[v] = (v :: Types.State):Listen(ListenerFunction(self))
					elseif (v :: Types.Constructor).ConstructorClass == "spring" then
						(Dependencies :: {})[v] = (v :: Types.Spring)._state:Listen(ListenerFunction(self))
					else
						Debugger.Warn("ConstructorNotSupported", v.ConstructorClass)
					end
				end
			end
		else
			Debugger.Warn("TypeMismatch", "table", TypeOfDependencies)
		end
	end

	return self
end

-- // Returning
return compute
