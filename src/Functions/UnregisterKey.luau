-- // Folders
local Aegis = script.Parent.Parent

-- // Dependencies
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- // Functions
function UnregisterKey(keyName: string): ()
	if not Storage.RegisteredKeys[keyName] then
		Debugger.Warn("KeyNotFound", keyName)
		return
	end

	table.clear(Storage.RegisteredKeys[keyName])
	Storage.RegisteredKeys[keyName] = nil
end

-- // Returning
return UnregisterKey
