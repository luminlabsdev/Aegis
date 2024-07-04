-- // Folders
local Aegis = script.Parent.Parent

-- // Dependencies
local Types = require(Aegis.Types)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- // Functions
--[[
	@param keyName: `string` The key to access 
	@return Key?
]]
function Key(keyName: Types.DefaultKeys | string): Types.Key?
	local FoundKey = Storage.RegisteredKeys[keyName]

	if not Key then
		Debugger.Warn("KeyNotFound", keyName)
		return nil
	end

	return FoundKey
end

-- // Returning
return Key
