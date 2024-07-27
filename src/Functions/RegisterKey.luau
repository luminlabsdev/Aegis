-- FOLDERS >
local Aegis = script.Parent.Parent

-- DEPENDENCIES >
local Types = require(Aegis.Types)
local Is = require(Aegis.Utility.Is)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- FUNCTIONS >
--[[
	## `Aegis.RegisterKey`
	A new key to register.
	#### Parameters
	- **key:** The key to index.
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
	```
]]
return function(key: Types.Key): Types.Key?
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
