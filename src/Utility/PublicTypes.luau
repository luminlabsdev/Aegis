local InternalTypes = require(script.Parent.InternalTypes)

export type SpringInfo = {
	Damping: number?,
	Elasticity: number?,
	Speed: number?,
	Mass: number?,
	State: State,
}

export type State = typeof(setmetatable({} :: InternalTypes.StateInternal, {} :: { __index: InternalTypes.StateClass }))
export type Spring = typeof(setmetatable(
	{} :: InternalTypes.SpringInternal<State>,
	{} :: { __index: InternalTypes.SpringClass<State> }
))

return "Aegis.Types.Public"
