# Creating keys

Now that you are familiar with keys, you might want to create a few keys yourself. Well no worries because Aegis has a `RegisterKey` function which allows you to create your own keys!

::: warning
You cannot have multiple keys with the same name.
:::

Let's create a key which will print out the instance's name.

::: code-group

```lua{8,12} [Test.luau]
local NamePrinter = {
	KeyName = "NamePrinter",
	ApplyKey = function(instance: Instance, value: any)
		print(instance.Name, value)
	end,
}

local Registered = Aegis.RegisterKey(NamePrinter)

Aegis.new("Frame", {
	Name = "LoadingBar",
	[Registered] = "something something",
})
```

```txt [Output]
LoadingBar something something
```

:::

Now, here's a thing. When you call `Aegis.RegisterKey` it does not add anything to the table, rather it returns the same table you created.

**_So why even register it?_**

You see, if you use just the table you created in 1 script, of course, you would be able to use it with no problems. However, you cannot access this key from another script. For this reason, we register the key so that we can access the key from anywhere!
