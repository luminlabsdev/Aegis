-- FOLDERS >
local Aegis = script.Parent.Parent

-- DEPENDENCIES >
local Types = require(Aegis.Types)
local Storage = require(Aegis.Runtime.Storage)
local Debugger = require(Aegis.Utility.Debugger)

-- FUNCTIONS >
--[[
	## `Aegis.Key`
	The key to index.
	#### Parameters
	- **keyName:** The name of the key to index.
	#### Returns
	- [`Key?`](https://lumin-dev.github.io/Aegis/api/keys/) | [`Tutorial`](https://lumin-dev.github.io/Aegis/guide/using-keys)
	#### Example
	```luau
	local Events = Aegis.Key("Events")

	new("ScreenGui", {
		Name = "MenuUI",
		Parent = Player:WaitForChild("PlayerGui"),
	}, {
		InteractButton = new("TextButton", {
			Size = UDim2.new(0.1, 0, 0.075, 0),
			Text = "Interact",
			TextScaled = true,

			[Events] = {
				MouseButton1Click = function()
					print("Clicked!")
				end,
			}
		})
	})
	```
]]
return function(name: Types.DefaultKeys | string): Types.Key
	local FoundKey = Storage.RegisteredKeys[name]

	if not FoundKey then
		Debugger.Error("KeyNotFound", name)
	end

	return FoundKey
end
