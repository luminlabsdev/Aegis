# New Components

While working with user interface, you may start to realize that creating the same instance over and over again becomes repetitive. Components aim to solve this issue; these function just as creating a new instance would, but you store them in within a separate module which returns a function.

## Example usage

::: code-group
```lua:line-numbers [Component]
local Aegis = require(path.to.Aegis)
local new = Aegis.new

type BackgroundProps = {
    Color: Color3,
    Size: UDim2?,
    Position: UDim2?,
}

return function(props: BackgroundProps)
    return new("Frame", {
        BackgroundColor3 = props.Color,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BroderSizePixel = 0,
        Position = props.Position or UDim2.fromScale(0.5, 0.5),
        Size = props.Size or UDim2.fromScale(1, 1),
    }, props.Children)
end
```

```lua:line-numbers [Script]
local Aegis = require(path.to.Aegis)
local new = Aegis.new

local BackgroundComponent = require(path.to.BackgroundComponent)

local Main = new("ScreenGui", {
	Name = "Main",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = new(BackgroundComponent, {
		Color = Color3.fromRGB(24, 24, 24),
	}, {
		WelcomeText = new("TextLabel", {
			Text = "The parent of this text label is a component created using Aegis!"
		})
	})
})
```
:::

:::warning
Do not include a key named `Children` inside of your props table, it will be overwritten!
:::

The way you create components in Aegis is very similar to how you do it in React as well, but better performance and less confusion.