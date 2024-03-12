-- // Dependencies
-- local Debugger = require(script.Parent.Debugger)
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Variables
local Class = {}

-- // Functions
local function TriggerListeners(self: self, path: string, value: any): ()
	self.__listeners[path] = self.__listeners[path] or {}

	-- Loop through self._listeners[path] and call every function each of them have.
	for _, fn: (pathChanged: string, newValue: any) -> () in self.__listeners[path] do
		fn(path, value)
	end
end

--[[
	@param key if provided, will return the specific value of that provided key.
	@param defaultValue if provided, will return the defaultValue if key is nil.
]]
function Class.Get<T>(self: self, path: string?, defaultValue: T?): T
	return if path then Utils.GetAndSetAtPath(self, path) elseif defaultValue then defaultValue else self.__state
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
		self.__listeners[path] = self.__listeners[path] or {}
		table.insert(self.__listeners[path], fn)
	end
end

--[[
	@param initialState Create an empty state table
	@param protectType Whether to do type checking when setting value
]]
local function State(initialState: { [string]: any }, protectType: boolean?): State
	local self = setmetatable({} :: self, { __index = Class })

	self.ClassName = "Robax.State"

	self.__state = initialState or {}
	self.__listeners = {}
	self.__protectType = protectType or true

	return self
end

-- // Types
type self = {
	ClassName: "Robax.State",

	__state: { [string]: any },
	__listeners: {},
	__protectType: boolean,

	Get: <T>(key: string?, defaultValue: T?) -> T,
	Set: (self: self, ...{ path: string, value: any }) -> (),
	Listen: (self: self, paths: { string }, fn: (pathChanged: string, newValue: any) -> ()) -> (),
}

export type State = typeof(setmetatable({} :: self, { __index = Class }))

-- // Returning
return State
