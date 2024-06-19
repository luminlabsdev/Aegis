# Introduction to keys

Aegis has some pre-made tables to be used as indexes of tables when creating/updating properties of instances. These are known as **keys**. With keys, you're able to modify properties or more specifically, do anything you want!

- List of keys provided by Aegis: [List of keys](/api/keys/#list-of-keys)

## Using keys

Aegis has a function to get a key; the `Key` function. A common key that you'll probably be using most of the time is the `Children` key. This key helps to define instances that will be under the main instance.

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

Other than this, you're also able to use nested tables for instances. This means, you'll be able to do this:

```lua{6-10}
	-- code
	[Children] = {
		{
			{
				{
					Aegis.new("Frame", {
						Name = "LoadingBar",
						Size = UDim2.new(0.75, 0, 0.05, 0),
						Parent = script.Parent,
					}),
				}
			}
		}
	}
```

That is mostly how you use keys! Obviously each key works in each way, but the `Children` key is the best way to familiarize yourself with keys!
