-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Dependencies
local Theme = require(ReplicatedStorage.Theme)
local Aegis = require(ReplicatedStorage.Packages.Aegis)

-- // Variables
local new = Aegis.new
local Children = Aegis.Key("Children")

-- // UI
new("ScreenGui", {
	Name = "Menu",
	IgnoreGuiInset = true,
	Parent = game:GetService("StarterGui"),
	[Children] = {
		new("TextButton", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.65),
			Size = UDim2.fromScale(0.25, 0.1),
			BackgroundColor3 = Theme.Dark.BackgroundMain,
		}),
	},
})
