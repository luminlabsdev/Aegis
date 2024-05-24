-- // Folders
local Constructors = script.Constructors
local Runtime = script.Runtime
local Utility = script.Utility
local Types = script.Types
local API = script.API

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local Debugger = require(Utility.Debugger)
local Storage = require(Runtime.Storage)
local Is = require(Utility.Is)

-- // Variables
local Aegis = {
	new = require(Constructors.new),
	spring = require(API.spring),
	state = require(API.state),
}

-- // Functions
function Aegis.RegisterKey(key: InternalTypes.Key)
	if Is.Key(key) == true then
		if not Storage.RegisteredKeys[key.KeyName] then
			Storage.RegisteredKeys[key.KeyName] = key
		else
			Debugger.Warn("FailedToRegisterKey", `{key.KeyName} already exists.`)
			return
		end
	else
		Debugger.Warn("FailedToRegisterKey", "Argument#1 is not a key.")
		return
	end
end

function Aegis.Key(name: string)
	return Storage.RegisteredKeys[name]
end

-- // Initialize
for _, key in script.Keys:GetChildren() do
	Aegis.RegisterKey(require(key) :: InternalTypes.Key)
end

-- // Returning
return table.freeze(Aegis)
