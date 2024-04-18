-- // Folders
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Utils = require(script.Parent.Utils)

-- // Variables
local Animation = {
	Epsilon = 1e-3,
}

local exp = math.exp
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin

-- // Functions
function Animation.UpdateNumberSpring(
	stiffness: number,
	targetPosition: number,
	currentPosition: number,
	velocity: number,
	mass: number,
	deltaTime: number
): number
	--[[ Separated into variables
		local Displacement = targetPosition - position
		local Acceleration = -(stiffness * Displacement) / mass
		local NewVelocity = velocity + (Acceleration * deltaTime)
		local NewPosition = position + (NewVelocity * deltaTime)

		return NewPosition
	]]

	return currentPosition
		+ ((velocity + ((-(stiffness * (targetPosition - currentPosition)) / mass) * deltaTime)) * deltaTime)
end

function Animation.IsSpringSettled(
	self: InternalTypes.SpringInternal<PublicTypes.State>,
	targetPosition_Packed: { number }
): boolean
	local IsSettled = false

	for index, value in self._currentPosition.Packed do
		if math.abs(value - targetPosition_Packed[index]) <= Animation.Epsilon then
			-- If the difference is less / equal to the epsilon, then settle the spring
			IsSettled = true
			break
		end
	end

	return IsSettled
end

function Animation.NumberSpringStep(spring: PublicTypes.Spring, currentPosition: number, targetPosition: number)
	local Delta = os.clock()
	local Damping = spring._damping
	local Frequency = spring._frequency
	local Velocity = targetPosition * 0

	local Offset = currentPosition - targetPosition :: any
	local Decay = exp(-Delta * Damping * Frequency)

	local NewPosition: number, NewVelocity: number

	-- DO NOT CHANGE ANYTHING IN THE CALCULATION
	if Damping == 1 then -- Critical damping
		NewPosition = (Velocity * Delta + Offset * (Frequency * Delta + 1)) * Decay + targetPosition
		NewVelocity = (Velocity - (Offset * Frequency + Velocity) * (Frequency * Delta)) * Decay
	elseif Damping < 1 then -- Underdamped
		local Constant = sqrt(1 - (Damping ^ 2))
		local Cosin_Angle = cos(Delta * Frequency * Constant)
		local Sine_Angle = sin(Delta * Frequency * Constant)

		NewPosition = (
			Offset * Cosin_Angle + (Velocity + Offset * (Damping * Frequency)) * Sine_Angle / (Frequency * Constant)
		)
				* Decay
			+ targetPosition
		NewVelocity = (Velocity * (Cosin_Angle * Constant) - (Velocity * Damping + Offset * Frequency) * Sine_Angle)
			* (Decay / Constant)
	else -- Overdamped
		local Constant = sqrt((Damping ^ 2) - 1)

		local Root1 = -Frequency * (Damping - Constant)
		local Root2 = -Frequency * (Damping + Constant)

		local Coefficient2 = (Velocity - Offset * Root1) / (2 * Frequency * Constant)
		local Coefficient1 = Offset - Coefficient2

		local Exp1 = Coefficient1 * exp(Root1 * Delta)
		local Exp2 = Coefficient2 * exp(Root2 * Delta)

		NewPosition = Exp1 + Exp2 + targetPosition
		NewVelocity = Root1 * Exp1 + Root2 * Exp2
	end

	return NewPosition, NewVelocity
end

-- // Returning
return Animation
