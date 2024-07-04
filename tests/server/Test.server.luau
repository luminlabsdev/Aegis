-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local new = Aegis.new
local state = Aegis.state
local spring = Aegis.spring

local MyState = state(Vector3.new(0, 5, 0))
local CustomSpring = spring({
	State = MyState,
})

new("Part", {
	Color = Color3.fromRGB(77, 75, 75),
	TopSurface = Enum.SurfaceType.Smooth,
	BottomSurface = Enum.SurfaceType.Smooth,
	Size = Vector3.new(4, 4, 4),
	Anchored = true,
	Parent = workspace,
	Position = CustomSpring,
})

while task.wait(1) do
	MyState:Set(Vector3.new(0, math.random(5, 10), 0))
	print("animating")
end
