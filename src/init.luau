-- // Folders
local Constructors = script.Constructors
local Utility = script.Utility
local Runtime = script.Runtime
local Types = script.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local Debugger = require(Utility.Debugger)
local Storage = require(Runtime.Storage)
local Is = require(Utility.Is)

-- // Variables
local Aegis = {
	new = require(Constructors.new),
	state = require(Constructors.state),
	spring = require(Constructors.spring),
}

-- // Functions
function Aegis.RegisterKey(key: InternalTypes.Key): InternalTypes.Key?
	if Is.Key(key) == true then
		if not Storage.RegisteredKeys[key.KeyName] then
			Storage.RegisteredKeys[key.KeyName] = key
			return Storage.RegisteredKeys[key.KeyName]
		else
			Debugger.Warn("FailedToRegisterKey", `{key.KeyName} already exists.`)
			return
		end
	else
		Debugger.Warn("FailedToRegisterKey", "Argument#1 is not a key.")
		return
	end
end

function Aegis.Key(keyName: string): InternalTypes.Key?
	return Storage.RegisteredKeys[keyName]
end

-- // Initialize
for _, key in script.Keys:GetChildren() do
	Aegis.RegisterKey(require(key) :: InternalTypes.Key)
end

-- // Returning
return table.freeze(Aegis)
