-- // Folders
local Constructors = script.Constructors
local Functions = script.Functions

-- // Dependencies
local Types = require(script.Types)

-- // Variables
local Aegis = {
	-- Constructors
	new = require(Constructors.new),
	state = require(Constructors.state),
	spring = require(Constructors.spring),
	compute = require(Constructors.compute),

	-- Functions
	Update = require(Functions.Update),
	Key = require(Functions.Key),
	RegisterKey = require(Functions.RegisterKey),
	UnregisterKey = require(Functions.UnregisterKey),
}

-- // Initialize
for _, key in script.Keys:GetChildren() do
	Aegis.RegisterKey(require(key) :: Types.Key)
end

-- // Exporting
export type Key = Types.Key
export type State = Types.State
export type Spring = Types.Spring
export type Compute = Types.Compute
export type SpringInfo = Types.SpringInfo
export type Animatable = Types.Animatable
export type DefaultKeys = Types.DefaultKeys

return table.freeze(Aegis)
