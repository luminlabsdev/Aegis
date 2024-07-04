-- // Folders
local Aegis = script.Parent.Parent

-- // Dependencies
local Types = require(Aegis.Types)
local Is = require(Aegis.Utility.Is)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- // Functions
--[[
	@param key The key to be registered.
	@return Key?
]]
function RegisterKey(key: Types.Key): Types.Key?
	if Is.Key(key) then
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

-- // Returning
return RegisterKey
