return {
	{
		Name = "Vector3",
		CreateSpring = function(Aegis: any, part: Part)
			local State = Aegis.State(part.Position)
			Aegis.Spring({ State = State })

			return State
		end,
		Trigger = function(state: any)
			state:Set(Vector3.new(state:Get().X, math.random(10), state:Get().Z))
		end,
	},
	{
		Name = "Vector2",
		CreateSpring = function(Aegis: any, part: Part)
			local State = Aegis.State(part.Position)
			Aegis.Spring({ State = State })

			return State
		end,
		Trigger = function(state: any)
			state:Set(Vector2.new(state:Get().X, math.random(10)))
		end,
	},
	{
		Name = "number",
		CreateSpring = function(Aegis: any, part: Part)
			local State = Aegis.State(part.Transparency)
			Aegis.Spring({ State = State })

			return State
		end,
		Trigger = function(state: any)
			state:Set(math.random(0, 1))
		end,
	},
}
