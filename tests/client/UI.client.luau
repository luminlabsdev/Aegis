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
local BackgroundState = State(Color3.fromRGB(22, 22, 22))
local TextState = State(Color3.fromRGB(250, 200, 152))
local TransparencyState = State(0)

-- // UI
local ui = new("ScreenGui", {
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
				State = BackgroundState,
			}),
			TextColor3 = Spring({
				Damping = 0.5,
				Velocity = 20,
				Frequency = 1,
				State = TextState,
			}),
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
					BackgroundState:Set(Color3.fromRGB(250, 200, 152))
					TextState:Set(Color3.fromRGB(22, 22, 22))
				end,

				MouseLeave = function()
					BackgroundState:Set(Color3.fromRGB(22, 22, 22))
					TextState:Set(Color3.fromRGB(250, 200, 152))
				end,

				MouseButton1Click = function()
					TransparencyState:Set(Random.new():NextNumber(0, 1))
				end,
			},
		}),
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = Spring({
				Damping = 0.35,
				Frequency = 1.5,
				Velocity = 25,
				State = TransparencyState,
			}),
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

--[[
	local AdvSpr = require(script.Parent.AdvSpr)
	local spr = AdvSpr.new(Color3.fromRGB(22, 22, 22))

	game:GetService("RunService").RenderStepped:Connect(function(delta)
		ui.TextButton.BackgroundColor3 = spr:All(ButtonState:Get(), delta)
	end)
]]
