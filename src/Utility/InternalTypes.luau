-- local PublicTypes = require(script.Parent.PublicTypes)

-- State types
export type StateClass = {
	Get: <T>(self: StateInternal) -> T,
	Set: (self: StateInternal, newValue: any) -> (),
	Listen: (self: StateInternal, fn: (oldValue: any, newValue: any) -> ()) -> (),
} & API<StateInternal>

export type StateInternal = {
	AegisClass: "API",
	AegisName: "State",

	_state: any,
	_listeners: { (oldValue: any, newValue: any) -> () },
	_protectType: boolean,
} & StateClass

-- Spring types
export type SpringClass<State> = {
	Update: (self: SpringInternal<State>, deltaTime: number) -> (),
} & API<SpringInternal<State>>

export type SpringInternal<State> = {
	AegisClass: "API",
	AegisName: "Spring",

	_state: State,
	_damping: number,
	_speed: number,
	_elasticity: number,
	_mass: number,

	_position: number,
	_target: number,
	_velocity: number,
} & SpringClass<State>

-- Extra
export type Key = {
	AegisClass: "Key",
	AegisName: string,
	Apply: (instance: Instance, index: any, value: any) -> (),
}

export type API<self> = {
	AegisClass: "API",
	AegisName: string,
	_apply: (self: self, prop: string, instance: Instance) -> (),
}

return "Aegis.Types.Internal"
