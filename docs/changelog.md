# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Migrates to new github actions and changelog format

### Added

- Added Rokit as the default package manager

## [0.2.3] - 2024-07-25

### Added

- Adds a `Component<T>` type

### Changed

- Enforces better code practices in some areas

### Fixed

- Fixes types not being inferenced when creating components
- Fixes docs not being up-to-date with code

## [0.2.2] - 2024-07-12

### Fixed

- Fixed infinite error on spring destruction bug ( [#5 by @dazscripts](https://github.com/lumin-dev/Aegis/pull/5) )

## [0.2.1] - 2024-07-06

### Added

- Adds 2 new exported types
- Adds documentation for components
- Adds general component support
- Adds `props.Children` when using component children

### Changed

- Reformats code for better comment support

### Fixed

- Fix documentation inconsistencies

## [0.2.0] - 2024-07-04

### Added

- Added `compute` constructor.
- Added `childrenTable` parameter for `new` constructor
- Added `Spring:Destroy()` method.
- `State:Listen(...)` now returns a function to disconnect the listener.

### Changed

- Exported more types.
- Improved documentation

### Fixed

- Fixed `State` object's listener function's value order being typed wrong.

### Removed

- `Children` key.
- Removed the ability to pass key tables in the `UnregisterKey` function.
- Removed support for nested tables.

## [0.1.0] - 2024-06-23

### Added

- Added `Aegis.Update` function.
- Added `Aegis.UnregisterKey` function.
- Added `Cleanup` key.
- Added restriction for `table` types for states.
- Added nested table support for `Children` key.
- Added more animatable types: `boolean`, `BrickColor`, `CFrame`, `Vector3int16`, `Vector2int16`, `NumberSequence`, `NumberRange` and `Rect`.

### Changed

- Improved `Aegis.Key` function.
- Reduced spring memory usage
- Made documentation a lot better with in-depth explanation, FAQ, comparisons and tutorials.

### Fixed

- Types are now properly exported.
- Fixed `Color3` spring animation.
- Fixed issue with `Children` key not parenting instances properly.

### Removed

- `SpringInfo.Velocity`

## [0.0.3] - 2024-05-27

### Fixed

- Fix documentation

## [0.0.2] - 2024-05-27

### Fixed

- Fixed documentation page and wally package

## [0.0.1] - 2024-05-27

- Released [Aegis](/)!
