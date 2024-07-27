-- FOLDERS >
local Utility = script.Parent

-- DEPENDENCIES >
local Storage = require(script.Parent.Parent.Runtime.Storage)
local Types = require(script.Parent.Parent.Types)
local Debugger = require(Utility.Debugger)
local Is = require(Utility.Is)

-- Private Functions
local function RunCallback(callback, thread, ...)
	callback(...)
	table.insert(Storage.FreeThreads, thread)
end

local function Yielder()
	while true do
		RunCallback(coroutine.yield())
	end
end

-- Public Functions
local function CheckTypeAndCall(expected: any, received: any, interaction: () -> (), ...: any): ()
	if Is.TypeSame(expected, received) then
		interaction(...) -- Type matches, call the interaction function.
	else -- type didn't match
		-- Check either of the types is nil. If they are, let the interaction get through.
		if expected == nil or received == nil then
			interaction(...) -- Let the value `nil` to be set to anything
		else
			Debugger.Warn("TypeMismatch", typeof(expected), typeof(received))
			return
		end
	end
end

local function ApplyConstructorProperty(instance: Instance, prop: string, value: Types.Constructor)
	local Property = (instance :: any)[prop]

	-- Call the _bind method of the Service.
	CheckTypeAndCall(Property, value:Get(), function()
		(value :: Types.Constructor):_bind(prop, instance)
	end)
end

local function ApplyNormalProperty(instance: Instance, prop: string, value: any)
	local Property = (instance :: any)[prop]

	-- Meaning, the index is a string and the value is the actual property type
	CheckTypeAndCall(Property, value, function()
		(instance :: any)[prop] = value
	end)
end

local function ApplyProperty(instance: Instance, property: any, value: any)
	-- If the property is an Aegis key then
	if Is.Key(property) then
		(property :: Types.Key).ApplyKey(instance, value)
	elseif type(property) == "string" then
		-- but if the property is a string then
		if Is.AegisConstructor(value) then
			-- If the value is an Aegis service then
			ApplyConstructorProperty(instance, property, value)
		else
			-- else if the value is a normal data type then
			ApplyNormalProperty(instance, property, value)
		end
	end
end

--[[ Forked from red-blox's bin library ]]
local function Spawn(callback: () -> (), ...)
	local Thread

	if #Storage.FreeThreads > 0 then
		Thread = Storage.FreeThreads[#Storage.FreeThreads]
		Storage.FreeThreads[#Storage.FreeThreads] = nil
	else
		Thread = coroutine.create(Yielder)
		coroutine.resume(Thread)
	end

	task.spawn(Thread, callback, Thread, ...)
end

local function CleanMetatable(t)
	table.clear(t) -- Clears out the table contents
	setmetatable(t, nil) -- Removes the attached metatable
end

-- RETURNING >
return table.freeze({
	CheckTypeAndCall = CheckTypeAndCall,
	ApplyConstructorProperty = ApplyConstructorProperty,
	ApplyProperty = ApplyProperty,
	Spawn = Spawn,
	CleanMetatable = CleanMetatable,
})
