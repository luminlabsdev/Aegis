# Getting started

## Requirements

When using Aegis, we assume that:

- You're familiar with the lua/luau scripting language.
- You have a good understanding over the basics of Roblox features.

To know more about luau, visit [here](https://luau-lang.org/)
To know more about Roblox, visit [here](https://create.roblox.com/docs/tutorials)

## Installation

### Roblox

1. Navigate to the latest release of Aegis on Github, you can find that [here](https://github.com/lumin-dev/Aegis/releases/)
2. Download the `Standalone.rbxm` file
3. In Roblox Studio, right click where you want to import Aegis and click on **Insert from File** and choose the downloaded file.

### Wally

1. Add `lumin/aegis@^0.0.1` to your `wally.toml` file.
2. Run `wally install` and Aegis should be inside of your `/Packages` directory.

## Exported from Aegis

```lua
local Aegis = require(path.to.Aegis)

-- // Constructors
local new = Aegis.new
local state = Aegis.state
local spring = Aegis.spring

-- // Functions
local Key = Aegis.Key
local Update = Aegis.Update
local RegisterKey = Aegis.RegisterKey
local UnregisterKey = Aegis.UnregisterKey
```

Learn more: [API Reference](/api/)
