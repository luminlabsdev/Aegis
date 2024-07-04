# Common mistakes

There are some common mistakes that many developers do when using Aegis. These common mistakes are listed below:

---

## Using `Get` on state/spring

If you try to follow the values of the state or spring, you'd only use the following state. But many accidentally use the `Get` method, which only gets the value of the constructor at **that** specific moment.

- Wrong:

```lua{2}
local MyState = Aegis.state(0)
local NumVal = Aegis.new("NumberValue", { Value = MyState:Get() })

MyState:Set(1)
print(NumVal.Value) -- 0
```

- Correct:

```lua{2}
local MyState = Aegis.state(0)
local NumVal = Aegis.new("NumberValue", { Value = MyState })

MyState:Set(1)
print(NumVal.Value) -- 1
```

---

## Using `Get` inside the `compute` processor function

If you try to use the `Get` method of any state, spring or any compute objects inside the processor function of `compute`, you'd not get your ideal result.

- Wrong:

```lua
local MyState = Aegis.state(0)
local MyCompute = Aegis.compute(function()
	return MyState:Get()
end, { MyState })

print(MyCompute) -- 0
MyState:Set(1)
print(MyCompute) -- 0
```

This happens because you're returning the constant value of the state which is `0`. You're trying to get the value of the state at that specific moment which is the problem. That's why, even though your state's value changes, the result of the compute stays the same. To fix this problem, you should use the `get` function provided as the 1st parameter of the compute's processor function.

- Correct:

```lua
local MyState = Aegis.state(0)
local MyCompute = Aegis.compute(function(get)
	return get(MyState)
end, { MyState })

print(MyCompute) -- 0
MyState:Set(1)
print(MyCompute) -- 1
```

The `get` function gets the value of the state passed into it **when** the compute state changes; meaning it will get the changed value!
