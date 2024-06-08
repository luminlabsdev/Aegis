-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local SprTest = Aegis.state(Vector3.new(0, 5, 0))

-- // Main
Aegis.new("Part", {
	Parent = workspace,
	Position = Aegis.spring({
		Damping = 0.3,
		Frequency = 1.5,
		State = SprTest,
	}),
	Size = Vector3.new(4, 4, 4),
	Anchored = true,
	CanCollide = true,
})

while task.wait(3) do
	SprTest:Set(Vector3.new(math.random(5), 5, math.random(5)))
end
