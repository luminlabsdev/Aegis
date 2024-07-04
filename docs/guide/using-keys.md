# Introduction to Keys

Aegis provides some predefined tables that serve as keys for indexing and modifying properties of instances. These are known as keys. By using keys, you can effectively customize properties or perform various operations on your instances.

- [List of default keys](/api/keys/#list-of-default-keys)

## Parameter order

1. Name of the key | `string`

## Example usage

By using the `Key` function, you can grab the key. Let's learn by using the [`Events`](/api/keys/events) key.

```lua{2,13-17}
local new = Aegis.new
local Events = Aegis.Key("Events")

new("ScreenGui", {
	Name = "MenuUI",
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	InteractButton = new("TextButton", {
		Size = UDim2.new(0.1, 0, 0.075, 0),
		Text = "Interact",
		TextScaled = true,

		[Events] = {
			MouseButton1Click = function()
				print("Clicked!")
			end,
		}
	})
})
```

## Explanation

The `Events` key is used to bind an event to the instance being specified the key. Since the `InteractButton` is a `TextButton`, it has a `MouseButton1Click` event that can be connected using the key.

1. We define the `Events` key as an index in the table.

```lua
		[Events] = {}
```

2. The `Events` key accepts a table of events where the index is the name of the event and the value of the index is a function to be connected to the event. In this case, the event name is `MouseButton1Click` and the function defined to it is the function that will be connected to the event.

```lua
		{ MouseButton1Click = function() end }
```

---

That is mostly how you use keys! Obviously each key works in each way, but the `Children` key is the best way to familiarize yourself with keys!
