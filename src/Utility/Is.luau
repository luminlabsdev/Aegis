-- Dependencies
local Types = require(script.Parent.Parent.Types)

-- Functions
local function AegisConstructor(t: Types.Constructor)
	return if type(t) == "table" and t.ConstructorClass and t._init and t.Get then true else false
end

local function Key(t: Types.Key)
	return if type(t) == "table" and t.KeyName and t.ApplyKey then true else false
end

local function TypeSame(v1: any, v2: any)
	return typeof(v1) == typeof(v2)
end

-- Returning
return table.freeze({
	AegisConstructor = AegisConstructor,
	Key = Key,
	TypeSame = TypeSame,
})
