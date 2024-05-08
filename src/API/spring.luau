--[[
	Forked from https://github.com/DervexDev/AdvancedSpring
	Thank you @DervexDev!
]]

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
local Debugger = require(Utility.Debugger)
local Storage = require(Runtime.Storage)
local Is = require(Utility.Is)

-- // Variables
local Class = {}

local Epsilon = 1e-4

local sqrt = math.sqrt
local exp = math.exp
local cos = math.cos
local sin = math.sin
local pi = math.pi

-- // Functions
local function IsSpringSettled(
	currentLinearPosition: { number },
	linearTargetPosition: { number },
	instance: Instance,
	prop: string,
	dataTypePosition: InternalTypes.Animatable
): boolean
	local IsSettled = false

	if (instance :: any)[prop] == dataTypePosition then
		IsSettled = true
	end

	for index, value in currentLinearPosition do
		if IsSettled == true then
			break
		end

		if math.abs(value - linearTargetPosition[index]) < Epsilon then
			-- If the difference is less than the epsilon, then settle the spring
			IsSettled = true
			break
		end
	end

	return IsSettled
end

function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	local Mode = RunService:IsClient() and "Client" or "Server"
	local Connection: ((number) -> ())?

	local LinearTargetPosition = self._type.ToLinear(self._state:Get());
	(instance :: any)[prop] = self._state:Get()
	self._currentLinearPosition = LinearTargetPosition

	self._state:Listen(function(_, newValue)
		LinearTargetPosition = self._type.ToLinear(newValue)

		if Connection ~= nil then
			return -- The value changed when the spring was playing; don't create another connection.
		end

		if not Connection then
			Connection = Scheduler:Add(Mode, function(delta: number)
				self:_update(LinearTargetPosition, delta);
				(instance :: any)[prop] = self._type.FromLinear(self._currentLinearPosition)

				if
					IsSpringSettled(
							self._currentLinearPosition,
							LinearTargetPosition,
							instance,
							prop,
							self._state:Get() :: InternalTypes.Animatable
						)
						== true
					and Connection ~= nil
				then
					print("settled")
					Scheduler:Remove(Mode, Connection)
					Connection = nil;
					(instance :: any)[prop] = self._state:Get()
				end
			end)
		end
	end)
end

function Class._update(
	self: InternalTypes.SpringInternal<PublicTypes.State>,
	linearTargetPosition: { number },
	delta: number
)
	for i = 1, #linearTargetPosition do
		-- DO NOT CHANGE ANYTHING IN THE CALCULATION UNLESS YOU KNOW WHAT YOU ARE DOING
		local Damping = self._damping
		local Frequency = 2 * pi * self._frequency
		local Velocity = self._velocity

		local Decay = exp(-delta * Damping * Frequency)
		local Offset = self._currentLinearPosition[i] - linearTargetPosition[i]

		if Damping == 1 then -- Critical damping
			self._currentLinearPosition[i] = (Velocity[i] * delta + Offset * (Frequency * delta + 1)) * Decay
				+ linearTargetPosition[i]
			self._velocity[i] = (Velocity[i] - (Offset * Frequency + Velocity[i]) * (Frequency * delta)) * Decay
		elseif Damping < 1 then -- Underdamped
			local Constant = sqrt(1 - Damping * Damping)
			local Cosin_Angle = cos(delta * Frequency * Constant)
			local Sine_Angle = sin(delta * Frequency * Constant)

			self._currentLinearPosition[i] = (
				Offset * Cosin_Angle
				+ (Velocity[i] + Offset * (Damping * Frequency)) * Sine_Angle / (Frequency * Constant)
			)
					* Decay
				+ linearTargetPosition[i]
			self._velocity[i] = (
				Velocity[i] * (Cosin_Angle * Constant) - (Velocity[i] * Damping + Offset * Frequency) * Sine_Angle
			) * (Decay / Constant)
		else -- Overdamped
			local Constant = sqrt(Damping * Damping - 1)

			local Root1 = -Frequency * (Damping - Constant)
			local Root2 = -Frequency * (Damping + Constant)

			local Coefficient2 = (Velocity[i] - Offset * Root1) / (2 * Frequency * Constant)
			local Coefficient1 = Offset - Coefficient2

			local Exp1 = Coefficient1 * exp(Root1 * delta)
			local Exp2 = Coefficient2 * exp(Root2 * delta)

			self._currentLinearPosition[i] = Exp1 + Exp2 + linearTargetPosition[i]
			self._velocity[i] = Root1 * Exp1 + Root2 * Exp2
		end
	end
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	-- Return the unpacked format for improved clarity
	return self._type.FromLinear(self._currentLinearPosition)
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
	self._state = springInfo.State
	self._type = Storage.AnimatableDataTypes[typeof(springInfo.State:Get())]
	self._currentLinearPosition = self._type.ToLinear(self._state:Get())
	self._velocity = table.create(#self._currentLinearPosition, (springInfo.Velocity or 20))

	return self
end

-- // Returning
return Spring
