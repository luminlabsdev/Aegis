local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis) :: any

local Build = Aegis.Build
local State = Aegis.State
local Spring = Aegis.Spring
local Keys = Aegis.Keys

local Children = Keys.Children
local Events = Keys.Events
local Changes = Keys.Changes
local Attributes = Keys.Attributes
local Tags = Keys.Tags
local Ref = Keys.Ref

local RefTest = State()
local Opacity = State(0)
local SizeState = State(Vector3.new(4, 4, 4))

local MyPart = Build("Part", {
	Name = "MyPart",
	Parent = workspace, -- Aegis will skip over this and parent the instance at the end!
	Position = Vector3.new(0, 5, 0),
	Size = Spring(SizeState, {
		Damping = 0.1,
		Speed = 1,
		Elasticity = 0.5,
		Mass = 44,
	}),
	BrickColor = BrickColor.random(),
	BottomSurface = Enum.SurfaceType.Smooth,
	TopSurface = Enum.SurfaceType.Smooth,
	[Ref] = RefTest,
	Transparency = Spring(Opacity, {
		Damping = 0.1,
		Speed = 1,
		Elasticity = 0.5,
		Mass = 44,
	}),
	[Tags] = { "AegisPart", "BasePart", "TagTested" },
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
		Touched = function(part: Part)
			print(part.Name)
			if Players:GetPlayerFromCharacter(part:FindFirstAncestorOfClass("Model")) ~= nil then
				workspace.Baseplate.Size -= Vector3.new(1, 1, 1)
			end
		end,
	},

	[Changes] = {
		Transparency = function()
			print("transparency just changed!")
		end,
	},
})

print(RefTest:Get())

task.wait(10)

print("playing spring animation..")

task.wait(1)

Opacity:Set(1)
SizeState:Set(Vector3.new(7, 7, 7))

task.wait(5)

print("playing spring animation again..")

task.wait(1)

Opacity:Set(0)
SizeState:Set(Vector3.new(4, 4, 4))
