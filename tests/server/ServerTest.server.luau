local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aegis = require(ReplicatedStorage.Packages.Aegis)
local Storage = require(ReplicatedStorage.Storage)

local new = Aegis.new
local Children = Aegis.Children
local Events = Aegis.Events

local StorageTab = {}

local DataTypesFolder = new("Folder"):ApplyProps({ Name = "DataTypes", Parent = workspace })

local function DataTypeTemplate(index: number, info)
	local Part = new("Part"):ApplyProps({
		Name = info.Name,
		Parent = DataTypesFolder,
		Anchored = true,
		Position = Vector3.new(0, 5, ((index - 1) * 5)),
		Transparency = 0,
		Size = Vector3.new(4, 4, 4),

		[Children] = {
			new("ProximityPrompt"):ApplyProps({
				ActionText = "Play",
				ObjectText = info.Name,
				HoldDuration = 0.5,

				[Events] = {
					Triggered = function()
						StorageTab[part].Trigger(StorageTab[part])
					end,
				},
			}),
		},
	})

	StorageTab[Part] = info.CreateSpring(Aegis, Part)

	return Part
end

for index, info in Storage do
	DataTypeTemplate(index, info)
end

--[[
	local Part = Build("Part", function(mypart: Part)
		return {
			Name = "MyPart",
			Parent = workspace,
			Anchored = true,
			Position = Vector3.new(0, 5, 10),
			Transparency = 0,

			Size = Spring({
				State = SizeState,
				Damping = 1.1,
				Frequency = 0.9,
			}),

			[Children] = {
				Build("ProximityPrompt", function()
					return {
						ActionText = "Play",
						ObjectText = "Spring",
						HoldDuration = 0.5,

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
]]
