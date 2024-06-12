--[[
	Forked from https://github.com/DervexDev/AdvancedSpring
	Thank you @DervexDev!
]]

-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Runtime = script.Parent.Parent.Runtime
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Scheduler = require(Runtime.Scheduler)
local Storage = require(Runtime.Storage)

local Debugger = require(Utility.Debugger)
local Is = require(Utility.Is)

local Types = require(script.Parent.Parent.Types)

-- // Variables
local Class = {} :: Types.SpringFunc

local Epsilon = 1e-4

local sqrt = math.sqrt
local exp = math.exp
local cos = math.cos
local sin = math.sin
local pi = math.pi

-- // Functions
local function IsSpringSettled(currentLinearPosition: { number }, targetLinearPosition: { number }): boolean
	for index, value in currentLinearPosition do
		if math.abs(value - targetLinearPosition[index]) > Epsilon then
			-- If the difference is more than the epsilon, then return false
			return false
		end
	end

	return true
end

function Class._init(self: Types.Spring, prop: string, instance: Instance): ()
	local Mode = RunService:IsClient() and "Client" or "Server"
	local Connection: ((number) -> ())?

	local TargetLinearPosition = self._type.ToLinear(self._state:Get());
	(instance :: any)[prop] = self._state:Get()
	self._currentLinearPosition = TargetLinearPosition

	self._state:Listen(function(newValue): ()
		TargetLinearPosition = self._type.ToLinear(newValue)

		if Connection ~= nil then
			return -- The value changed when the spring was playing; don't create another connection, let the new one play
		end

		if not Connection then
			Connection = Scheduler:Add(Mode, function(delta: number): ()
				self:_update(TargetLinearPosition, delta);
				(instance :: any)[prop] = self._type.FromLinear(self._currentLinearPosition)

				if IsSpringSettled(self._currentLinearPosition, TargetLinearPosition) == true and Connection then
					Scheduler:Remove(Mode, Connection)
					Connection = nil;
					(instance :: any)[prop] = self._state:Get()

					for index = 1, #self._velocity do
						self._velocity[index] = 0
					end
				end
			end)
		end
	end)
end

function Class._update(self: Types.Spring, targetLinearPosition: { number }, delta: number): ()
	for index = 1, #targetLinearPosition do
		-- DO NOT CHANGE ANYTHING IN THE CALCULATION UNLESS YOU KNOW WHAT YOU ARE DOING
		--[[
			d = damping
			f = frequency
			v = velocity
			c = constant
			i = cosine_angle
			j = sine_angle
			r1 = root1
			r2 = root2
			c2 = coefficient2
			c1 = coefficient1
			e1 = exp1
			e2 = exp2
		]]

		local d = self._damping
		local f = self._frequency * pi * 2
		local g = targetLinearPosition[index]
		local p = self._currentLinearPosition[index]
		local v = self._velocity[index]

		local offset = p - g
		local decay = exp(-delta * d * f)

		if d == 1 then
			self._currentLinearPosition[index] = (v * delta + offset * (f * delta + 1)) * decay + g
			self._velocity[index] = (v - (offset * f + v) * (f * delta)) * decay
		elseif d < 1 then
			local c = sqrt(1 - d * d)
			local i = cos(delta * f * c)
			local j = sin(delta * f * c)

			self._currentLinearPosition[index] = (offset * i + (v + offset * (d * f)) * j / (f * c)) * decay + g
			self._velocity[index] = (v * (i * c) - (v * d + offset * f) * j) * (decay / c)
		else
			local c = sqrt(d * d - 1)
			local r1 = -f * (d - c)
			local r2 = -f * (d + c)
			local co2 = (v - offset * r1) / (2 * f * c)
			local co1 = offset - co2
			local e1 = co1 * exp(r1 * delta)
			local e2 = co2 * exp(r2 * delta)

			self._currentLinearPosition[index] = e1 + e2 + g
			self._velocity[index] = r1 * e1 + r2 * e2
		end
	end
end

--[[
	@return Position
]]
function Class.Get(self: Types.Spring): Types.Animatable
	-- Return the unpacked format for improved clarity
	return self._type.FromLinear(self._currentLinearPosition)
end

--[[
	@param target Types.State
	@param springInfo Types.SpringInfo
	@return Spring Types.Spring
]]
local function Spring(springInfo: Types.SpringInfo): Types.Spring?
	-- Checks
	if not springInfo.State then
		Debugger.Warn("MissingConstructor", "State")
		return nil
	end

	if not Is.AegisConstructor(springInfo.State :: any) then
		Debugger.Warn("TypeMismatch", "Aegis.State", typeof(springInfo.State))
		return nil
	end

	local Type = typeof(springInfo.State:Get())

	if not Storage.AnimatableDataTypes[Type] then
		Debugger.Warn("NotAnimatable", Type)
		return nil
	end

	local self = setmetatable({} :: Types.SpringProps, { __index = Class } :: { __index: Types.SpringFunc })

	self.ConstructorClass = "Spring"

	self._damping = springInfo.Damping or 1
	self._frequency = springInfo.Frequency or 1
	self._state = springInfo.State

	self._type = Storage.AnimatableDataTypes[Type]
	self._currentLinearPosition = self._type.ToLinear(self._state:Get())

	self._velocity = table.create(#self._currentLinearPosition, 0)

	return self
end

-- // Returning
return Spring
