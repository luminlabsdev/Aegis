-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Dependencies
local Theme = require(ReplicatedStorage.Theme)
local Aegis = require(ReplicatedStorage.Packages.Aegis)

-- // Variables
local new = Aegis.new
local Children = Aegis.Key("Children")

-- // Returning
return {
	name = "Button",
	summary = "A button component",
	controls = { Text = "hi guys", Dark = true },
	story = function(parent: GuiObject, props: { [any]: any })
		local Controls = props.controls

		local ChosenTheme = Theme[Controls.Dark == true and "Dark" or "Light"]

		local Element = new("TextButton", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.65),
			Size = UDim2.fromScale(0.25, 0.085),

			BackgroundColor3 = ChosenTheme.BackgroundMain,
			TextColor3 = ChosenTheme.InnversedMain,

			Text = Controls.Text,

			AutoButtonColor = false,
			TextScaled = true,
			Parent = parent,

			[Children] = {
				new("UICorner", {
					CornerRadius = UDim.new(0.2, 0),
				}),
				new("UIStroke", {
					Thickness = 1,
					Color = ChosenTheme.Accent1,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				}),
				new("UITextSizeConstraint", {
					MaxTextSize = 40,
				}),
			},
		})

		return function()
			Element:Destroy()
		end
	end,
}
