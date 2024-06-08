local InternalTypes = require(script.Parent.Internal)

export type State = InternalTypes.State
export type Spring = InternalTypes.Spring
export type Animatable = InternalTypes.Animatable

export type SpringInfo = {
	Damping: number?,
	Frequency: number?,
	Velocity: number?,
	State: State,
}

return "Aegis.Types.Public"
