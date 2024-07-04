# State

The state class of Aegis.

- Visit the tutorial [here](/guide/managing-states)

## Methods

### `Get`

Returns the current value of the state.

#### Parameters

- `nil`

#### Returns

- `any`\
  The value of the state.

### `Set`

Sets a new value of the state.

#### Parameters

- **newValue:** `any`\
  The new value to set for the state.

#### Returns

- **[State](/api/state)**\
  Returns the state itself.

### `Listen`

Listens to the value change.

#### Parameters

- **listenerFunction**: `(newValue: any, oldValue: any) -> ()`\
  The first parameter of the function will be the new value and the second parameter will be the old value.

#### Returns

- **[State](/api/state)**\
  Returns the state itself.
