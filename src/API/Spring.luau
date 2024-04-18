-- // Services
local RunService = game:GetService("RunService")

-- // Folders
local Utility = script.Parent.Parent.Utility
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Animation = require(Utility.Animation)
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

-- // Variables
local Class = {}

-- // Functions
function Class._apply(self: InternalTypes.SpringInternal<PublicTypes.State>, prop: string, instance: Instance)
	local ConnectionSignal = (RunService:IsClient() and "RenderStepped") or "Heartbeat"
	local TargetPosition_Packed, PositionDataType;
	(instance :: any)[prop] = self._state:Get()

	self._state:Listen(function(oldValue, newValue)
		TargetPosition_Packed, PositionDataType = Utils.PackDataType(self._state:Get())

		self._connection = (RunService[ConnectionSignal] :: RBXScriptSignal):Connect(function(deltaTime: number)
			self:_update(TargetPosition_Packed, PositionDataType, deltaTime);
			(instance :: any)[prop] = self._currentPosition.Unpacked

			if Animation.IsSpringSettled(self, TargetPosition_Packed) == true and self._connection ~= nil then
				self._connection:Disconnect()
			end
		end)
	end)
end

function Class._update(
	self: InternalTypes.SpringInternal<PublicTypes.State>,
	targetPosition_Packed: { number },
	positionDataType: string,
	deltaTime: number
)
	for i = 1, #targetPosition_Packed do
		local NewPosition, NewVelocity =
			Animation.NumberSpringStep(self, self._currentPosition.Packed[i], targetPosition_Packed[i])

		self._currentPosition.Packed[i] = NewPosition
	end

	self._currentPosition.Unpacked = Utils.UnpackDataType(self._currentPosition.Packed, positionDataType)
end

function Class.Get(self: InternalTypes.SpringInternal<PublicTypes.State>)
	-- Return the unpacked format for improved clarity
	return self._currentPosition.Unpacked
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

	local self = setmetatable({} :: InternalTypes.SpringInternal<PublicTypes.State>, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"

	self._stiffness = springInfo.Stiffness or 1
	self._speed = springInfo.Speed or 1
	self._mass = springInfo.Mass or 1
	self._state = springInfo.State
	self._currentPosition = {
		Unpacked = self._state:Get(),
		Packed = Utils.PackDataType(self._state:Get()),
	}
	self._connection = nil

	return self
end

-- // Returning
return Spring
