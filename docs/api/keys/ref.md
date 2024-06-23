# `Ref` key

Sets the instance to the reference state.

## Usage

The `Ref` key accepts a [`State`](/api/state) class.

```lua
local Ref = Aegis.Key("Ref")
local RefState = Aegis.state() -- Leaving the initial value nil

Aegis.new("Frame", {
	[Ref] = RefState,
	Name = tostring(RefState:Get().BackgroundTransparency),
})
```
