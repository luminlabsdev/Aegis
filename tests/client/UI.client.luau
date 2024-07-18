-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Folders
local Packages = ReplicatedStorage.Packages

-- Dependencies
local Aegis = require(Packages.Aegis)
local MyComponent = require(script.Parent.components.Background)

-- Variables
local Player = Players.LocalPlayer
local New = Aegis.new

-- UI
New("ScreenGui", {
	Name = "MenuUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = New("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 1,
	}),
	ComponentBackgroundChildren = New(MyComponent, {
		Color = Color3.fromRGB(151, 71, 71),
		Position = UDim2.fromScale(0.5, 0.9)
	}, {
		New("TextLabel", {
			Text = "HI",
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 3,
		}),
	}),
	ComponentBackground = New(MyComponent, {
		Color = Color3.fromRGB(103, 196, 246),
		Position = UDim2.fromScale(0.5, 0.1),
	}),
})
