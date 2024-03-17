-- // Dependencies
local Types = require(script.Parent.Parent.Types)

-- // Variables
local Class = {}

-- // Functions
function Class.Update(self: self) end

--[[
	@param springInfo
	@return Spring
]]
local function Spring(springInfo: Types.SpringInfo)
	local self = setmetatable({} :: self, { __index = Class })
	self.AegisClass = "API"
	self.AegisName = "Spring"
	self._damping = springInfo.Damping or 1
	self._tension = springInfo.Tension or 0.5
	self._mass = springInfo.Mass or 1
	self._position = 0
	self._target = 0
	self._velocity = 0
end

-- // Types
type self = {
	AegisClass: "API",
	AegisName: "Spring",

	_damping: number,
	_tension: number,
	_mass: number,

	_position: number,
	_target: number,
	_velocity: number,
}

export type Spring = typeof(setmetatable({} :: self, { __index = Class }))

-- // Returning
return Spring
