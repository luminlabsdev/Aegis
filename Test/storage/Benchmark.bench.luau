--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Robax = require(ReplicatedStorage.Robax)
local Fusion = require(ReplicatedStorage.Fusion)

return {
	ParameterGenerator = function()
		return
	end,

	Functions = {
		["Robax.Test"] = function(Profiler)
			local Build = Robax.Build
			local State = Robax.State
			local Keys = Robax.Keys

			local Children = Keys.Children
			local Events = Keys.Events
			local Changes = Keys.Changes
			local Attributes = Keys.Attributes
			local Tags = Keys.Tags

			local MyPart = Build("Part", {
				Name = "RobaxPart",
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
		end,

		["Fusion.Test"] = function(Profiler)
			local New = Fusion.New
			local Value = Fusion.Value

			local Children = Fusion.Children
			local OnEvent = Fusion.OnEvent
			local OnChange = Fusion.OnChange

			local MyPart = New("Part")({
				Name = "FusionPart",
				Parent = workspace,
				Position = Vector3.new(0, 5, 0),
				Size = Vector3.new(4, 4, 4),
				BrickColor = BrickColor.Random(),
				BottomSurface = Enum.SurfaceType.Smooth,
				TopSurface = Enum.SurfaceType.Smooth,
				[Children] = {
					New("Folder")({
						Name = "MyFolder",
						[Children] = {
							New("Script", { Name = "MyScript" }),
						},
					}),
					New("Decal")({
						Texture = "rbxasset://textures/SpawnLocation.png",
						Face = Enum.NormalId.Top,
					}),
				},
				[OnEvent("Touched")] = function()
					print("A player touched MyPart!")
				end,

				[OnChange("Transparency")] = function()
					print("transparency just changed!")
				end,
			})
		end,
	},
}
