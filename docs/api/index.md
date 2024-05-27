# Aegis

The top-level of Aegis table.

## Functions

### `Key`

Indexes a registered key.

**Parameters**

- **keyName:** `string`\
  The name of the key you want to index.

**Returns**

- **Key?**\
  The key object associated with the given key name. If the key does not exist, it returns `nil`.

**Example usage:**

```lua{1,4}
local Key = Aegis.Key

Aegis.new("Frame", {
	[Key("Children")] = { Instance }, -- indexing the `Children` key
})
```

### `RegisterKey`

Registers a new key.

**Parameters**

- **key:** `Key`\
  An Aegis key object to be registered.

**Returns**

- **Key?**\
  It registers the key and the returns the registered key. Else, it logs a warning if the key is invalid or already exists.

**Example usage:**

::: code-group

```lua{1,9} [Test.luau]
local Indexer = Aegis.RegisterKey({
	KeyName = "Indexer",
	ApplyKey = function(instance: Instance, value: any)
		print("This key was indexed!")
	end,
}) -- Registering a new key

Aegis.new("Frame", {
	[Indexer] = { Instance },
})
```

```txt [Output]
This key was indexed!
```

:::

### `new`

Creates a new instance with the specified `ClassName` and property table.

**Parameters**

- **className:** `string`\
  Class name of the instance to be created.
- **propertyTable:** `{ [any]: any }?`\
  Table of properties to be applied to the instance. **(Optional)**

**Returns**

- Instance?\
  The instance that was created. If it failed, it will give a warning.

**Example usage:**

```lua{1}
local LoadingBar = Aegis.new("Frame", {
	Name = "LoadingBar",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Size = UDim2.fromOffset(150, 150),
	Position = UDim2.fromScale(0.5, 0.5),
}) -- Creates a frame and returns it
```

### `state`

Creates a new state class.

**Parameters**

- **initialState:** `any`\
  The initial value to pass to the state.

- **protectType:** `boolean?`\
  Whether to protect the type of the state when changing values.

**Returns**

- **State**\
  The state class that was created.

**Example usage:**
::: code-group

```lua [Test.luau]
local MyState = Aegis.state(1)
print(MyState:Get())
MyState:Set(2)
print(MyState:Get())
```

```txt [Output]
1
2
```

:::

### `spring`

Creates a new spring class.
**Parameters**

- **springInfo:** `SpringInfo`\
  The information required to create the spring.

**Returns**

- **Spring?**\
  The spring class that was created.

**Example usage:**

```lua{3,10}
local MyState = Aegis.state(UDim2.new(0, 100, 0, 100))

local MySpring = Aegis.spring({
	Damping = 1,
	Frequency = 3,
	Velocity = 20,
	State = MyState,
})

MyState:Set(UDim2.new(0, 200, 0, 200)) -- The spring updates!
```
