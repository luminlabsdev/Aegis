# Managing states

According to the Wikipedia, [_"A system is described as **stateful** if it is designed to remember preceding events or user interactions;[1] the remembered information is called the **state of the system**."_](<https://en.wikipedia.org/wiki/State_(computer_science)>)

---

Simply said, states are objects by which you can detect changes of values attached to them. You might find states not being worth it, but the more you get into intermediate programming, you will realize their significance.

## Creating states

Creating states using Aegis is easy. You have to call the `state` constructor. Example usage:

```lua
local MyState = Aegis.state()
```

This is a blank state. Order of parameters:

- **1st parameter**: Value of the state
- **2nd parameter**: Whether the type of the state will be protected while changing the value.

Example usage:

```lua
local MyState = Aegis.state("Hello Aegis", true)
```

Here, the value of the state `MyState` is `"Hello Aegis"`. In the code, it doesn't matter if you set the 2nd parameter to `true` because it defaults to `true` either ways.

## Getting the current value

To get the current value of the state, the `Get` method should be used.
::: code-group

```lua [Test.luau]
print(MyState:Get())
```

```txt [Output]
Hello Aegis
```

:::

## Setting a new value

To set a new value for the state, the `Set` method should be used.

::: code-group

```lua [Test.luau]
print(`Before: {MyState:Get()}`)
MyState:Set("Hello world!")
print(`After: {MyState:Get()}`)
```

```txt [Output]
Before: Hello Aegis
After: Hello world!
```

:::

## Protecting type of state

As our above shown examples, the value of the state `MyState` is a `string`. When creating the state, you'll be given the option to protect the type of the state when changing the value or not.

**_By default, it is set to `true`_**

::: code-group

```lua [Test.luau]
local MyState = Aegis.state("Hello Aegis")
MyState:Set("Hello world") -- No problem
MyState:Set(420.69) -- Warning!
```

```txt [Output]
Expected type (string); received (number)
```

If you don't want to protect the type, you have to put `false` in the 2nd parameter when you are creating the state.

```lua
local MyState = Aegis.state("Hello Aegis", false) -- Putting `false` so that the type isn't protected when changing the value.
MyState:Set("Hello world") -- No problem
MyState:Set(420.69) -- All good!
```

## Listening to state changes

Setting a new value of the state and getting is all good, but there are times you need to know **when** the value changes.

For this, you'd use the `Listen` method. Example usage:

::: code-group

```lua [Test.luau]
MyState:Listen(function(newValue: string, oldValue: string)
	print(`Before: {oldValue}`)
	print(`After: {newValue}`)
	print("-----")
end)

MyState:Set("hi fellow developers")
MyState:Set("how are you guys")
```

```txt [Output]
Before: Hello Aegis
After: hi fellow developers
-----
Before: hi fellow developers
After: how are you guys
-----
```

:::
::: info
The 1st parameter of the attached listener function is the new value
The 2nd parameter of the attached listener function is the old value
:::

## Cleaning up states

Cleaning up/destroying states is pretty easy. Similar to how you destroy instances using the `Destroy` method, you use the `Destroy` method on the state as well.

```lua
MyState:Destroy()
```

::: info
When you do this, all the values, indexes and elements inside the state (table) will be cleared and the state's metatable will be removed.
:::
