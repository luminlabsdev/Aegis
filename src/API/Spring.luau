-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Runtime = script.Parent.Parent.Runtime
local Utility = script.Parent.Parent.Utility
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Scheduler = require(Runtime.Scheduler)
local Animation = require(Utility.Animation)
local Debugger = require(Utility.Debugger)
local Storage = require(Runtime.Storage)
local Is = require(Utility.Is)

-- // Variables
local Class = {}

local sqrt = math.sqrt
local exp = math.exp
local cos = math.cos
local sin = math.sin
local pi = math.pi

-- // Functions
function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	local Mode = RunService:IsClient() and "Client" or "Server"
	local DataType_Fn = Storage.AnimatableDataTypes[self._type]
	local LinearTargetPosition = DataType_Fn.ToLinear(self._state:Get())
	local Connection

	self._currentLinearPosition = DataType_Fn.ToLinear(self._state:Get());
	(instance :: any)[prop] = self._state:Get()

	self._state:Listen(function(_, newValue)
		LinearTargetPosition = DataType_Fn.ToLinear(newValue)

		Connection = Scheduler:Add(Mode, function(delta: number)
			self:_update(LinearTargetPosition, delta);
			(instance :: any)[prop] = DataType_Fn.FromLinear(self._currentLinearPosition)

			if
				Animation.IsSpringSettled(self._currentLinearPosition, LinearTargetPosition) == true
				and Connection ~= nil
			then
				Scheduler:Remove(Mode, Connection);
				(instance :: any)[prop] = self._state:Get()
			end
		end)
	end)
end

function Class._update(
	self: InternalTypes.SpringInternal<PublicTypes.State>,
	linearTargetPosition: { number },
	delta: number
)
	for i = 1, #linearTargetPosition do
		--[[
			print(`Index: {i}`)
			print(`Current linear position's {i} index: {self._currentLinearPosition[i]}`)
			print(`Target linear position's {i} index: {linearTargetPosition[i]}`)
		]]
		-- self._currentLinearPosition[i], self._velocity =
		-- 	Animation.NumberSpringStep(self, self._currentLinearPosition[i], linearTargetPosition[i], delta)
		local Damping = self._damping
		local Frequency = 2 * pi * self._frequency
		local Velocity = self._velocity

		local Offset = self._currentLinearPosition[i] - linearTargetPosition[i]
		local Decay = exp(-delta * Damping * Frequency)

		-- DO NOT CHANGE ANYTHING IN THE CALCULATION
		if Damping == 1 then -- Critical damping
			self._currentLinearPosition[i] = (Velocity * delta + Offset * (Frequency * delta + 1)) * Decay
				+ linearTargetPosition[i]
			self._velocity = (Velocity - (Offset * Frequency + Velocity) * (Frequency * delta)) * Decay
		elseif Damping < 1 then -- Underdamped
			local Constant = sqrt(1 - Damping * Damping)
			local Cosin_Angle = cos(delta * Frequency * Constant)
			local Sine_Angle = sin(delta * Frequency * Constant)

			self._currentLinearPosition[i] = (
				Offset * Cosin_Angle
				+ (Velocity + Offset * (Damping * Frequency)) * Sine_Angle / (Frequency * Constant)
			)
					* Decay
				+ linearTargetPosition[i]
			self._velocity = (
				Velocity * (Cosin_Angle * Constant) - (Velocity * Damping + Offset * Frequency) * Sine_Angle
			) * (Decay / Constant)
		else -- Overdamped
			local Constant = sqrt(Damping * Damping - 1)

			local Root1 = -Frequency * (Damping - Constant)
			local Root2 = -Frequency * (Damping + Constant)

			local Coefficient2 = (Velocity - Offset * Root1) / (2 * Frequency * Constant)
			local Coefficient1 = Offset - Coefficient2

			local Exp1 = Coefficient1 * exp(Root1 * delta)
			local Exp2 = Coefficient2 * exp(Root2 * delta)

			self._currentLinearPosition[i] = Exp1 + Exp2 + linearTargetPosition[i]
			self._velocity = Root1 * Exp1 + Root2 * Exp2
		end
	end
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	-- Return the unpacked format for improved clarity
	return Storage.AnimatableDataTypes[self._type].FromLinear(self._currentLinearPosition)
end

--[[
	@param target PublicTypes.State
	@param springInfo PublicTypes.SpringInfo
	@return Spring PublicTypes.Spring
]]
local function Spring(springInfo: PublicTypes.SpringInfo): PublicTypes.Spring?
	if not Is.API(springInfo.State) then
		Debugger.Error("APIExpected", "State", typeof(springInfo.State))
		return nil
	end

	local self = setmetatable({} :: InternalTypes.SpringInternal<PublicTypes.State>, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"

	self._damping = springInfo.Damping or 1
	self._frequency = springInfo.Frequency or 3
	self._velocity = springInfo.Velocity or 0
	self._state = springInfo.State
	self._type = typeof(springInfo.State:Get())
	self._currentLinearPosition = {}

	return self
end

-- // Returning
return Spring
