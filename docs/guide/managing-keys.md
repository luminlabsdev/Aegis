# Managing keys

Aegis provides you with the ability to manage keys by adding or removing keys.

## Creating keys

To create your own keys, Aegis provides the `RegisterKey` function.

### Parameter order

1. Key table to register | [`Key`](/api/#key-1)
   - **KeyName**: The name of the key
   - **ApplyKey**: The main function of the key.

::: warning
Every `KeyName` must be unique.
:::

### Example usage

Let's create a key which will print out the instance's name.

```lua{1-6,10}
local NamePrinterKey = Aegis.RegisterKey({
	KeyName = "NamePrinter",
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
})

Aegis.new("Frame", {
	Name = "UI",
	[NamePrinterKey] = "is made by Aegis!", -- UI is made by Aegis!
})
```

### Explanation

1. We first register the key table where the two values are `KeyName` which will be a `string`.

```lua
local NamePrinterKey = Aegis.RegisterKey({
	KeyName = "NamePrinter",
})
```

2. Now, we define the `ApplyKey` function inside the key table, which does the actual work.

```lua
local NamePrinterKey = Aegis.RegisterKey({
	KeyName = "NamePrinter",
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
})
```

::: info
The `ApplyKey` function of the table will provide you 2 things, the instance you're running the key on and the value you defined to it.
:::

3. Finally, we define the key normally as an index of the property table and assign it its respective value.

```lua:line-numbers=8{3}
Aegis.new("Frame", {
	Name = "UI",
	[NamePrinterKey] = "is made by Aegis!", -- UI is made by Aegis!
})
```

---

::: tip
The `RegisterKey` function registers the key you created so that you can access it from other code as well.
:::

## Removing keys

For this, you'd use the `UnregisterKey` function.

### Parameter order

1. Name of the key to be removed | `string`

You pass the name of the key to the function. Example usage:

### Example usage

```lua
-- We created this key in the #creating-keys section
local NamePrinterKey = Aegis.RegisterKey({
	KeyName = "NamePrinter",
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
})

Aegis.new("Frame", {
	Name = "UI",
	[NamePrinterKey] = "is made by Aegis!", -- UI is made by Aegis!
})

Aegis.UnregisterKey("NamePrinter") -- Now, we are removing it. // [!code focus]
```

### Explanation

- Basically you pass in the name of the key. If it finds the key, it will remove it. Otherwise, Aegis will throw a warning.
