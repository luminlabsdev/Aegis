-- // Dependencies
local Debugger = require(script.Parent.Debugger)
local Keys = script.Parent.Parent.Keys
local InternalTypes = require(script.Parent.InternalTypes)
local Is = require(script.Parent.Is)

-- // Variables
local Utils = {}

-- // Functions
function Utils.CheckTypeAndCall(v1: any, v2: any, interaction: () -> ()): ()
	-- Use `Is.TypeSame(v1, v2)` to check if type matches.
	-- If it doesn't match, warn it.
	if Is.TypeSame(v1, v2) == true then
		interaction() -- Type matches, call the interaction function.
	else -- type didn't match, warn it out!
		Debugger.Warn("TypeMismatch", typeof(v1), typeof(v2))
	end
end

function Utils.ApplySpecialKeyProperty(instance: Instance, prop: {}, value: any): ()
	local Key = Keys[(prop :: any).AegisName] or nil

	if Key ~= nil then
		(require(Key) :: InternalTypes.Key).Apply(instance, prop, value)
	else
		Debugger.Warn("MissingChild", `Aegis.Keys.{(prop :: any).AegisName}`, script.Parent.Parent.Keys:GetFullName())
		return
	end
end

function Utils.GetAndSetAtPath(self: {}, path: string, optionalValue: any?): any
	-- Split the path by "/" and create a new variable to reference the self._state table
	local Paths = string.split(path, "/")
	local Current = (self :: any)._state

	for index, key in Paths do
		--[[
			If the index is at the last index of the Paths table and optionalValue is provided
			and after indexing, Current[key] is not nil, set it to the new value.
		]]
		if index == #Paths then
			local Old = Current[key] -- A variable just needed for checking Current[key]

			if optionalValue and Old then
				if (self :: any)._protectType and typeof(Old) ~= typeof(optionalValue) then
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

-- // Returning
return Utils
