local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis)
local Storage = require(ReplicatedStorage.Storage)

local new = Aegis.new
local Children = Aegis.Children
local Events = Aegis.Events

local StorageTab = {}

local DataTypesFolder = new("Folder"):ApplyProps({ Name = "DataTypes", Parent = workspace })

local function DataTypeTemplate(index: number, info)
	local Part = new("Part")
	local Component = info.Component(Part:Get())

	Part:ReadComponent(Component)
	Part:ApplyProps({
		Name = info.Name,
		Parent = DataTypesFolder,
		Anchored = true,
		Position = Vector3.new(0, 5, ((index - 1) * 5)),
		BrickColor = BrickColor.random(),
		Transparency = 0,
		Size = Vector3.new(4, 4, 4),

		[Children] = {
			new("ProximityPrompt"):ApplyProps({
				ActionText = "Play",
				ObjectText = info.Name,
				HoldDuration = 0.5,

				[Events] = {
					Triggered = function()
						StorageTab[Part:Get()].Trigger(StorageTab[Part:Get()])
					end,
				},
			}),
		},
	})

	StorageTab[Part:Get()] = Component

	return Part
end

for index, info in Storage do
	DataTypeTemplate(index, info :: any)
end
