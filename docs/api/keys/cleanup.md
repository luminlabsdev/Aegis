# `Cleanup` key

Cleans up the following things provided to the key.

## Usage

The `Cleanup` key can accept a singular data type or a table of elements to be cleaned up when the parent instance gets destroyed.

```lua
local Cleanup = Aegis.Key("Cleanup")

local State = Aegis.State(123)
local Spring = Aegis.Spring({ State = State })

-- // snip
	[Cleanup] = { State, Spring }
```

---

```lua
-- // snip
	[Cleanup] = State,
```
