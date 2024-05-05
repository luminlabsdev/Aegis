local InternalTypes = require(script.Parent.InternalTypes)

export type SpringInfo = {
	Damping: number?,
	Frequency: number?,
	Velocity: number?,
	State: State,
}

export type AegisInstance = typeof(setmetatable(
	{} :: InternalTypes.InstanceInternal,
	{} :: { __index: InternalTypes.InstanceClass }
))
export type Component = typeof(setmetatable(
	{} :: InternalTypes.ComponentInternal,
	{} :: { __index: InternalTypes.ComponentClass }
))
export type State = typeof(setmetatable({} :: InternalTypes.StateInternal, {} :: { __index: InternalTypes.StateClass }))
export type Spring = typeof(setmetatable(
	{} :: InternalTypes.SpringInternal<State>,
	{} :: { __index: InternalTypes.SpringClass<State> }
))

return "Aegis.Types.Public"
