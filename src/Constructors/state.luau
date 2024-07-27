-- FOLDERS >
local Aegis = script.Parent.Parent
local Utility = Aegis.Utility

-- DEPENDENCIES >
local Types = require(Aegis.Types)

local Utils = require(Utility.Utils)
local Debugger = require(Utility.Debugger)

-- VARIABLES >
local Class = {} :: Types.StateFunc

-- FUNCTIONS >
local function SetNewValue(self: Types.State, newValue: any, oldValue: any)
	-- Setting the actual value and triggering the listeners
	self._state = newValue

	-- Loop through the listeners table and call every function each of them have.
	for _, fn in self._listeners do
		task.spawn(fn, newValue, oldValue)
	end
end

--[[
	### `State:Get()`
	Returns the runtime value of the state object.

	#### Returns
	- `any`

	#### Examples
	```luau
	local MyState = Aegis.state(1)
	print(MyState:Get()) -- 1
	```
]]
function Class.Get(self: Types.State): any
	return self._state
end

--[[
	### `State:Set(newValue: any)`
	Sets a new value for the state.

	#### Parameters
	- **newValue:** The new value for the state.

	#### Returns
	- [`state`](https://lumin-dev.github.io/Aegis/api/state) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/managing-states)

	#### Example
	```luau
	local MyState = Aegis.state(1)
	print(MyState:Get()) -- 1
	MyState:Set(2)
	print(MyState:Get()) -- 2
	```
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
		Utils.CheckTypeAndCall(OldValue, newValue, SetNewValue :: any, self, newValue, OldValue)
	else
		SetNewValue(self, newValue, OldValue)
	end

	return self
end

--[[
	### `State:Listen(listenerFunction: (newValue: any, oldValue: any) -> ())`
	Listens to state changes.

	#### Parameters
	- **listenerFunction:** The listener function that will be called on value change.

	#### Returns
	- `DisconnectingFunction: () -> ()`

	#### Example
	```luau
	local MyState = Aegis.state(1)
	local DisconnectListener = MyState:Listen(function(newValue, oldValue)
		print(`Old: {oldValue} | New: {newValue}`)
	end)

	MyState:Set(2) -- Old: 1 | New: 2

	DisconnectListener() -- listener no longer valid.
	```
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

function Class._bind(self: Types.State, prop: string, instance: Instance)
	(instance :: any)[prop] = self._state

	self:Listen(function(newValue)
		(instance :: any)[prop] = newValue
	end)
end

--[[
	### `State:Destroy()`
	Destroys and removes the state.

	#### Returns
	- `nil`

	#### Example
	```luau
	local MyState = Aegis.state(1)
	MyState:Destroy() -- state no longer valid.
	```
]]
function Class.Destroy(self: Types.State): nil
	Utils.CleanMetatable(self :: any)
	return nil
end

--[[
	## `Aegis.state`
	A constructor to create new state objects.
	#### Parameters
	- **initialValue:** The initial value of the state object.
	- **protectType:** Whether to do type checking when setting value (default: true)
	#### Returns
	- [`state`](https://lumin-dev.github.io/Aegis/api/state) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/managing-states)
	#### Example
	```luau
	local MyState = Aegis.state("Hello Aegis")

	MyState:Listen(function(newValue: string, oldValue: string)
		print(`Before: {oldValue}`)
		print(`After: {newValue}`)
		print("-----")
	end)

	MyState:Set("hi fellow developers")
	MyState:Set("how are you guys")
	```

	#### Output:
	```txt
	Before: Hello Aegis
	After: hi fellow developers
	-----
	Before: hi fellow developers
	After: how are you guys
	-----
]]
return function(initialValue: any, protectType: boolean?): Types.State
	local Type = type(initialValue)

	if Type == "table" then
		Debugger.Warn("RestrictedType", Type)
		initialValue = initialValue or nil
	end

	local self = setmetatable({} :: Types.StateProps, { __index = Class } :: { __index: Types.StateFunc })

	self.ConstructorClass = "state"
	self._state = initialValue
	self._listeners = {}
	self._protectType = protectType or true

	return self
end
