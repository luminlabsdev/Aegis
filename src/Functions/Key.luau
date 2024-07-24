-- Folders
local Aegis = script.Parent.Parent

-- Dependencies
local Types = require(Aegis.Types)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- Functions
--[[
	@param name The key to access
	@return Key?
]]
return function(name: Types.DefaultKeys | string): Types.Key
	local FoundKey = Storage.RegisteredKeys[name]

	if not FoundKey then
		Debugger.Error("KeyNotFound", name)
	end

	return FoundKey
end