--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Aegis = require(Packages.Aegis)
local AdvancedSpring = require(ReplicatedStorage.Benchmarks.AdvancedSpring)

local StateTab = Aegis.state(Vector3.new(-4, 5, 0))

local AegisPart = Aegis.new("Part", {
	Name = "Aegis",
	Size = Vector3.new(4, 4, 4),
	BrickColor = BrickColor.Red(),
	Position = Aegis.spring({ State = StateTab }),
	Parent = workspace,
})

local SprPart = Aegis.new("Part", {
	Name = "Spr",
	Size = Vector3.new(4, 4, 4),
	BrickColor = BrickColor.Green(),
	Parent = workspace,
}) :: Part

local SprSpr = AdvancedSpring.new(Vector3.new(4, 5, 0))

return {
	ParameterGenerator = function(): ()
		return
	end,

	Functions = {
		["Aegis"] = function(): ()
			StateTab:Set(Vector3.new(-4, math.random(5, 10), 0))
		end,

		["AdvSpr"] = function(): ()
			SprPart.Position = SprSpr:All(Vector3.new(4, math.random(5, 10), 0), os.clock())
		end,
	},
}
