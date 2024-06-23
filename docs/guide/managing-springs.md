# Managing springs

Using springs, you can make an animated effect of any element; name it position, number, vector, boolean etc.

## Creating springs

To create a spring, you use the `spring` constructor. Example usage:

```lua
local MySpring = Aegis.spring()
```

The above code won't work as the spring requires a [state](/api/state) to work. To define a state, you define the `State` of the `SpringInfo` and set it to an existing state.

```lua
local MyState = Aegis.state(Vector3.new(0, 5, 0))
local CustomSpring = Aegis.spring({ State = MyState })
```

Besides the state, there are some other values you can set. Check the [SpringInfo](/api/springinfo) for more info.

## Setting spring to instance

To attach your created spring to an instance, you have to set it via the `new` constructor / `Update` function. Example usage:

```lua{5}
local AegisPart = Aegis.new("Part", {
	Size = Vector3.new(4, 4, 4),
	Anchored = true,
	Parent = workspace,
	Position = CustomSpring,
})
```

Now that you have set the part's position to follow the spring's value, every time you change the value of the state, the part will magically follow the value of the spring.

```lua
MyState:Set(Vector3.new(0, math.random(5, 10), 0))
```

#### [INPUT VIDEO OF THE SPRING HERE]

## Customizing the spring

There are 2 customizable options for the spring; damping and frequency.

Damping: [_"Damping is the loss of energy of an oscillating system by dissipation."_](https://en.wikipedia.org/wiki/Damping)

Frequency: [_"Frequency is the number of occurences of a repeating event per unit time."_](https://en.wikipedia.org/wiki/Frequency)

---

Damping and frequency are part of the `SpringInfo`. You can customize them by changing their values.

```lua
local CustomSpring = Aegis.spring({
	State = MyState,
	Damping = 0.3,
	Frequency = 1.5,
})
```

## Getting the value of the spring

Similar to [states](/api/state), you use the `Get` method to get the current state of the spring.
Example usage isn't provided since the value of spring always keeps on changing.

## Cleaning up springs

Similar to [states](/api/state), you use the `Destroy` method to clean up the spring.

```lua
CustomSpring:Destroy()
```

> [!NOTE] INFO
> When you do this, all the values, indexes and elements inside the state (table) will be cleared, connections will be disconnected and the spring's metatable will be removed.
