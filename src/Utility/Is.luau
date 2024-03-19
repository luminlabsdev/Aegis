-- // Dependencies
local InternalTypes = require(script.Parent.InternalTypes)

-- // Variables
local Is = {}

-- // Functions
function Is.API<T>(t: InternalTypes.API<T>)
	if t.AegisClass == "API" and (t.AegisName and t._apply) then
		return true
	else
		return false
	end
end

function Is.Key(t: InternalTypes.Key)
	if t.AegisClass == "Key" and (t.AegisName and t.Apply) then
		return true
	else
		return false
	end
end

-- // Returning
return Is
