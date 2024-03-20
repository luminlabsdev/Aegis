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
function Class.Update(self: InternalTypes.SpringInternal<PublicTypes.State>, t: number, instance: any, prop: string)
	-- Mathematical terms
	local u = self._speed -- speed
	local v = self._velocity -- velocity
	local c = self._damping -- damping
	local x = (self._target - self._position) -- position
	local m = self._mass -- mass
	local k = self._elasticity -- spring constant

	--[[ Acceleration calculation:

		We know,	F = -kx
		Again,		F = -cv

		If we add the 2,	F = -kx - cv
						or, F = -(kx + cv)
						or, ma = -(kx + cv)
				Therefore,	a = -(kx + cv) / m
	]]
	local a = -((k * x) + (c * u)) / m

	--[[ Displacement calculation:

		We know, S = ut + (0.5 * at^2)
	]]
	local S = (u * t) + (0.5 * a * (t ^ 2))

	--[[ Velocity calculation

		We know, velocity,	v = u + at
		where,				u = initial velocity
							a = acceleration
							t = time

		Here, u is the previous velocity and deltaTime is the time (seconds)
	]]
	self._velocity = v + (a * t)

	--[[ Position calculation:

		We know, distance,	s = ut + (1 / 2) * a * (t^2)
		where,				u = initial velocity
							t = time
							a = acceleration
		
		We add the displacement to the current position
	]]
	self._position = self._position + S
	instance[prop] = self._position
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	return self._position
end

function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	self._state:Listen(function(_, newValue)
		print(newValue)
		self._target = newValue
	end)

	RunService.Heartbeat:Connect(function(deltaTime)
		self:Update(deltaTime, instance, prop)
		print(self._position)
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

	return self
end

-- // Returning
return Spring
