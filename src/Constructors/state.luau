-- // Folders
local Aegis = script.Parent.Parent
local Utility = Aegis.Utility

-- // Dependencies
local Types = require(Aegis.Types)

local Is = require(Utility.Is)
local Utils = require(Utility.Utils)
local Debugger = require(Utility.Debugger)

-- // Variables
local Class = {} :: Types.StateFunc

-- // Functions
local function SetNewValue(self: Types.State, oldValue: any, newValue: any)
	-- Setting the actual value and triggering the listeners
	self._state = newValue

	-- Loop through the listeners table and call every function each of them have.
	for _, fn in self._listeners do
		task.spawn(fn, newValue, oldValue)
	end
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

	if self._protectType == true then
		Utils.CheckTypeAndCall(OldValue, newValue, SetNewValue :: any, self, OldValue, newValue)
	else
		SetNewValue(self, OldValue, newValue)
	end

	return self
end

--[[
	@param listenerFunction The listener function that the paths will listen to.
	@return function
]]
function Class.Listen(self: Types.State, listenerFunction: (newValue: any, oldValue: any) -> ()): () -> ()
	table.insert(self._listeners, listenerFunction) -- Add a listener

	-- Disconnecting function
	return function()
		local FoundListener = table.find(self._listeners, listenerFunction)

		if FoundListener then
			table.remove(self._listeners, FoundListener)
		else
			Debugger.Warn("CannotFindIndex", "State:Listen(...)")
			return
		end
	end
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
	Utils.CleanMetatable(self :: any)
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

	self.ConstructorClass = "state"
	self._state = initialState
	self._listeners = {}
	self._protectType = protectType or true

	return self
end

-- // Returning
return state
