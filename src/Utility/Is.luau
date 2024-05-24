-- // Dependencies
local InternalTypes = require(script.Parent.Parent.Types.InternalTypes)

-- // Variables
local Is = {}

-- // Functions
function Is.API<T>(t: InternalTypes.API<T>)
	return if type(t) == "table" and t.APIName and t._initapi then true else false
end

function Is.Key(t: InternalTypes.Key)
	return if type(t) == "table" and t.KeyName and t.ApplyKey then true else false
end

function Is.TypeSame(v1: any, v2: any)
	return typeof(v1) == typeof(v2)
end

-- // Returning
return Is
