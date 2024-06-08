--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Aegis = require(Packages.Aegis)
local Fusion = require(Packages.Fusion)

return {
	ParameterGenerator = function()
		return
	end,

	Functions = {
		["Aegis"] = function()
			Aegis.new("Part", {
				Size = Vector3.new(4, 4, 4),
				Position = Vector3.new(0, 5, 0),
				BrickColor = BrickColor.random(),
				Parent = workspace,
				[Aegis.Key("Children")] = Aegis.new("ProximityPrompt", { ActionText = "Interact" }),
			}):Destroy()
		end,

		["Fusion"] = function()
			Fusion.New("Part")({
				Size = Vector3.new(4, 4, 4),
				Position = Vector3.new(0, 5, 0),
				BrickColor = BrickColor.random(),
				Parent = workspace,
				[Fusion.Children] = Fusion.New("ProximityPrompt")({ ActionText = "Interact" }),
			}):Destroy()
		end,
	},
}
