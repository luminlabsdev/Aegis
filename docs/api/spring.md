# Spring

The spring class of Aegis.

## Methods

### `Get`

Returns the current position of the spring.

#### Parameters

- `nil`

#### Returns

- **Position**: [Animatable](/api/#animatable)

#### Usage:

```lua{2,10}
local MyState = Aegis.state(UDim2.new(0, 100, 0, 100))
local MySpring = Aegis.spring({
	Damping = 1,
	Frequency = 3,
	Velocity = 20,
	State = MyState,
})

Aegis.new("Frame", {
	Size = MySpring,
})

MyState:Set(UDim2.new(0, 200, 0, 200))
print(MySpring:Get()) -- output will be Somewhere within the 100-200 value range
```

- [Tutorial](/guide/managing-springs)
