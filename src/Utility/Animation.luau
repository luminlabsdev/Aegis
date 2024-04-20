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

-- // Functions
function Animation.IsSpringSettled(currentLinearPosition: { number }, linearTargetPosition: { number }): boolean
	local IsSettled = false

	for index, value in currentLinearPosition do
		if math.abs(value - linearTargetPosition[index]) <= Animation.Epsilon then
			-- If the difference is less / equal to the epsilon, then settle the spring
			IsSettled = true
			break
		end
	end

	return IsSettled
end

--[[
	function Animation.NumberSpringStep(
		spring: PublicTypes.Spring,
		currentPosition: number,
		targetPosition: number,
		delta: number
	)
		

		print(NewPosition, NewVelocity)

		return NewPosition, NewVelocity
	end
]]

-- // Returning
return Animation
