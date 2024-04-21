local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis) :: any

local Build = Aegis.Build
local State = Aegis.State
local Spring = Aegis.Spring
local Children = Aegis.Children
local Events = Aegis.Events

local OpacityState = State(0)
local CurrentSize = State(4)
local SizeState = State(Vector3.new(CurrentSize:Get(), CurrentSize:Get(), CurrentSize:Get()))

local Part = Build("Part", function(mypart: Part)
	return {
		Name = "MyPart",
		Parent = workspace,
		Anchored = true,
		Position = Vector3.new(0, 5, 10),
		Transparency = 0,

		Size = Spring({
			State = SizeState,
			Damping = 1,
			Frequency = 0.5,
		}),

		[Children] = {
			Build("ProximityPrompt", function()
				return {
					ActionText = "Test",
					HoldDuration = 1,

					[Events] = {
						Triggered = function()
							CurrentSize:Set(math.random(2, 10))
							-- OpacityState:Set(if mypart.Transparency == 1 then 0 else 1)
						end,
					},
				}
			end),
		},
	}
end)

CurrentSize:Listen(function(_, newValue: number)
	SizeState:Set(Vector3.new(newValue, newValue, newValue))
end)
