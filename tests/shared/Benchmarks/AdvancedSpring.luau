--!nocheck
-----------------------------------------------------------------------------------------------------
--       ___    ____ _    _____    _   __________________     _____ ____  ____  _____   ________   --
--      /   |  / __ | |  / /   |  / | / / ____/ ____/ __ \   / ___// __ \/ __ \/  _/ | / / ____/   --
--     / /| | / / / | | / / /| | /  |/ / /   / __/ / / / /   \__ \/ /_/ / /_/ // //  |/ / / __     --
--    / ___ |/ /_/ /| |/ / ___ |/ /|  / /___/ /___/ /_/ /   ___/ / ____/ _, _// // /|  / /_/ /     --
--   /_/  |_/_____/ |___/_/  |_/_/ |_/\____/_____/_____/   /____/_/   /_/ |_/___/_/ |_/\____/      --
--                                                                                                 --
--                                     Made with <3 by Dervex                                      --
--                                                                                                 --
-- About:                                                                                          --
--   Advanced Spring lets you create spring class for every major Roblox & Luau type: boolean,     --
--   number, BrickColor, CFrame, Color3, ColorSequence, NumberRange, NumberSequence, Rect, UDim,   --
--   UDim2, Vector2, Vector3. You can set initial position, damping ratio and frequency when       --
--   creating new spring instance or by creating config file or by changing DEFAULT_SETTINGS.      --
--                                                                                                 --
-- API usage:                                                                                      --
--   local Spring = require(path.to.this.module)                                                   --
--                                                                                                 --
--   local spring = Spring.new(Vector3.new())                                                      --
--                                                                                                 --
--   spring:Set(Vector3.new(4, 2, 0))                                                              --
--   spring:Step(delta)                                                                            --
--   part.Position = spring:Get()                                                                  --
--                                                                                                 --
--   -- or you can do everything at once:                                                          --
--   part.Position = spring:All(Vector3.new(4, 2, 0), delta)                                       --
--                                                                                                 --
-- Limitations:                                                                                    --
--   CFrame - only position is supported (it may change in the future)                             --
--   ColorSequence & NumberSequence - only first and last keypoints are supported                  --
--                                                                                                 --
-- Credits:                                                                                        --
--   Part of this code was written by Fraktality                                                   --
-----------------------------------------------------------------------------------------------------

export type Spring = {
	__index: Spring,
	new: (position: any?, damping: number?, frequency: number?) -> Spring,
	Set: (self: Spring, goal: any) -> (),
	Step: (self: Spring, delta: number) -> (),
	Get: (self: Spring) -> any,
	All: (self: Spring, goal: any, delta: number) -> any,
}

local DEFAULT_SETTINGS = {}
do
	DEFAULT_SETTINGS.damping = 1
	DEFAULT_SETTINGS.frequency = 3
	DEFAULT_SETTINGS.position = 0

	if game.ReplicatedStorage:FindFirstChild("config") then
		local Config = require(game.ReplicatedStorage.config)

		if Config.AdvancedSpring then
			for i, v in pairs(Config.AdvancedSpring) do
				if type(v) == "number" or i == "position" then
					DEFAULT_SETTINGS[i] = v
				end
			end
		end
	end
end

local LinearSpring = {}
do
	LinearSpring.__index = LinearSpring

	function LinearSpring.new(damping, frequency, goal)
		return setmetatable({
			d = damping,
			f = frequency,
			g = goal,
			p = goal,
			v = goal * 0,
		}, LinearSpring)
	end

	function LinearSpring:Set(goal)
		self.g = goal
	end

	function LinearSpring:Get()
		return self.p
	end

	function LinearSpring:Step(delta)
		local d = self.d
		local f = self.f * math.pi * 2
		local g = self.g
		local p = self.p
		local v = self.v

		local offset = p - g
		local decay = math.exp(-delta * d * f)

		if d == 1 then
			self.p = (v * delta + offset * (f * delta + 1)) * decay + g
			self.v = (v - (offset * f + v) * (f * delta)) * decay
		elseif d < 1 then
			local c = math.sqrt(1 - d * d)

			local i = math.cos(delta * f * c)
			local j = math.sin(delta * f * c)

			self.p = (offset * i + (v + offset * (d * f)) * j / (f * c)) * decay + g
			self.v = (v * (i * c) - (v * d + offset * f) * j) * (decay / c)
		else
			local c = math.sqrt(d * d - 1)

			local r1 = -f * (d - c)
			local r2 = -f * (d + c)

			local co2 = (v - offset * r1) / (2 * f * c)
			local co1 = offset - co2

			local e1 = co1 * math.exp(r1 * delta)
			local e2 = co2 * math.exp(r2 * delta)

			self.p = e1 + e2 + g
			self.v = r1 * e1 + r2 * e2
		end
	end
end

local LinearValue = {}
do
	LinearValue.__index = LinearValue

	function LinearValue.new(...)
		return setmetatable({ ... }, LinearValue)
	end

	function LinearValue:__add(linearValue)
		local new = LinearValue.new(unpack(self))
		for i in ipairs(new) do
			new[i] += linearValue[i]
		end
		return new
	end

	function LinearValue:__sub(linearValue)
		local new = LinearValue.new(unpack(self))
		for i in ipairs(new) do
			new[i] -= linearValue[i]
		end
		return new
	end

	function LinearValue:__mul(scalar)
		local new = LinearValue.new(unpack(self))
		for i in ipairs(new) do
			new[i] *= scalar
		end
		return new
	end

	function LinearValue:__div(scalar)
		local new = LinearValue.new(unpack(self))
		for i in ipairs(new) do
			new[i] /= scalar
		end
		return new
	end
end

local dataTypes = {
	boolean = {
		toLinear = function(value)
			return LinearValue.new(value and 1 or 0)
		end,
		fromLinear = function(linearValue)
			return linearValue[1] >= 0.5
		end,
	},
	number = {
		toLinear = function(value)
			return LinearValue.new(value)
		end,
		fromLinear = function(linearValue)
			return linearValue[1]
		end,
	},
	BrickColor = {
		toLinear = function(value)
			return LinearValue.new(value.r, value.g, value.b)
		end,
		fromLinear = function(value)
			return BrickColor.new(value[1], value[2], value[3])
		end,
	},
	CFrame = {
		toLinear = function(value)
			return LinearValue.new(value.Position.X, value.Position.Y, value.Position.Z)
		end,
		fromLinear = function(value)
			return CFrame.new(value[1], value[2], value[3])
		end,
	},
	Color3 = {
		toLinear = function(value)
			return LinearValue.new(value.R, value.G, value.B)
		end,
		fromLinear = function(value)
			return Color3.new(value[1], value[2], value[3])
		end,
	},
	ColorSequence = {
		toLinear = function(value)
			local c0 = value.Keypoints[1].Value
			local c1 = value.Keypoints[#value.Keypoints].Value
			return LinearValue.new(c0.R, c0.G, c0.B, c1.R, c1.G, c1.B)
		end,
		fromLinear = function(value)
			return ColorSequence.new(Color3.new(value[1], value[2], value[3]), Color3.new(value[4], value[5], value[6]))
		end,
	},
	NumberRange = {
		toLinear = function(value)
			return LinearValue.new(value.Min, value.Max)
		end,
		fromLinear = function(value)
			return NumberRange.new(value[1], value[2])
		end,
	},
	NumberSequence = {
		toLinear = function(value)
			return LinearValue.new(value.Keypoints[1].Value, value.Keypoints[#value.Keypoints].Value)
		end,
		fromLinear = function(value)
			return NumberSequence.new(value[1], value[2])
		end,
	},
	Rect = {
		toLinear = function(value)
			return LinearValue.new(value.Min.X, value.Min.Y, value.Max.X, value.Max.Y)
		end,
		fromLinear = function(value)
			return Rect.new(value[1], value[2], value[3], value[4])
		end,
	},
	UDim = {
		toLinear = function(value)
			return LinearValue.new(value.Scale, value.Offset)
		end,
		fromLinear = function(value)
			return UDim.new(value[1], value[2])
		end,
	},
	UDim2 = {
		toLinear = function(value)
			return LinearValue.new(value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset)
		end,
		fromLinear = function(value)
			return UDim2.new(value[1], value[2], value[3], value[4])
		end,
	},
	Vector2 = {
		toLinear = function(value)
			return LinearValue.new(value.X, value.Y)
		end,
		fromLinear = function(value)
			return Vector2.new(value[1], value[2])
		end,
	},
	Vector3 = {
		toLinear = function(value)
			return LinearValue.new(value.X, value.Y, value.Z)
		end,
		fromLinear = function(value)
			return Vector3.new(value[1], value[2], value[3])
		end,
	},
}

local Spring: Spring = {}
do
	Spring.__index = Spring

	-- Creates new spring class with optional initial position and settings
	function Spring.new(position: any?, damping: number?, frequency: number?): Spring
		position = position or DEFAULT_SETTINGS.position
		damping = if type(damping) == "number" then damping else DEFAULT_SETTINGS.damping
		frequency = if type(frequency) == "number" then frequency else DEFAULT_SETTINGS.frequency

		assert(dataTypes[typeof(position)], "Unsupported type: " .. typeof(position))
		assert(damping * frequency >= 0, "No solution, damping * frequency must be greater than 0")

		print(damping * frequency)

		local dataType = dataTypes[typeof(position)]
		local spring = LinearSpring.new(damping, frequency, dataType.toLinear(position))

		return setmetatable({
			dataType = dataType,
			spring = spring,
		}, Spring)
	end

	-- Sets new spring goal
	function Spring:Set(goal: any)
		self.spring:Set(self.dataType.toLinear(goal))
	end

	-- Updates spring by delta seconds
	function Spring:Step(delta: number)
		self.spring:Step(delta or 0)
	end

	-- Returns current spring position
	function Spring:Get(): any
		return self.dataType.fromLinear(self.spring:Get())
	end

	-- Sets new goal, updates spring and returns current position
	function Spring:All(goal: any, delta: number): any
		self:Set(goal)
		self:Step(delta)
		return self:Get()
	end
end

return Spring
