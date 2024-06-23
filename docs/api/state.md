# State

The state class of Aegis.

## Methods

### `Get`

Returns the current value of the state.

#### Parameters

- `nil`

#### Returns

- `any`\
  The value of the state.

#### Usage:

::: code-group

```lua{2} [Test.luau]
local MyState = Aegis.state("Hello Aegis")
print(MyState:Get())
```

```txt [Output]
Hello Aegis
```

:::

### `Set`

Sets a new value of the state.

#### Parameters

- **newValue:** `any`\
  The new value to set for the state.

#### Returns

- **[State](/api/state)**\
  Returns the state itself.

#### Usage:

```lua{2}
local MyState = Aegis.state("Hello Aegis")
MyState:Set("Hello World") -- new value
```

### `Listen`

Listens to the value change.

#### Parameters

- **listenerFunction**: `(newValue: any, oldValue: any) -> ()`\
  The first parameter of the function will be the new value and the second parameter will be the old value.

#### Returns

- **[State](/api/state)**\
  Returns the state itself.

#### Usage:

::: code-group

```lua{3} [Test.luau]
local MyState = Aegis.state("Hello Aegis")

MyState:Listen(function(newValue, oldValue)
	print(newValue, oldValue)
end)

MyState:Set("Hello World")
```

```txt [Output]
Hello World Hello Aegis
```
