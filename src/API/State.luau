-- // Dependencies
-- local Debugger = require(script.Parent.Debugger)
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Variables
local Class = {}

-- // Functions
local function TriggerListeners(self: self, path: string, value: any): ()
	self._listeners[path] = self._listeners[path] or {}

	-- Loop through self._listeners[path] and call every function each of them have.
	for _, fn: (pathChanged: string, newValue: any) -> () in self._listeners[path] do
		fn(path, value)
	end
end

--[[
	@param key if provided, will return the specific value of that provided key.
	@param defaultValue if provided, will return the defaultValue if key is nil.
	@return any
]]
function Class.Get<T>(self: self, path: string?, defaultValue: T?): T
	return if path then Utils.GetAndSetAtPath(self, path) elseif defaultValue then defaultValue else self._state
end

--[[
	@param ...:{path:string,value:any} Provide table with 2 indexes; path and value. The path to change, and the value to change to.
]]
function Class.Set(
	self: self,
	...: {
		path: string,
		value: any,
	}
): ()
	for _, info in { ... } do
		Utils.GetAndSetAtPath(self, info.path, info.value)
		TriggerListeners(self, info.path, info.value)
	end
end

--[[
	@param paths The paths to have the listener function.
	@param fn The listener function that the paths will listen to.
]]
function Class.Listen(self: self, paths: { string }, fn: (pathChanged: string, newValue: any) -> ()): ()
	for _, path in paths do
		self._listeners[path] = self._listeners[path] or {}
		table.insert(self._listeners[path], fn)
	end
end

function Class._apply(self: self, prop: string, instance: Instance) end

--[[
	@param initialState Create an empty state table
	@param protectType Whether to do type checking when setting value
	@return State
]]
local function State(initialState: { [string]: any }, protectType: boolean?): State
	local self = setmetatable({} :: self, { __index = Class })

	self.AegisClass = "API"
	self.AegisName = "State"

	self._state = initialState or {}
	self._listeners = {}
	self._protectType = protectType or true

	return self
end

-- // Types
type self = {
	AegisClass: "API",
	AegisName: "State",

	_state: { [string]: any },
	_listeners: {},
	_protectType: boolean,

	Get: <T>(key: string?, defaultValue: T?) -> T,
	Set: (self: self, ...{ path: string, value: any }) -> (),
	Listen: (self: self, paths: { string }, fn: (pathChanged: string, newValue: any) -> ()) -> (),
	_apply: (self: self, instance: Instance) -> (),
}

export type State = typeof(setmetatable({} :: self, { __index = Class }))

-- // Returning
return State
