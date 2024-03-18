-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Debugger = require(Utility.Debugger)

-- // Variables
local Class = {}

-- // Functions
local function TriggerListeners(listeners: { (oldValue: any, newValue: any) -> () }, oldValue: any, value: any): ()
	-- Loop through the listeners table and call every function each of them have.
	for _, fn in listeners do
		fn(oldValue, value)
	end
end

--[[
	@return T
]]
function Class.Get<T>(self: self): T
	return self._state
end

--[[
	@param newValue The value to change to
]]
function Class.Set(self: self, newValue: any): ()
	local OldValue = self._state

	-- Normal checks
	if self._state == newValue then
		return
	end
	if self._protectType == true and typeof(OldValue) ~= typeof(newValue) then
		Debugger.Warn("TypeMismatch", typeof(OldValue), typeof(newValue))
		return
	end

	-- Setting the actual value and triggering the listeners
	self._state = newValue
	TriggerListeners(self._listeners, OldValue, newValue)
end

--[[
	@param fn The listener function that the paths will listen to.
]]
function Class.Listen(self: self, fn: (oldValue: any, newValue: any) -> ()): ()
	table.insert(self._listeners, fn) -- Add a listener
end

-- TODO: Complete ._apply function
function Class._apply(self: self, prop: string, instance: Instance)
	self:Listen(function(_, newValue)
		(instance :: any)[prop] = newValue
	end)
end

--[[
	@param initialState Create an empty state table
	@param protectType Whether to do type checking when setting value
	@return State
]]
local function State(initialState: any, protectType: boolean?): State?
	local self = setmetatable({} :: self, { __index = Class })

	self.AegisClass = "API"
	self.AegisName = "State"

	self._state = initialState or nil
	self._listeners = {}
	self._protectType = protectType or true

	return self
end

-- // Types
type self = {
	AegisClass: "API",
	AegisName: "State",

	_state: any,
	_listeners: { (oldValue: any, newValue: any) -> () },
	_protectType: boolean,

	Get: <T>(self: self) -> T,
	Set: (self: self, newValue: any) -> (),
	Listen: (self: self, fn: (oldValue: any, newValue: any) -> ()) -> (),
	_apply: (self: self, prop: string, instance: Instance) -> (),
}

export type State = typeof(setmetatable({} :: self, { __index = Class }))

-- // Returning
return State
