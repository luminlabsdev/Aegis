-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local MyState = Aegis.state(Vector3.new(0, 5, 0))
local CustomSpring = Aegis.spring({ State = MyState })

-- // Main
local AegisPart = Aegis.new("Part", {
	Size = Vector3.new(4, 4, 4),
	Anchored = true,
	Parent = workspace,
	Position = CustomSpring,
})

while task.wait(0.5) do
	MyState:Set(Vector3.new(0, math.random(5, 10), 0))
end
