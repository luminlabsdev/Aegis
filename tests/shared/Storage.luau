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
					Set = function(newValue: Vector3)
						State:Set(newValue)
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
					Set = function(newValue: Vector2)
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
		Component = function(part: Part)
			local State = state(part.Transparency)

			return component()
				:AcceptClasses({ "Part" })
				:AcceptFunctions({
					Set = function(newValue: number)
						State:Set(newValue)
					end,
				})
				:ApplyProps({
					Transparency = spring({ State = State }),
				})
		end,
	},
}
