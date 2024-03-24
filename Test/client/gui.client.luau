print("multiple runs on client?")

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- // Dependencies
local Aegis = require(ReplicatedStorage.Packages.Aegis) :: any

-- // Variables
local State = Aegis.State
local Spring = Aegis.Spring
local Build = Aegis.Build

local Keys = Aegis.Keys
local Children = Keys.Children

local SizeSpring = State(UDim2.fromScale(0.5, 0.5))
local Current = true

Build("ScreenGui", {
	Name = "UI",
	IgnoreGuiInset = true,
	Enabled = false,
	[Children] = {
		Build("Frame", {
			Name = "SpringFrame",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = Spring(SizeSpring, {
				Mass = 1,
				Speed = 20,
				Elasticity = 5,
				Damping = 0.25,
			}),
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
		}),
	},
	Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
})

UserInputService.InputBegan:Connect(function(a0: InputObject)
	if a0.KeyCode == Enum.KeyCode.E then
		SizeSpring:Set(if Current == true then UDim2.fromScale(0.75, 0.75) else UDim2.fromScale(0.5, 0.5))
		Current = not Current
	end
end)
