# `Children` key

Adds descendant instances to parent instance.

## Usage

The `Children` key can be defined as a table of instances as the following:

```lua{4}
local Children = Aegis.Key("Children")

-- // snip
	[Children] = {
		Aegis.new(...),
		...Instance,
	},
```

Again, you can define the `Children` key's value to be only a singular instance.

```lua
-- // snip
	[Children] = Aegis.new(...),
```
