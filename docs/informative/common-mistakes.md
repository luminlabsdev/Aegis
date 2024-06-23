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

If you want us to add more common mistakes here in this section, reply at our [DevForum post](https://devforum.roblox.com/t/2985522/1) or at our [Overall discussion on GitHub](about/blank)
