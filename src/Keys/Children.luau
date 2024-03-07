-- // Dependencies
local Debugger = require(script.Parent.Parent.Debugger)

-- // Variables
local Children = {}

-- // Modification
Children.ClassName = "Robax.Keys"
Children.SubClass = "Children"

-- // Functions
local function ApplyNormalProperty(instance: Instance, prop: string, value: any)
	-- Check if type matches
	if typeof((instance :: any)[prop]) ~= typeof(value) then
		Debugger.Warn("TypeMismatch", typeof((instance :: any)[prop]), typeof(value))
		return
	end

	-- Check if the value is same or not; if it is, don't assign it.
	-- TODO: Benchmark with and without this `if` statement
	-- UPDATE: As of right now, an unnecessary if statement.
	--[[
		if (instance :: any)[prop] == value then
			return
		end
	]]

	(instance :: any)[prop] = value
end

local function ApplySpecialProperty(instance: Instance, index: {}, value: {})
	if (index :: any).ClassName == "Robax.Keys" and (index :: any).SubClass then
		local Key = script.Parent:FindFirstChild((index :: any).SubClass) or nil

		if Key ~= nil then
			(require(Key) :: any)(instance, index, value)
		else
			Debugger.Warn("MissingChild", `Robax.Keys.{(index :: any).SubClass}`, script.Parent:GetFullName())
		end
	end
end

function Children:Apply(instance: Instance, index: any, value: any)
	if type(index) == "string" then
		ApplyNormalProperty(instance, index, value)
	elseif type(index) == "table" then
		ApplySpecialProperty(instance, index, value)
	end
end

-- // Returning
return Children
