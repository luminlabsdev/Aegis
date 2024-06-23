# Updating properties

You have learnt how to create instances and apply your table of properties to the instance! But what if you want to update the properties of an existing instance? No worries! In this case, the `Update` function is here to help!

Order of parameters in `Update` function:

- **1st parameter**: `Instance` or `{ Instance }`
- **2nd parameter**: Table of properties **(optional)**

Example usage:

```lua{5-8}
local ExistingInstance = PlayerGui:WaitForChild("LoadingGUI")

-- code

Aegis.Update(ExistingInstance, {
	Name = "MenuGUI",
	IgnoreGuiInset = true,
})
```

Here, the first parameter of the `Update` function is the instance whose properties you want to update.

<img src="../images/update-props.png" width="120%"/>

Now, what if you want to update the same properties for some instances? Well, no worries! You can even use the 1st parameter of the `Update` function as a table of instances!

Example usage:

```lua{2}
Aegis.Update(
	{ Instance1, Instance2, Instance3 },
	{
		Name = "Gui",
		IgnoreGuiInset = true,
	}
)
```

> [!WARNING]
> The formatting shown above in the code is bad practice. It was only done to separate the line being explained from the other lines.
