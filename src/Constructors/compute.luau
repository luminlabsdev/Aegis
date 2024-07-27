-- FOLDERS >
local Aegis = script.Parent.Parent
local Utility = Aegis.Utility

-- DEPENDENCIES >
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

local Types = require(Aegis.Types)

-- VARIABLES >
local Class = {}

-- FUNCTIONS >
--[[
	### `get(Types.Constructor | any)`
	Get the runtime value of a constructor or a data type.

	#### Parameters
	- **value:** The constructor or data type to get the value of.

	#### Returns
	- `any`

	#### Example
	```luau
	local MyState = Aegis.state(1)
	local ReturnDouble = Aegis.compute(function(get)
		return get(MyState) * 2 -- get(MyState) returns `2` here.
	end, { MyState })
	```
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
	### `Compute:Get()`
	Returns the runtime value of the compute object.

	#### Returns
	- `any`

	#### Examples
	```luau
	local MyState = Aegis.state(1)
	local ReturnDouble = Aegis.compute(function(get)
		return get(MyState) * 2
	end, { MyState })

	MyState:Set(2)

	print(ReturnDouble:Get()) -- 4
	```
]]
function Class.Get(self: Types.Compute): any
	return self._result
end

function Class._bind(self: Types.Compute, prop: string, instance: Instance)
	if self._instances == nil then
		self._instances = {}
	end

	(self._instances :: {})[prop] = instance;
	(instance :: any)[prop] = self._result
end

--[[
	### `Compute:Destroy()`
	Destroys and removes the compute object.

	#### Returns
	- `nil`

	#### Example
	```luau
	local MyCompute = Aegis.compute(function()
		-- code
	end)

	MyCompute:Destroy() -- compute object no longer valid.
	```
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
	## `Aegis.compute`
	A constructor that calculates the result while listening to the value of its dependencies.
	#### Parameters
	- **processor:** The processing function that will run everytime the value changes.
	- **dependencies:** Table of dependencies whose values will be listened to.
	#### Returns
	- [`compute`](https://lumin-dev.github.io/Aegis/api/compute) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/managing-computes)
	#### Example
	```luau
	local state = Aegis.state
	local compute = Aegis.compute

	local Coins = state(100) -- State object for coins
	local Price = state(50) -- State object for price value

	local CalculateCoins = compute(function(get)
		return get(Coins) - get(Price)
	end, { Coins }) -- adding a dependency

	print(CalculateCoins:Get()) -- 50
	Coins:Set(200) -- changing the value
	print(CalculateCoins:Get()) -- 150
	```
]]
return function(
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
