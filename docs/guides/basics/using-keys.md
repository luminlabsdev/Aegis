# Introduction to keys

Aegis has a special system known as **"keys"**. With keys, you can modify properties, connect events, attach tags and attributes and much more!

- List of default Aegis keys: [List of keys](/api/keys/#list-of-keys)

## Using keys

Aegis has a function to get a key `Aegis.Key("KeyName")`. A common key that you'll most probably be using is the `Children` key. This key helps to define instances that will be under the main instance.

::: warning
Keys should only be used when using the `Aegis.new()` constructor.
:::

Let's learn by using the `Children` key.

```lua{5}
local Children = Aegis.Key("Children")

Aegis.new("ScreenGui", {
	Name = "MenuUI",
	[Children] = Aegis.new("Frame", {
		Name = "LoadingBar",
		Size = UDim2.new(0.75, 0, 0.05, 0),
		Parent = script.Parent,
	}),
)
```

That's cool and all, but you might ask,

**Q:** "Do I need to define the key each time I want to add a child instance?"

---

**A:** The answer is no! The `Children` key accepts both a singular instance and a table of instances so you could just do

```lua
	[Children] = {
		Aegis.new("Frame", {
			Name = "LoadingBar",
			Size = UDim2.new(0.75, 0, 0.05, 0),
			Parent = script.Parent,
		}),
		Aegis.new("Frame", {
			Name = "LoadingBar",
			Size = UDim2.new(0.75, 0, 0.05, 0),
			Parent = script.Parent,
		}),
	}
```

That is mostly how you use keys! Obviously each key works in each way, but the `Children` key is the best way to familiarize yourself with keys!
