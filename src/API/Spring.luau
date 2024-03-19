-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local PublicTypes = require(Utility.PublicTypes)
local InternalTypes = require(Utility.InternalTypes)
local Is = require(Utility.Is)
local Debugger = require(Utility.Debugger)

-- // Variables
local Class = {}

-- // Functions
function Class.Update(self: InternalTypes.SpringInternal<PublicTypes.State>, deltaTime: number)
	--[[ Displacement calculation:

		Here, we first find out the difference of the displacement between its current position and the target position
		Next, we multiply it with speed to get the ultimate result.
	]]
	-- local Displacement = (self._velocity * deltaTime) + 0.5 * self._speed * (deltaTime ^ 2)
	--[[ TotalForce calculation:

		According to Hooke's law,
		Force_Spring,	F = -k * x
		where,	k = spring constant (elasticity)
				x = displacement
		
		To calculate the displacement of the spring, we find out the difference between its current position and the target position

		Again, damping force is considered in a damped spring-mass system, which is proportional to the velocity of the mass. The damping force is given by:

		Force_Damping,	F = -c * v
		where,			c = damping co-efficient
						v = velocity

		Therefore, total force acting on the object will be:
		Force_Total	= Force_Spring + Force_Damping
					= -k * x + - c * v
	]]
	-- local TotalForce = -self._elasticity * Displacement - self._damping * self._velocity

	--[[ Acceleration calculation:

		According to Newton's second law of motion:
		Force,	F = m * a
		where,	m = mass of the body
				a = acceleration

		Here,	F = m * a
		Therefore,	a = F / m
	]]
	-- local Acceleration = TotalForce / self._mass

	--[[ Velocity calculation

		We know,
			Velocity, v = u + at
			where,	u = initial velocity
					a = acceleration
					t = time

		Here, u is the previous velocity and deltaTime is the time (seconds)
	]]

	-- self._velocity = self._velocity + Acceleration * deltaTime

	--[[ Position calculation:

		We know, distance,	s = ut + (1 / 2) * a * (t^2)
		where,				u = initial velocity
							t = time
							a = acceleration
		
		We add self._position again so that it changes its position with respect to previous position
	]]
	-- self._position = self._position + (self._velocity * deltaTime) + (0.5 * Acceleration * (deltaTime ^ 2))
end

function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	self._state:Listen(function(_, newValue)
		self._target = newValue
	end)
end

--[[
	@param target PublicTypes.State
	@param springInfo PublicTypes.SpringInfo
	@return Spring PublicTypes.Spring
]]
local function Spring(state: PublicTypes.State, springInfo: PublicTypes.SpringInfo): PublicTypes.Spring?
	if not Is.API(state) then
		Debugger.Error("APIExpected", 1, "State", typeof(state))
		return nil
	end

	local self = setmetatable({} :: InternalTypes.SpringInternal<PublicTypes.State>, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"

	self._state = state
	self._damping = springInfo.Damping or 1
	self._speed = springInfo.Speed or 1
	self._elasticity = springInfo.Elasticity or 0.5
	self._mass = springInfo.Mass or 1
	self._position = 0
	self._target = 0
	self._velocity = 0

	RunService:BindToRenderStep("__aegis.spring", Enum.RenderPriority.Input.Value + 1, function(deltaTime: number)
		self:Update(deltaTime)
	end)

	return self
end

-- // Returning
return Spring
