# `Changes` key

Tracks changes of a property change of the instance.

## Usage

The `Changes` key accepts a dictionary where the index is the name of the property and the value will be a function that will be fired when the property is changed.

```lua
local Changes = Aegis.Key("Changes")

-- // snip
	[Changes] = {
		Visible = function()
			print("Visible property has changed")
		end,
	},
```
