# Managing computes

The Wikipedia provides a solid explanation on computation: **_[A computation is any type of arithmetic or non-arithmetic calculation that is well-defined.](https://en.wikipedia.org/wiki/Computation)_**

In this case, a `compute` is a constructor that runs every time a value of a dependency changes.

## Creating a `compute` object

To create a compute object, you have to call the `compute` constructor.

### Parameter order

1. The processor function which will be run everytime the value changes | `(value: Types.Constructor | any) -> ()`
2. A table of dependencies whose values will be listened to | `{ Types.State | Types.Spring | Types.Constructor }?`

### Example usage

```lua
local compute = Aegis.compute

local CalculateCoins = compute(function()
	return 100 - 50
end)
```

### Explanation

Here, we return the value of `100 - 50` which is `50`.

## Getting the value of compute

To get the returned value of a compute object, we use the `Get` method.

```lua
print(CalculateCoins:Get()) -- 50
```

## Adding dependencies

**In the `compute` constructor**, dependencies are a table of state objects whose values will be listened to when they change.

### Example usage

```lua
local state = Aegis.state
local compute = Aegis.compute

local Coins = state(100) -- State object for coins // [!code ++]
local Price = state(50) -- State object for price value // [!code ++]

local CalculateCoins = compute(function(get)
	return get(Coins) - get(Price)
end, { Coins }) -- adding a dependency // [!code ++]

print(CalculateCoins:Get()) -- 50 // [!code ++]
Coins:Set(200) -- changing the value // [!code ++]
print(CalculateCoins:Get()) -- 150 // [!code ++]
```

### Explanation

1. In this code, we create [2 state objects](/api/state); Coins and Price.
2. Next, we add a dependency state to our `CalculateCoins` compute object, which must be a table.
3. The first parameter, the processor function provides a function `get` as a parameter inside of it which you can use to get the value of the state. In our code, we call the `get` function on the 2 state objects we created to get its value.
4. Our initial compute calculation was `get(Coins) - get(Price)` which is equivalent to `100 - 50 = 50`. Since we have the `Coins` state as a dependency in our compute object, when we set a new value for `Coins`, the compute re-runs!
5. We change the value of the state to 200 and the value re-runs and the new result of the compute object is `200 - 50 = 150`!

## Cleaning up computes

To clean up a compute object, we use the `Destroy` method.

```lua
CalculateCoins:Destroy()
```
