local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis)
-- local Storage = require(ReplicatedStorage.Storage)

local new = Aegis.new
local Key = Aegis.Key

local StorageTab = {}

if workspace:FindFirstChild("DataTypes") then
	workspace:FindFirstChild("DataTypes"):Destroy()
end

local DataTypesFolder = new("Folder", { Name = "DataTypes", Parent = workspace })

local function DataTypeTemplate(index: number)
	local Part = Aegis.state()

	new("Part", {
		Name = `Part{index}`,
		Parent = DataTypesFolder,
		Anchored = true,
		Position = Vector3.new(0, 5, ((index - 1) * 5)),
		BrickColor = BrickColor.random(),
		Transparency = 0,
		Size = Vector3.new(4, 4, 4),
		[Key("Attributes")] = { Trigger = false },
		[Key("Tags")] = { hi = false },
		[Key("Ref")] = Part,

		[Key("Children")] = {
			new("ProximityPrompt", {
				ActionText = "Play",
				ObjectText = `Part{index}`,
				HoldDuration = 0.5,

				[Key("Events")] = {
					Triggered = function()
						StorageTab[Part].Functions.Trigger()
					end,
				},
			}),
		},
	})

	return Part:Get()
end

for index = 0, 5, 1 do
	DataTypeTemplate(index)
end
