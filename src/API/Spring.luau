-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local PublicTypes = require(Utility.PublicTypes)
local InternalTypes = require(Utility.InternalTypes)
local Animation = require(Utility.Animation)
local Is = require(Utility.Is)
local Debugger = require(Utility.Debugger)

-- // Variables
local Epsilon = 0.001
local Class = {}

-- // Functions
local function AnimateNumberDisplacement(k: number, x: number, c: number, u: number, t: number, m: number)
	local displacement = Animation.CalculateDisplacement(k, x, c, u, t, m)
	return Animation.ReturnAbsoluteDisplacement(x, displacement)
end

function Class.Update(self: InternalTypes.SpringInternal<PublicTypes.State>, t: number, instance: any, prop: string)
	-- Mathematical terms
	local u = self._speed -- speed
	local c = self._damping -- damping
	local x = (self._state:Get() :: any - self._position) -- position
	local m = self._mass -- mass
	local k = self._elasticity -- spring constant

	--[[ Position calculation:

		We know, displacement,	s = ut + (1 / 2) * a * (t^2)
		where,					u = initial velocity
								t = time
								a = acceleration
		
		We add the displacement to the current position
	]]

	local S: InternalTypes.Animatable
	local DataType = typeof(x)

	if DataType == "number" then
		S = AnimateNumberDisplacement(k, x, c, u, t, t)
	elseif DataType == "UDim2" then
		S = UDim2.new(
			AnimateNumberDisplacement(k, x.X.Scale, c, u, t, t),
			AnimateNumberDisplacement(k, x.X.Offset, c, u, t, t),
			AnimateNumberDisplacement(k, x.Y.Scale, c, u, t, t),
			AnimateNumberDisplacement(k, x.Y.Offset, c, u, t, t)
		)
	elseif DataType == "UDim" then
		S = UDim.new(
			AnimateNumberDisplacement(k, x.Scale, c, u, t, t),
			AnimateNumberDisplacement(k, x.Offset, c, u, t, t)
		)
	elseif DataType == "Vector3" then
		S = Vector3.new(
			AnimateNumberDisplacement(k, x.X, c, u, t, t),
			AnimateNumberDisplacement(k, x.Y, c, u, t, t),
			AnimateNumberDisplacement(k, x.Z, c, u, t, t)
		)
	elseif DataType == "Vector2" then
		S = Vector2.new(AnimateNumberDisplacement(k, x.X, c, u, t, t), AnimateNumberDisplacement(k, x.Y, c, u, t, t))
	end

	self._position = self._position :: any + S
	instance[prop] = self._position
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	return self._position
end

function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	(instance :: any)[prop] = self._state:Get()

	self._state:Listen(function()
		local ComparablePos = Animation.ReturnComparableValue(self._position)
		local ComparableTarget = Animation.ReturnComparableValue(self._state:Get())
		-- local IsGreater: boolean = ComparableTarget > ComparablePos

		self._connection = RunService[(if RunService:IsClient() then "RenderStepped" else "Heartbeat")]:Connect(
			function(deltaTime)
				ComparablePos = Animation.ReturnComparableValue(self._position)
				ComparableTarget = Animation.ReturnComparableValue(self._state:Get())
				self:Update(deltaTime, instance, prop)
				if type(self._position) == "number" then
					print(`Target: {ComparableTarget}`)
					print(`Position: {ComparablePos}`)
				end
				if self._connection ~= nil then
					if
						math.abs(ComparableTarget - ComparablePos) <= Epsilon
						-- (IsGreater and ComparablePos >= ComparableTarget)
						-- or (not IsGreater and ComparablePos <= ComparableTarget)
					then
						self._connection:Disconnect()
						self._position = self._state:Get()
						self:Update(deltaTime, instance, prop)
					end
				end
			end
		)
	end)
end

--[[
	@param target PublicTypes.State
	@param springInfo PublicTypes.SpringInfo
	@return Spring PublicTypes.Spring
]]
local function Spring(springInfo: PublicTypes.SpringInfo): PublicTypes.Spring?
	if not Is.API(springInfo.State) then
		Debugger.Error("APIExpected", 1, "State", typeof(springInfo.State))
		return nil
	end

	print(springInfo.State)

	local self = setmetatable({} :: InternalTypes.SpringInternal<PublicTypes.State>, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"

	self._damping = springInfo.Damping or 1
	self._speed = springInfo.Speed or 1
	self._elasticity = springInfo.Elasticity or 1
	self._mass = springInfo.Mass or 1
	self._state = springInfo.State
	self._position = self._state:Get()
	self._connection = nil

	return self
end

-- // Returning
return Spring
