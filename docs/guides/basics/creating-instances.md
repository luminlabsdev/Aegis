# Creating instances

To create a new instance using Aegis, there's the `new` constructor! The first parameter of the constructor is the class name of the instances, while the second argument will be a table of properties. Here's how you would use it:

```lua
local Aegis = require(path.to.Aegis)

--// snip

Aegis.new("Frame", {
	Name = "LoadingBar",
	Size = UDim2.new(0.75, 0, 0.05, 0),
	Parent = script.Parent,
	...
})
```

Let's take a look at the code; step-by-step:

---

1. We call the `.new` constructor of Aegis and pass the class name of the instance we want to create; in this case, a frame.

```lua
Aegis.new("Frame" --[[ ClassName ]])
```

2. The second argument will be a table of properties which we will define to the instance.

```lua{2-6}
Aegis.new("Frame",
	{
		Name = "LoadingBar",
		Size = UDim2.new(0.75, 0, 0.05, 0),
		Parent = script.Parent,
	} -- property table
)
```

And that is really how you create instances using Aegis!
