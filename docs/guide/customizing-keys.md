# Customizing keys

Keys are customizable. As Aegis provides you with the ability to modify keys however you want, it is possible to create your own keys as well as remove any!

## Creating keys

Now that you're familiar with how keys work, you might think of how you can create your own keys. No matter, because Aegis has a `RegisterKey` function which allows you to create your own keys!

> [!WARNING]
> You cannot have multiple keys with the same name.

Let's create a key which will print out the instance's name.

::: code-group

```lua{8,12} [Test.luau]
local NamePrinter = {
	KeyName = "NamePrinter",
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
}

local NamePrinterKey = Aegis.RegisterKey(NamePrinter)

Aegis.new("Frame", {
	Name = "LoadingBar",
	[NamePrinterKey] = "something something",
})
```

```txt [Output]
LoadingBar something something
```

:::

The `RegisterKey` accepts a table. The table will contain 2 values:

- **KeyName**: The name of the key **(has to be unique)**
- **ApplyKey**: The main function of the key.

---

The `ApplyKey` function of the table will provide you 2 things, the instance you're running the key on and the value you defined to it. In our case, it is this:

```lua
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
```

Now, here's a thing. When you call `Aegis.RegisterKey` it does not add anything to the table, rather it returns the same table you created.

---

#### So why even register it?

You see, if you use just the table you created in 1 script, of course, you would be able to use it with no problems. However, you cannot access this key from another script. For this reason, we register the key so that we can access the key from anywhere!

## Removing keys

Removing keys is just as simple. For this, you'd use the `UnregisterKey` function of Aegis. Order of parameters:

- **1st parameter**: key to be removed

You pass the name of the key to the function. Example usage:

```lua
Aegis.UnregisterKey("NamePrinter") -- added to the code in Creating Keys section
```

And the key will be removed!

---

But let's say you have the key table and not just the string. So to remove it, we'd have to pass in the `KeyName` property of the key instead of just the key; but that's what you'd think!

Aegis has made it easier for you! You can pass in the key table and Aegis will still remove the key for you!

```lua
Aegis.UnregisterKey(NamePrinterKey) -- added to the code in Creating Keys section
```

Keys are pretty special and you can control and modify them any way you want! Go crazy with them!
