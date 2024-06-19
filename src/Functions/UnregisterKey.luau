-- // Folders
local Aegis = script.Parent.Parent

-- // Dependencies
local Types = require(Aegis.Types)
local Is = require(Aegis.Utility.Is)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- // Functions
function UnregisterKey(key: string | Types.Key): ()
	local Type = typeof(key)
	local KeyName: string?

	if Is.Key(key :: Types.Key) == true then
		KeyName = (key :: Types.Key).KeyName

		if not Storage.RegisteredKeys[KeyName] then
			Debugger.Warn("KeyNotFound", KeyName)
			return
		end
	elseif Type == "string" then
		KeyName = key :: string

		if not Storage.RegisteredKeys[key] then
			Debugger.Warn("KeyNotFound", key)
			return
		end
	end

	table.clear(Storage.RegisteredKeys[KeyName])
	Storage.RegisteredKeys[KeyName] = nil
end

-- // Returning
return UnregisterKey
