# New instances

Aegis provides the `new` constructor to create new instances which includes the ability to apply properties and add children.

## Parameter order

1. Class name of the instance | `string`
2. Table of properties **(optional)** | `{ [any]: any }?`
3. Table of children instances **(optional)** | `{ [any]: Instance }?`

## Example usage

```lua:line-numbers
local Aegis = require(path.to.Aegis)
local new = Aegis.new

local MenuUI = new("ScreenGui", {
	Name = "MenuUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
	})
})
```

## Explanation

1. We call the `new` constructor and pass the class name of the instance as the first parameter.

```lua
new("ScreenGui")
```

2. The second parameter will be a table of properties which will be applied to the instance.

```lua{2-5}
new("ScreenGui",
	{
		Name = "MenuUI",
		IgnoreGuiInset = true,
		Parent = Player:WaitForChild("PlayerGui"),
	} -- property table
)
```

3. The third parameter will be a table of children instances which will be parented to the instance.

```lua:line-numbers=4 {5-11}
new("ScreenGui", {
	Name = "MenuUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
	})
})
```

:::tip
You can set a descendant's name quickly by passing the name of the instance as an index.

```lua{6}
new("ScreenGui", {
	Name = "MenuUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
	})
})
```

:::

And that is really how you create instances using Aegis!
