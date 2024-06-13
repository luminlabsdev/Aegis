-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local SprTest = Aegis.state(Color3.fromRGB(255, 0, 0))

-- // Main
Aegis.new("Part", {
	Parent = workspace,
	Position = Vector3.new(0, 5, 0),
	Size = Vector3.new(4, 4, 4),
	Anchored = true,
	CanCollide = true,
	Color = Aegis.spring({ State = SprTest, Damping = 0.3, Frequency = 1.3 }),

	[Aegis.Key("Children")] = {
		Aegis.new("ProximityPrompt", {
			[Aegis.Key("Events")] = {
				Triggered = function(player: Player)
					SprTest:Set(BrickColor.random().Color)
				end,
			},
		}),
	},
})
