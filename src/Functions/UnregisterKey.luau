-- FOLDERS >
local Aegis = script.Parent.Parent

-- DEPENDENCIES >
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- FUNCTIONS >
--[[
	## `Aegis.UnregisterKey`
	A key to remove.
	#### Parameters
	- **keyName:** The name of the key to remove.
	#### Returns
	- [`Key?`](https://lumin-dev.github.io/Aegis/api/keys/) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/managing-keys)
	#### Example
	```luau
	local NamePrinterKey = Aegis.RegisterKey({
		KeyName = "NamePrinter",
		ApplyKey = function(instance: Instance, value: any)
			print(instance.Name, value)
		end,
	})

	Aegis.new("Frame", {
		Name = "UI",
		[NamePrinterKey] = "is made by Aegis!", -- UI is made by Aegis!
	})

	Aegis.UnregisterKey("NamePrinter") -- Now, we are removing it.
	```
]]
return function(key: string): ()
	if not Storage.RegisteredKeys[key] then
		Debugger.Warn("KeyNotFound", key)
		return
	end

	table.clear(Storage.RegisteredKeys[key])
	Storage.RegisteredKeys[key] = nil
end
