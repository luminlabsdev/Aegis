# Creating instances

To create a new instance using Aegis, there's the `new` constructor!

Order of parameters in `new` constructor:

- **1st parameter**: Class name of the instance
- **2nd parameter**: Table of properties **(optional)**

Example usage:

```lua
local Aegis = require(path.to.Aegis)

local MenuUI = Aegis.new("ScreenGui", {
	Name = "MenuGUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
	...
})
```

Let's take a look at the code; step-by-step:

---

1. We call the `new` constructor of Aegis and pass the class name of the instance we want to create; in this case, a `ScreenGui`.

```lua
Aegis.new("ScreenGui" --[[ ClassName ]])
```

2. The second argument will be the table of properties which will be applied to the instance.

```lua{2-5}
Aegis.new("ScreenGui",
	{
		Name = "MenuGUI",
		IgnoreGuiInset = true,
		Parent = Player:WaitForChild("PlayerGui"),
	} -- property table
)
```

<img src="../images/instance-props.png" width="60%"/>

And that is really how you create instances using Aegis!
