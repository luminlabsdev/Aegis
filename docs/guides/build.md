# Building instances

The most common way of creating instances is by calling `Instance.new(className)` on it; and to change the property, you just do `CreatedInstance.Property = Value`. This can get very annoying if you have a lot of instances or a whole lot of properties to change, just calling the instance name repeatedly.

This is where `Aegis.Build` comes in! You just need to call `Aegis.Build` once & pass the 1st argument as he ClassName and the 2nd argument will be a function which returns a table of the instance's properties. But why a function? You see, the first parameter that you get from the function is a table which returns multiple values. One of those, is the instance itself which is used to access the instance itself inside the scope.

Here is a code example:
```lua
local Aegis = require(game:GetService("ReplicatedStorage").Packages.Aegis)

local NewUI = Aegis.Build("ScreenGui", function(uiTab: {})
	return {
		Name = "NewUI",
		-- property name: value
		-- ...
	}
end)
```