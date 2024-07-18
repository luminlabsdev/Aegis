-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local Packages = ReplicatedStorage.Packages

-- Dependencies
local Aegis = require(Packages.Aegis)

-- Variables
local New = Aegis.new

type Background = {
    Color: Color3,
    Position: UDim2?,
    Size: UDim2?,
    [any]: any,
}

return function(props: Background)
    return New("Frame", {
        BackgroundColor3 = props.Color,
        Position = props.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = props.Size or UDim2.fromScale(0.5, 0.5),
        ZIndex = 2,
    }, props.Children)
end
