--[[
	Forked from https://github.com/DervexDev/AdvancedSpring
	Thank you @DervexDev!
]]

-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Aegis = script.Parent.Parent
local Runtime = Aegis.Runtime
local Utility = Aegis.Utility

-- // Dependencies
local Scheduler = require(Runtime.Scheduler)
local Storage = require(Runtime.Storage)

local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

local Types = require(Aegis.Types)

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

function Class._init(self: Types.Spring, prop: string, instance: Instance)
	local Mode = RunService:IsClient() and "Client" or "Server"
	local Connection: ((number) -> ())?

	local TargetLinearPosition = self._type.ToLinear(self._state:Get())
	local CurrentValue = self._state:Get()

	if CurrentValue ~= nil then
		(instance :: any)[prop] = CurrentValue
	end
	self._currentLinearPosition = TargetLinearPosition

	self._state:Listen(function(newValue)
		TargetLinearPosition = self._type.ToLinear(newValue)

		if Connection ~= nil then
			return -- The value changed when the spring was playing; don't create another connection, let the new one play
		end

		if not Connection then
			Connection = Scheduler:Add(Mode, function(delta: number)
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

function Class._update(self: Types.Spring, targetLinearPosition: { number }, delta: number)
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
	@return nil
]]
function Class.Destroy(self: Types.Spring): nil
	self._state:Destroy()
	Utils.CleanMetatable(self :: any)
	return nil
end

--[[
	@param target Types.State
	@param springInfo Types.SpringInfo
	@return Spring
]]
local function spring(springInfo: Types.SpringInfo): Types.Spring
	-- Checks
	if Is.AegisConstructor(springInfo.State :: any) == false then
		Debugger.Error("TypeMismatch", "Aegis.State", typeof(springInfo.State))
	end

	local Type = Storage.AnimatableDataTypes[typeof(springInfo.State:Get())]

	if not Type then
		Debugger.Error("NotAnimatable", typeof(springInfo.State:Get()))
	end

	local self = setmetatable({} :: Types.SpringProps, { __index = Class } :: { __index: Types.SpringFunc })

	self.ConstructorClass = "spring"

	self._damping = springInfo.Damping or 1
	self._frequency = springInfo.Frequency or 1
	self._state = springInfo.State

	self._type = Type
	self._currentLinearPosition = self._type.ToLinear(springInfo.State:Get())

	self._velocity = table.create(#self._currentLinearPosition, 0)

	return self
end

-- // Returning
return spring
