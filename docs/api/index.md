# Aegis

The top-level of Aegis table.

## Constructors

### `new`

Creates a new instance with the specified `ClassName` and property table.

#### Parameters

- **className:** `string`\
  Class name of the instance to be created.
- **propertyTable:** `{ [any]: any }?`\
  Table of properties to be applied to the instance. **(Optional)**

#### Returns

- **[Instance](https://create.roblox.com/docs/reference/engine/classes/Instance)?**\
  The instance that was created. If it failed, it will give a warning.

#### Usage:

```lua
local LoadingBar = Aegis.new("Frame", {
	Name = "LoadingBar",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Size = UDim2.fromOffset(150, 150),
	Position = UDim2.fromScale(0.5, 0.5),
}) -- Creates a frame and returns it
```

---

### `state`

Creates a new state class.

#### Parameters

- **initialState:** `any`\
  The initial value to pass to the state.

- **protectType:** `boolean?`\
  Whether to protect the type of the state when changing values.

#### Returns

- **[State](/api/state)**\
  The state class that was created.

---

### `spring`

Creates a new spring class.

#### Parameters

- **springInfo:** **[SpringInfo](/api/#springinfo)**\
  The information required to create the spring.

#### Returns

- **[Spring](/api/spring)?**\
  The spring class that was created.

## Functions

### `Update`

Update instance's properties.

#### Parameters

- **instance:** `Instance | { Instance }`\
  A singular instance or a table of instances
- **propertyTable:** `{ [any]: any }?`
  Table of properties to be applied to the specified instance(s).

#### Returns

- **[Instance](https://create.roblox.com/docs/reference/engine/classes/Instance)**\
  The specified instance(s).

---

### `Key`

Indexes a registered key.

#### Parameters

- **keyName:** `string`\
  The name of the key you want to index.

#### Returns

- **[Key](/api/keys/)?**\
  The key object associated with the given key name. If the key does not exist, it returns `nil`.

---

### `RegisterKey`

Registers a new key.

#### Parameters

- **key:** [Key](/api/keys/)\
  An Aegis key object to be registered.

#### Returns

- **[Key](/api/keys/)?**\
  It registers the key and the returns the registered key. Else, it logs a warning if the key is invalid or already exists.

---

### `UnregisterKey`

Removes a registered key.

#### Parameters

- **key:** `string |` [Key](/api/keys/)\
  The name of the key or the key itself to be removed.

#### Returns

- **nil**\
  Returns nil as the key is removed.

## Types

### `SpringInfo`

```lua
export type SpringInfo = {
	Damping: number?,
	Frequency: number?,
	State: State,
}
```

---

### `Key`

```lua
export type Key = {
	KeyName: string,
	ApplyKey: (instance: Instance, value: any) -> (),
}
```

---

### `State`

```lua
export type State = {
	ConstructorClass: "State",
	Get: (self: State) -> any,
	Set: (self: State, newValue: any) -> State,
	Listen: (self: State, fn: (oldValue: any, newValue: any) -> ()) -> State,
	Destroy: (self: State) -> (),
}
```

---

### `Spring`

```lua
export type Spring = {
	ConstructorClass: "Spring",
	Get: (self: Spring) -> any,
	Destroy: (self: Spring) -> (),
}
```

---

### `Animatable`

```lua
export type Animatable =
	boolean
	| number
	| BrickColor
	| CFrame
	| Vector3
	| Vector2
	| UDim2
	| UDim
	| Color3
	| Vector3int16
	| Vector2int16
	| ColorSequence
	| NumberSequence
	| NumberRange
	| Rect
```
