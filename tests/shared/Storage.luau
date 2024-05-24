
local Aegis = require(script.Parent.Packages.Aegis)
local state = Aegis.state
local spring = Aegis.spring
local component = Aegis.component

return {
	{
		Name = "Vector3",
		Component = function(part: Part)
			local State = state(part.Size)
			return component()
				:AcceptClasses({ "Part" })
				:AcceptFunctions({
					Trigger = function()
						State:Set(Vector3.new(4, math.random(1, 10), 4))
					end,
				})
				:ApplyProps({
					Size = spring({ State = State }),
				})
		end,
	},
	{
		Name = "Vector2",
		Component = function(part: Part)
			local State = state(part.Position)

			return component()
				:AcceptClasses({ "Part" })
				:AcceptFunctions({
					Trigger = function(newValue: Vector2)
						State:Set(newValue)
					end,
				})
				:ApplyProps({
					-- Size = spring({State = State})
				})
		end,
	},
	{
		Name = "number",
		Component = function()
			local RNG = Random.new()
			local State = state(RNG:NextNumber(0, 1))

			return component()
				:AcceptClasses({ "Part" })
				:AcceptFunctions({
					Trigger = function()
						State:Set(RNG:NextNumber(0, 1))
					end,
				})
				:ApplyProps({
					Transparency = spring({ State = State }),
				})
		end,
	},
}
