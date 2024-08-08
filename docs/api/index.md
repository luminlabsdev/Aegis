# Aegis

The top-level of Aegis table.

## Constructors

### `new`

Creates a new instance with the specified `ClassName` and property table.

#### Parameters

- **classOrComponent:** **[ClassName](/api/#classname) | [Component](/api/#component)**\
  The class name of the instance to create, or a provided component
- **properties:** **[Properties](/api/#properties)**\
  Properties to be passed to the `classOrComponent` created **(Optional)**
- **children:** **[Children](/api/#children)**\
  Children to be parented to `classOrComponent` **(Optional)**

#### Returns

- **[Instance](https://create.roblox.com/docs/reference/engine/classes/Instance)?**\
  The instance that was created. If it failed, it will give a warning.

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

### `compute`

Creates a new compute object.

#### Parameters

- **processor:** `(get: (Constructor | any) -> ()) -> ()`\
  The main function which will be run everytime the value changes

- **dependencies:** `{ State | Spring | Constructor }?`\
  A table of dependencies whose values will be listened to

#### Returns

- **[Compute](/api/compute)**\
  The compute object that was created.

## Functions

### `Update`

Update instance's properties.

#### Parameters

- **instance:** `Instance`\
  The instance to update the properties of.
- **properties:** **[Properties](/api/#properties)**\
  Properties to be applied to the instance.
- **children:** **[Children](/api/#children)**\
  Children to be parented to the instance.

#### Returns

- **[Instance](https://create.roblox.com/docs/reference/engine/classes/Instance)**\
  The instance provided with updated properties and children

---

### `Key`

Indexes a registered key.

#### Parameters

- **name:** `string`\
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

- **key:** `string`\
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
	ConstructorClass: "state",
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
	ConstructorClass: "spring",
	Get: (self: Spring) -> any,
	Destroy: (self: Spring) -> (),
}
```

---

### `Compute`

```lua
export type Compute = {
	ConstructorClass: "compute",
	Get: (self: Compute) -> any,
	Destroy: (self: Compute) -> (),
}
```

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

### `DefaultKeys`

```lua
export type DefaultKeys = "Ref" | "Events" | "Changes" | "Cleanup" | "Attributes" | "Tags"
```

### `Component`

```lua
export type Component<T> = (props: T) -> Instance
```