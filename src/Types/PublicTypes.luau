local InternalTypes = require(script.Parent.InternalTypes)

export type SpringInfo = {
	Damping: number?,
	Frequency: number?,
	Velocity: number?,
	State: State,
}

export type State = typeof(setmetatable({} :: InternalTypes.StateInternal, {} :: { __index: InternalTypes.StateClass }))
export type Spring = typeof(setmetatable(
	{} :: InternalTypes.SpringInternal<State>,
	{} :: { __index: InternalTypes.SpringClass<State> }
))

return "Aegis.Types.Public"
