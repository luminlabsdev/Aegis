# `Events` key

Connects the specified events to the instance.

## Usage

The `Events` key accepts a dictionary where the index is the name of the event and the value will be a function that will be connected to the event.

```lua{4}
local Events = Aegis.Key("Events")

-- // snip
	[Events] = {
		MouseEnter = function()
			print("Mouse is hovering!")
		end,
	},
```
