local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis) :: any

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Build = Aegis.Build
local State = Aegis.State
local Spring = Aegis.Spring
local Children = Aegis.Children
local Events = Aegis.Events

local SizeState = State(0.2)
local ChangeState = State(UDim2.new(SizeState:Get(), SizeState:Get(), SizeState:Get(), SizeState:Get()))

local ScreenGui = Build("ScreenGui", function()
	return {
		Name = "Gui",
		Parent = PlayerGui,

		[Children] = {
			Build("Frame", function()
				return {
					Name = "Frame",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),

					Size = Spring({
						State = ChangeState,
						Damping = 0.01,
						Frequency = 0.5,
					}),
				}
			end),

			Build("TextButton", function()
				return {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromScale(0.2, 0.2),
					Position = UDim2.fromScale(0.5, 0.1),

					[Events] = {
						MouseButton1Click = function()
							SizeState:Set(0.4)
						end,
					},
				}
			end),
		},
	}
end)

SizeState:Listen(function(_, newValue: number)
	ChangeState:Set(UDim2.new(newValue, newValue, newValue, newValue))
end)
