-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Types = require(script.Parent.Parent.Types)
local Debugger = require(Utility.Debugger)
local Is = require(Utility.Is)

-- // Variables
local Class = {} :: Types.StateFunc

-- // Functions

--[[
	Created this function to avoid typechecking errors
]]
local function CleanTable(t)
	table.clear(t) -- Clears out the table contents
	setmetatable(t, nil) -- Removes the attached metatable
end

--[[
	@return T
]]
function Class.Get(self: Types.State): any
	return self._state
end

--[[
	@param newValue The value to change to
	@return State
]]
function Class.Set(self: Types.State, newValue: any): Types.State
	local Type = type(newValue)

	if Type == "table" then
		Debugger.Warn("RestrictedType", Type)
		return self
	end

	local OldValue = self._state

	-- Normal checks
	if self._state == newValue then
		return self
	end

	if self._protectType == true and Is.TypeSame(OldValue, newValue) == false then
		if OldValue ~= nil then
			Debugger.Warn("TypeMismatch", typeof(OldValue), typeof(newValue))
			return self
		end
	end

	-- Setting the actual value and triggering the listeners
	self._state = newValue

	-- Loop through the listeners table and call every function each of them have.
	for _, fn in self._listeners do
		task.spawn(fn, newValue, OldValue)
	end

	return self
end

--[[
	@param fn The listener function that the paths will listen to.
	@return State
]]
function Class.Listen(self: Types.State, listenerFunction: (newValue: any, oldValue: any) -> ()): Types.State
	table.insert(self._listeners, listenerFunction) -- Add a listener

	return self
end

function Class._init(self: Types.State, prop: string, instance: Instance)
	(instance :: any)[prop] = self._state

	self:Listen(function(newValue)
		(instance :: any)[prop] = newValue
	end)
end

--[[
	@return nil
]]
function Class.Destroy(self: Types.State): nil
	CleanTable(self :: any)
	return nil
end

--[[
	@param initialState Create a state class
	@param protectType Whether to do type checking when setting value (default: true)
	@return State
]]
local function state(initialState: any, protectType: boolean?): Types.State
	local Type = type(initialState)

	if Type == "table" then
		Debugger.Warn("RestrictedType", Type)
		initialState = initialState or nil
	end

	local self = setmetatable({} :: Types.StateProps, { __index = Class } :: { __index: Types.StateFunc })

	self.ConstructorClass = "State"
	self._state = initialState
	self._listeners = {}
	self._protectType = protectType or true

	return self
end

-- // Returning
return state
