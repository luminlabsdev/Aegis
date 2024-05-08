-- // Folders
local Utility = script.Parent
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
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

function Utils.PackDataType(t: any): ({ number }, string)
	local Type = typeof(t)

	if Type == "number" then
		return { t }, Type
	elseif Type == ("Vector3" or "Vector3int16") then
		return { t.X, t.Y, t.Z }, Type
	elseif Type == ("Vector2" or "Vector2int16") then
		return { t.X, t.Y }, Type
	elseif Type == "UDim2" then
		return {
			t.X.Scale,
			t.X.Offset,
			t.Y.Scale,
			t.Y.Offset,
		}, Type
	elseif Type == "UDim" then
		return {
			t.Scale,
			t.Offset,
		}, Type
	else
		return {}, Type
	end
end

function Utils.UnpackDataType(t: {}, dataType: string): InternalTypes.Animatable
	if dataType == "number" then
		return t[1]
	elseif dataType == "UDim2" then
		return UDim2.new(table.unpack(t))
	elseif dataType == "UDim" then
		return UDim.new(table.unpack(t))
	elseif dataType == "Vector3" then
		return Vector3.new(table.unpack(t))
	elseif dataType == "Vector3int16" then
		return Vector3int16.new(table.unpack(t))
	elseif dataType == "Vector2" then
		return Vector2.new(table.unpack(t))
	elseif dataType == "Vector2int16" then
		return Vector2int16.new(table.unpack(t))
	else
		return t :: any
	end
end

-- // Returning
return Utils
