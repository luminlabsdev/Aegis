# Introduction to Aegis services

Similar to keys, aegis services are another one of Aegis' special systems with which, you can get more control over your code and give your instances more functionality!

Here's something fantastic! When defining properties using the `.new` constructor, if you define a service class as the value of the property, (if the value is valid) then the property of the instance will read the value of the service class!

The `State` service can give us a good example:

---

1. Creating a new `State` class to listen to new values

```lua{4}
local NewState = Aegis.state(false)

local MyValue = Aegis.new("BoolValue", {
	Value = NewState,
})
```

2. Now, calling the Listen method of the created state class and attaching a function to it.

```lua{2}
NewState:Listen(function(newValue: boolean, oldValue: boolean)
	print(MyValue.Value) -- printing the bool value's value
end)
```

3. And finally setting a new value

```lua
NewState:Set(true)
```

At last, our output should come out as `true`

---

Every service class has a common method.

- `Class:Get()`

Since every service class has the `:Get` method, when applying properties, it gets the value.

> [!TIP]
> There's actually a common function as well `(Class._initservice)`, however it is used internally and should not be used externally.
