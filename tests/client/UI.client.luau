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
local Key = Aegis.Key
local State = Aegis.state
local Spring = Aegis.spring

-- // Created states
local ButtonState = State(Color3.fromRGB(22, 22, 22))

-- // UI
local ScreenGui = new("ScreenGui", {
	Name = "Gui",
	Parent = Player:WaitForChild("PlayerGui"),
	IgnoreGuiInset = true,

	[Key("Children")] = {
		new("Frame", {
			BackgroundColor3 = Color3.fromRGB(18, 18, 18),
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
		}),
		new("TextButton", {
			AnchorPoint = Vector2.new(0.5, 1),
			AutoButtonColor = false,
			BackgroundColor3 = Spring({
				Damping = 0.5,
				Velocity = 20,
				Frequency = 1,
				State = ButtonState,
			}),
			TextColor3 = Color3.fromRGB(210, 210, 210),
			Position = UDim2.fromScale(0.5, 0.85),
			Size = UDim2.fromScale(0.175, 0.075),
			Text = "Trigger",
			TextScaled = true,
			FontFace = Font.fromId(11702779517),

			[Key("Children")] = {
				new("UICorner", { CornerRadius = UDim.new(0.2, 0) }),
				new("UITextSizeConstraint", { MaxTextSize = 30 }),
				new("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Color3.fromRGB(210, 210, 210),
					Thickness = 0.6,
				}),
			},

			[Key("Events")] = {
				MouseEnter = function()
					ButtonState:Set(Color3.fromRGB(250, 200, 152))
				end,

				MouseLeave = function()
					ButtonState:Set(Color3.fromRGB(22, 22, 22))
				end,
			},
		}),
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.65, 0.025),
			BackgroundColor3 = Color3.fromRGB(210, 210, 210),

			[Key("Children")] = {
				new("UICorner", { CornerRadius = UDim.new(1, 0) }),
				new("Frame", {
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromScale(0.5, 1),
					BackgroundColor3 = Color3.fromRGB(250, 200, 152),
				}),
			},
		}),
	},
})
