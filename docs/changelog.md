# Changelog

This is a changelog which is changed every update, and we follow semver.

## [0.2.3](https://github.com/lumin-dev/Aegis/releases/tag/v0.2.3)

### Fixes

- Fixes types not being inferenced when creating components
- Fixes docs not being up-to-date with code
- Enforces better code practices in some areas
- Adds a `Component<T>` type
- Improves Git workflows to automatically announce new updates

## [0.2.2](https://github.com/lumin-dev/Aegis/releases/tag/v0.2.2)

### Fixes

- Fixed infinite error on spring destruction bug ( [#5 by @dazscripts](https://github.com/lumin-dev/Aegis/pull/5) )

## [0.2.1](https://github.com/lumin-dev/Aegis/releases/tag/v0.2.1)

### Improvements

- Adds 2 new exported types
- Adds documentation for components
- Adds general component support
- Adds `props.Children` when using component children
- Reformats code for better comment support
- Fix documentation inconsistencies

## [0.2.0](https://github.com/lumin-dev/Aegis/releases/tag/v0.2.0)

### Improvements

- Added `compute` constructor.
- Added `childrenTable` parameter for `new` constructor
- Added `Spring:Destroy()` method.
- `State:Listen(...)` now returns a function to disconnect the listener.
- Exported more types.
- Improved documentation

### Fixes

- Fixed `State` object's listener function's value order being typed wrong.

### Removed

- `Children` key.
- Removed the ability to pass key tables in the `UnregisterKey` function.
- Removed support for nested tables.

## [0.1.0](https://github.com/lumin-dev/Aegis/releases/tag/v0.1.0)

### Improvements

- Added `Aegis.Update` function.
- Added `Aegis.UnregisterKey` function.
- Added `Cleanup` key.
- Added restriction for `table` types for states.
- Added nested table support for `Children` key.
- Added more animatable types: `boolean`, `BrickColor`, `CFrame`, `Vector3int16`, `Vector2int16`, `NumberSequence`, `NumberRange` and `Rect`.
- Improved `Aegis.Key` function.
- Reduced spring memory usage
- Types are now properly exported.
- Made documentation a lot better with in-depth explanation, FAQ, comparisons and tutorials.

### Fixes

- Fixed `Color3` spring animation.
- Fixed issue with `Children` key not parenting instances properly.

### Removed

- `SpringInfo.Velocity`

## [0.0.3](https://github.com/lumin-dev/Aegis/releases/tag/v0.0.3)

### Improvements

- Fix documentation

## [0.0.2](https://github.com/lumin-dev/Aegis/releases/tag/v0.0.2)

### Improvements

- Fixed documentation page and wally package

## [0.0.1](https://github.com/lumin-dev/Aegis/releases/tag/v0.0.1)

- Released [Aegis](/)!
