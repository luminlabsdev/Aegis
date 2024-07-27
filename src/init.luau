-- FOLDERS >
local Constructors = script.Constructors
local Functions = script.Functions

-- DEPENDENCIES >
local Types = require(script.Types)

-- VARIABLES >
local RegisterKey = require(Functions.RegisterKey)

-- INITIALIZE >
for _, key in script.Keys:GetChildren() do
	RegisterKey(require(key) :: Types.Key)
end

-- EXPORTING >
export type Key = Types.Key
export type State = Types.State
export type Spring = Types.Spring
export type Compute = Types.Compute
export type Animatable = Types.Animatable
export type SpringInfo = Types.SpringInfo
export type DefaultKeys = Types.DefaultKeys
export type Component<T> = Types.Component<T>

--[[
	## Aegis
	A simple strictly typed UI framework made specifically for Roblox.
]]
return table.freeze({
	-- CONSTRUCTORS >
	new = require(Constructors.new),
	state = require(Constructors.state),
	spring = require(Constructors.spring),
	compute = require(Constructors.compute),

	-- FUNCTIONS >
	Update = require(Functions.Update),
	Key = require(Functions.Key),
	UnregisterKey = require(Functions.UnregisterKey),
	RegisterKey = RegisterKey,
})
