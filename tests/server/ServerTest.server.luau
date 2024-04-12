local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis) :: any

local Build = Aegis.Build
local State = Aegis.State
local Spring = Aegis.Spring
local Keys = Aegis.Keys

local Children = Keys.Children
local Events = Keys.Events

local SizeState = State(Vector3.new(4, 4, 4))

local Part = Build("Part", function(mypart: Part)
	return {
		Name = "MyPart",
		Parent = workspace,
		Anchored = true,
		Position = Vector3.new(0, 5, 10),

		Size = Spring({
			State = SizeState,
			Damping = 1,
			Speed = 1,
			Elasticity = 1,
			Mass = mypart.Mass,
		}),

		[Children] = {
			Build("ProximityPrompt", function()
				return {
					ActionText = "Test",
					HoldDuration = 1,

					[Events] = {
						Triggered = function()
							print("Wow nice!")
						end,
					},
				}
			end),
		},
	}
end)
