-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local PublicTypes = require(Utility.PublicTypes)
local InternalTypes = require(Utility.InternalTypes)
local Calculation = require(Utility.Calculation)
local Is = require(Utility.Is)
local Debugger = require(Utility.Debugger)

-- // Variables
local Class = {}

-- // Functions
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

	local S: any
	local DataType = typeof(x)

	if DataType == "UDim2" then
		local S_xScale = Calculation.CalculateDisplacement(k, x.X.Scale, c, u, m, t)
		local S_xOffset = Calculation.CalculateDisplacement(k, x.X.Offset, c, u, m, t)

		local S_yOffset = Calculation.CalculateDisplacement(k, x.Y.Offset, c, u, m, t)
		local S_yScale = Calculation.CalculateDisplacement(k, x.Y.Scale, c, u, m, t)

		S = UDim2.new(
			Calculation.ReturnAbsoluteDisplacement(x.X.Scale, S_xScale),
			Calculation.ReturnAbsoluteDisplacement(x.X.Offset, S_xOffset),
			Calculation.ReturnAbsoluteDisplacement(x.Y.Scale, S_yScale),
			Calculation.ReturnAbsoluteDisplacement(x.Y.Offset, S_yOffset)
		)
	elseif DataType == "UDim" then
		local S_Scale = Calculation.CalculateDisplacement(k, x.Scale, c, u, m, t)
		local S_Offset = Calculation.CalculateDisplacement(k, x.Offset, c, u, m, t)

		S = UDim.new(
			Calculation.ReturnAbsoluteDisplacement(x.Scale, S_Scale),
			Calculation.ReturnAbsoluteDisplacement(x.Offset, S_Offset)
		)
	elseif DataType == "Vector3" then
		local SX = Calculation.CalculateDisplacement(k, x.X, c, u, m, t)
		local SY = Calculation.CalculateDisplacement(k, x.Y, c, u, m, t)
		local SZ = Calculation.CalculateDisplacement(k, x.Z, c, u, m, t)

		S = Vector3.new(
			Calculation.ReturnAbsoluteDisplacement(x.X, SX),
			Calculation.ReturnAbsoluteDisplacement(x.Y, SY),
			Calculation.ReturnAbsoluteDisplacement(x.Z, SZ)
		)
	elseif DataType == "Vector2" then
		local SX = Calculation.CalculateDisplacement(k, x.X, c, u, m, t)
		local SY = Calculation.CalculateDisplacement(k, x.Y, c, u, m, t)

		S = Vector2.new(
			Calculation.ReturnAbsoluteDisplacement(x.X, SX),
			Calculation.ReturnAbsoluteDisplacement(x.Y, SY)
		)
	elseif DataType == "number" then
		S = Calculation.ReturnAbsoluteDisplacement(x, Calculation.CalculateDisplacement(k, x, c, u, m, t))
	end

	self._position = self._position + S
	instance[prop] = self._position
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	return self._position
end

function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	(instance :: any)[prop] = self._state:Get()

	self._state:Listen(function()
		local ComparablePos = Calculation.ReturnComparableValue(self._position)
		local ComparableTarget = Calculation.ReturnComparableValue(self._state:Get())
		local IsGreater: boolean = ComparableTarget > ComparablePos

		self._connection = RunService[(if RunService:IsClient() then "RenderStepped" else "Heartbeat")]:Connect(
			function(deltaTime)
				self:Update(deltaTime, instance, prop)
				if self._connection ~= nil then
					if
						(IsGreater and ComparablePos >= ComparableTarget)
						or (not IsGreater and ComparablePos <= ComparableTarget)
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
local function Spring(state: PublicTypes.State, springInfo: PublicTypes.SpringInfo): PublicTypes.Spring?
	if not Is.API(state) then
		Debugger.Error("APIExpected", 1, "State", typeof(state))
		return nil
	end

	local self = setmetatable({} :: InternalTypes.SpringInternal<PublicTypes.State>, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"

	springInfo = springInfo or {}

	self._damping = springInfo.Damping or 1
	self._speed = springInfo.Speed or 1
	self._elasticity = springInfo.Elasticity or 1
	self._mass = springInfo.Mass or 1
	self._state = state
	self._position = state:Get()
	self._connection = nil

	return self
end

-- // Returning
return Spring
