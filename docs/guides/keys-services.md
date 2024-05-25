# Keys and Services

Keys and Services are the foundation of Aegis; the pillars upon which Aegis was developed! Keys and Services are used to manage instances both on a low & high scale.

## Keys

Keys are special, they are used when giving the instances their respective properties. Here's how you use a key:

```lua
local Aegis = require(path.to.Aegis)

--snip
	[Aegis.Key("KeyName")] = value

```

- To learn how to use keys, visit: [Using keys](/guides/using-keys)
- To learn how to create your own keys, visit: TODO
- To learn about the properties of a key, visit: TODO

## Services

Aegis services allow developers to have a greater range of support over instances and control them however they want.

Every service has a common function `:Get()`. This **common function** allows developers to get the value of a created service class at the exact runtime!

- To know how to use Aegis services, visit: TODO
- To learn about the properties of each Aegis service, visit: TODO
