-- // Dependencies
local Types = require(script.Parent.Parent.Types)

-- // Variables
local round = math.round
local abs = math.abs

-- // Variables
local Storage = {
	RegisteredKeys = {},
	Scheduler = {
		Server = { Connection = nil, Active = {} },
		Client = { Connection = nil, Active = {} },
	} :: Scheduler,
	FreeThreads = {} :: { thread },
	AnimatableDataTypes = {
		boolean = {
			ToLinear = function(value: boolean): { number }
				return { value and 1 or 0 }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return value[1] >= 0.5
			end,
		},
		number = {
			ToLinear = function(value: number): { number }
				return { value }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return value[1]
			end,
		},
		BrickColor = {
			ToLinear = function(value: BrickColor): { number }
				return { value.r, value.g, value.b }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return BrickColor.new(value[1], value[2], value[3])
			end,
		},
		CFrame = {
			ToLinear = function(value: CFrame): { number }
				return table.pack(value:GetComponents())
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return CFrame.new(
					value[1],
					value[2],
					value[3],
					value[4],
					value[5],
					value[6],
					value[7],
					value[8],
					value[9],
					value[10],
					value[11],
					value[12]
				)
			end,
		},
		Vector3 = {
			ToLinear = function(value: Vector3): { number }
				return { value.X, value.Y, value.Z }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return Vector3.new(value[1], value[2], value[3])
			end,
		},
		Vector2 = {
			ToLinear = function(value: Vector2): { number }
				return { value.X, value.Y }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return Vector2.new(value[1], value[2])
			end,
		},
		UDim2 = {
			ToLinear = function(value: UDim2): { number }
				return { value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return UDim2.new(value[1], round(value[2]), value[3], round(value[4]))
			end,
		},
		UDim = {
			ToLinear = function(value: UDim): { number }
				return { value.Scale, value.Offset }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return UDim.new(value[1], round(value[2]))
			end,
		},
		Color3 = {
			ToLinear = function(value: Color3): { number }
				return { value.R, value.G, value.B }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return Color3.new(abs(value[1]), abs(value[2]), abs(value[3]))
			end,
		},
		Vector3int16 = {
			ToLinear = function(value: Vector3int16): { number }
				return { value.X, value.Y, value.Z }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return Vector3int16.new(value[1], value[2], value[3])
			end,
		},
		Vector2int16 = {
			ToLinear = function(value: Vector2int16): { number }
				return { value.X, value.Y }
			end,

			FromLinear = function(value: { number }): Types.Animatable
				return Vector2int16.new(value[1], value[2])
			end,
		},
		ColorSequence = {
			ToLinear = function(value: ColorSequence): { number }
				local c0 = value.Keypoints[1].Value
				local c1 = value.Keypoints[#value.Keypoints].Value

				return { c0.R, c0.G, c0.B, c1.R, c1.G, c1.B }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return ColorSequence.new(
					Color3.new(value[1], value[2], value[3]),
					Color3.new(value[4], value[5], value[6])
				)
			end,
		},
		NumberSequence = {
			ToLinear = function(value: NumberSequence): { number }
				return { value.Keypoints[1].Value, value.Keypoints[#value.Keypoints].Value }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return NumberSequence.new(value[1], value[2])
			end,
		},
		NumberRange = {
			ToLinear = function(value: NumberRange): { number }
				return { value.Min, value.Max }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return NumberRange.new(value[1], value[2])
			end,
		},
		Rect = {
			ToLinear = function(value: Rect): { number }
				return { value.Min.X, value.Min.Y, value.Max.X, value.Max.Y }
			end,
			FromLinear = function(value: { number }): Types.Animatable
				return Rect.new(value[1], value[2], value[3], value[4])
			end,
		},
	} :: AnimatableDataTypes,
}

-- // Types
type AnimatableDataTypes = {
	[string]: {
		ToLinear: (value: Types.Animatable) -> { number },
		FromLinear: (value: { number }) -> Types.Animatable,
	},
}
type Scheduler = {
	[string]: { Connection: RBXScriptConnection?, Active: { [number]: (deltaTime: number) -> () } },
}
-- // Returning
return Storage
