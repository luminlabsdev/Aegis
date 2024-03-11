local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Robax = require(ReplicatedStorage.Robax)

local Build = Robax.Build
local State = Robax.State
local Keys = Robax.Keys

local Children = Keys.Children
local Events = Keys.Events
local Changes = Keys.Changes
local Attributes = Keys.Attributes
local Tags = Keys.Tags

local MyPart = Build("Part", {
	Name = "MyPart",
	Parent = workspace, -- Robax will skip over this and parent the instance at the end!
	Position = Vector3.new(0, 5, 0),
	Size = Vector3.new(4, 4, 4),
	BrickColor = BrickColor.Random(),
	BottomSurface = Enum.SurfaceType.Smooth,
	TopSurface = Enum.SurfaceType.Smooth,
	[Tags] = { "RobaxPart", "BasePart", "TagTested" },
	[Children] = {
		Build("Folder", {
			Name = "MyFolder",
			[Children] = {
				Build("Script", { Name = "MyScript" }),
			}, -- Testing out nested children key
			[Attributes] = {
				Attribute1 = true,
				Attribute2 = 2024,
			},
		}),
		Build("Decal", {
			Texture = "rbxasset://textures/SpawnLocation.png",
			Face = Enum.NormalId.Top,
		}),
	},
	[Events] = {
		Touched = function()
			print("A player touched MyPart!")
		end,
	},

	[Changes] = {
		Transparency = function()
			print("transparency just changed!")
		end,
	},
})

task.wait(10)
print("changing transparency")

for i = 0, 1, 0.01 do
	task.wait(0.1)
	MyPart.Transparency = i
end
