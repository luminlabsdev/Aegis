# `Attributes` key

Creates attributes of the instance.

## Usage

The `Attributes` key accepts a dictionary where the index is the name of the attribute and the value will be the value of the attribute.

```lua{4}
local Attributes = Aegis.Key("Attributes")

-- // snip
	[Attributes] = {
		UI = true, -- Creates an attribute named `UI` whose value will be `true`
	},
```
