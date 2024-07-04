-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local Player = Players.LocalPlayer
local new = Aegis.new

-- // UI
new("ScreenGui", {
	Name = "MenuUI",
	IgnoreGuiInset = true,
	Parent = Player:WaitForChild("PlayerGui"),
}, {
	Background = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
	}),
})
