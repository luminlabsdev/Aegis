-- // Dependencies
local Debugger = require(script.Parent.Debugger)

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

local function GetAndSetAtPath(self: self, path: string, optionalValue: any?): any
	-- Split the path by "/" and create a new variable to reference the self.__state table
	local Paths = string.split(path, "/")
	local Current = self.__state

	for index, key in Paths do
		--[[
			If the index is at the last index of the Paths table and optionalValue is provided
			and after indexing, Current[key] is not nil, set it to the new value.
		]]
		if index == #Paths then
			local Old = Current[key] -- A variable just needed for checking Current[key]

			if optionalValue and Old then
				if self.__protectType and typeof(Old) ~= typeof(optionalValue) then
					Debugger.Warn("TypeMismatch", typeof(Old), typeof(optionalValue))
					continue
				else
					Current[key] = optionalValue
				end
			end

			Current = Current[key] -- Optional value wasn't provided, set it regardless
		end

		Current = Current[key] -- If it does not meet the above checks just set it normally.
	end

	return Current
end

--[[
	@param key if provided, will return the specific value of that provided key.
	@param defaultValue if provided, will return the defaultValue if key is nil.
]]
function Class.Get<T>(self: self, path: string?, defaultValue: T?): T
	return if path then GetAndSetAtPath(self, path) elseif defaultValue then defaultValue else self.__state
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
		GetAndSetAtPath(self, info.path, info.value)
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
