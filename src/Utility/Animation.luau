-- // Dependencies
local InternalTypes = require(script.Parent.InternalTypes)
local PublicTypes = require(script.Parent.PublicTypes)

-- // Variables
local Animation = {
	Epsilon = 0.001,
}

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
)
	local IsSettled = true

	for index, value in self._currentPosition.Packed do
		if math.abs(value - targetPosition_Packed[index]) > Animation.Epsilon then
			IsSettled = false
			break
		end
	end

	return IsSettled
end

-- // Returning
return Animation
