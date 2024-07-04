# Managing states

States are objects by which you can detect changes of values attached to them. You might find states not being worth it, but the more you get into intermediate programming, you will realize their significance.

- [State - Wikipedia](<https://en.wikipedia.org/wiki/State_(computer_science)>)

## Creating states

To create a state object, you have to call the `state` constructor.

### Parameter order

1. Value of the state **(optional)** | `any`
2. Should the type be protected **(optional)** | `boolean?`

### Example usage

```lua
local MyState = Aegis.state("Hello Aegis")
```

### Explanation

Here, the value of the state `MyState` is `"Hello Aegis"`. If you set the 2nd parameter to `false`, it will ignore the type of the state's value and set the new value.

## Getting the state's value

To get the state's current value, the `Get` method should be used.

```lua
print(MyState:Get()) -- Hello Aegis
```

## Setting a new value

To set a new value for the state, the `Set` method should be used and the new value should be passed as the 1st parameter.

```lua
print(`Before: {MyState:Get()}`) -- Hello Aegis
MyState:Set("Hello world!")
print(`After: {MyState:Get()}`) -- Hello world!
```

## Protecting type of state

As our above shown examples, the value of the state `MyState` is a `string`. When creating the state, you'll be given the option to protect the type of the state when changing the value.

**_(By default, it is set to `true`)_**

```lua [Test.luau]
local MyState = Aegis.state("Hello Aegis")
MyState:Set("Hello world") -- No problem
MyState:Set(420.69) -- Expected type (string); received (number) // [!code warning]
```

If you don't want to protect the type, you can put `false` in the 2nd parameter when you are creating the state.

```lua{1}
local MyState = Aegis.state("Hello Aegis", false) -- Putting `false` so that the type isn't protected when changing the value.
MyState:Set("Hello world") -- No problem
MyState:Set(420.69) -- All good!
```

## Listening to state changes

If you want to know **when** the value of the state changes, you'd need to use the `Listen` method. The only parameter the listener function accepts is function which will run when the value of the state changes.

### Parameter order of listener function

1. The new value of the state | `any`
2. The old value of the state | `any`

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

## Cleaning up states

Similar to how you destroy instances using the `Destroy` method, you use the `Destroy` method on the state as well.

```lua
MyState:Destroy()
```
