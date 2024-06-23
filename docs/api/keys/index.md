# Key

Modify instances' properties to a great extent.

## Properties

- **KeyName:** `string`\
  Name of the key **_(has to be unique)_**

## Functions

- **ApplyKey:** `(instance: Instance, value: any) -> ()`\
  This function will be called when the properties of the instance is applied.

## List of default keys

|                Key                 | Description                                          |
| :--------------------------------: | :--------------------------------------------------- |
|   [Children](/api/keys/children)   | Adds descendant instances to parent instance.        |
|        [Ref](/api/keys/ref)        | Sets the instance to the reference state.            |
|     [Events](/api/keys/events)     | Connects the specified events to the instance.       |
|    [Changes](/api/keys/changes)    | Tracks changes of a property change of the instance. |
|    [Cleanup](/api/keys/cleanup)    | Cleans up the following things provided to the key.  |
| [Attributes](/api/keys/attributes) | Creates attributes of the instance.                  |
|       [Tags](/api/keys/tags)       | Specifies tags to the instance.                      |
