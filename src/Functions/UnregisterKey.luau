-- // Folders
local Aegis = script.Parent.Parent

-- // Dependencies
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- // Functions
--[[
	@param key Either the name of the key or the key itself.
	@return nil
]]
function UnregisterKey(key: string): ()
	if not Storage.RegisteredKeys[key] then
		Debugger.Warn("KeyNotFound", key)
		return
	end

	table.clear(Storage.RegisteredKeys[key])
	Storage.RegisteredKeys[key] = nil
end

-- // Returning
return UnregisterKey
