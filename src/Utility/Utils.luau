-- // Folders
local Utility = script.Parent
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.Internal)
local Debugger = require(Utility.Debugger)
local Is = require(Utility.Is)

-- // Variables
local Utils = {}

-- // Functions
function Utils.CheckTypeAndCall(expected: any, received: any, interaction: () -> ()): ()
	-- Use `Is.TypeSame(expected, received)` to check if type matches.
	-- If it doesn't match, warn it.
	if Is.TypeSame(expected, received) == true then
		interaction() -- Type matches, call the interaction function.
	else -- type didn't match, warn it out!
		if expected == nil then
			interaction() -- Let the value `nil` to be set to anything
		else
			Debugger.Warn("TypeMismatch", typeof(expected), typeof(received))
		end
	end
end

function Utils.ApplyConstructorProperty(instance: Instance, prop: string, value: any)
	local Property = (instance :: any)[prop]

	-- Call the _initservice method of the Service.
	Utils.CheckTypeAndCall(Property, value:Get(), function()
		(value :: InternalTypes.Constructor):_init(prop, instance)
	end)
end

function Utils.ApplyNormalProperty(instance: Instance, prop: string, value: any)
	local Property = (instance :: any)[prop]

	-- Meaning, the index is a string and the value is the actual property type
	Utils.CheckTypeAndCall(Property, value, function()
		(instance :: any)[prop] = value
	end)
end

function Utils.ApplyProperty(instance: Instance, property: any, value: any)
	-- If the property is an Aegis key then
	if Is.Key(property) == true then
		(property :: InternalTypes.Key).ApplyKey(instance, value)
	elseif type(property) == "string" then
		-- but if the property is a string then
		if Is.AegisConstructor(value) == true then
			-- If the value is an Aegis service then
			Utils.ApplyConstructorProperty(instance, property, value)
		else
			-- else if the value is a normal data type then
			Utils.ApplyNormalProperty(instance, property, value)
		end
	end
end

-- // Returning
return Utils
