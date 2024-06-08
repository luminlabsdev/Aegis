-- // Dependencies
local InternalTypes = require(script.Parent.Parent.Types.Internal)

-- // Variables
local Is = {}

-- // Functions
function Is.AegisConstructor<T>(t: InternalTypes.Constructor)
	return if type(t) == "table" and t.ConstructorClass and t._init and t.Get then true else false
end

function Is.Key(t: InternalTypes.Key)
	return if type(t) == "table" and t.KeyName and t.ApplyKey then true else false
end

function Is.TypeSame(v1: any, v2: any)
	return typeof(v1) == typeof(v2)
end

-- // Returning
return Is
