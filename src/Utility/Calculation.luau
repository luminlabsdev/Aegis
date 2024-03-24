-- // Variables
local Calculation = {}

-- // Functions
function Calculation.CalculateDisplacement(k: number, x: number, c: number, u: number, m: number, t: number): number
	--[[ Acceleration calculation:

		We know,	F = -kx
		Again,		F = -cv

		If we add the 2,	F = -kx - cv
						or, F = -(kx + cv)
						or, ma = -(kx + cv)
				Therefore,	a = -(kx + cv) / m

		Displacement calculation:

		We know, S = ut + (0.5 * at^2)
	]]
	local a = -((k * x) + (c * u)) / m -- acceleration
	local S = (u * t) + (0.5 * a * (t ^ 2)) -- displacement

	return S
end

function Calculation.ReturnAbsoluteDisplacement(property: number, s: number): number
	return if property < 0 then -s else s
end

function Calculation.ReturnComparableValue(value: any): number
	local DataType = typeof(value)

	if DataType == "number" then
		return value :: number
	elseif DataType == "UDim2" then
		return value.X.Scale + value.Y.Scale + value.X.Offset + value.Y.Offset :: number
	elseif DataType == "UDim" then
		return value.Scale + value.Offset :: number
	elseif DataType == "Vector3" or "Vector2" then
		return value.Magnitude :: number
	else
		return tonumber(value) or 0 :: number
	end
end

-- // Returning
return Calculation
