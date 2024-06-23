# `Tags` key

Specifies tags to the instance.

## Usage

The `Tags` key accepts a table where the value will be the tag attached to the instance.

```lua
local Tags = Aegis.Key("Tags")

-- // snip
	[Tags] = { "UI", "random_tag" },
```
