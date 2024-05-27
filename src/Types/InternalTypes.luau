-- State types
export type StateClass = {
	Get: (self: StateInternal) -> any,
	Set: (self: StateInternal, newValue: any) -> StateInternal,
	Listen: (self: StateInternal, fn: (oldValue: any, newValue: any) -> ()) -> StateInternal,
}

export type StateInternal = {
	_state: any,
	_listeners: { (oldValue: any, newValue: any) -> () },
	_protectType: boolean,
} & StateClass & Service<StateInternal>

-- Spring types
export type SpringClass<State> = {
	_update: (self: SpringInternal<State>, linearTargetPosition: { number }, delta: number) -> (),
	Get: (self: SpringInternal<State>) -> (),
}

export type SpringInternal<State> = {
	_type: {
		ToLinear: (value: Animatable) -> { number },
		FromLinear: (value: { number }) -> Animatable,
	},
	_state: State,
	_damping: number,
	_velocity: { number },
	_time0: number,
	_frequency: number,
	_currentLinearPosition: { number },
} & SpringClass<State> & Service<SpringInternal<State>>

-- Extra
export type Key = {
	KeyName: string,
	ApplyKey: (instance: Instance, value: any) -> (),
}

export type Service<self> = {
	ServiceName: string,
	_initservice: (self: self, prop: string, instance: Instance) -> (),
	Get: (self: self) -> any,
}

export type Animatable = number | UDim2 | UDim | Vector3 | Vector3int16 | Vector2 | Vector2int16

return "Aegis.Types.Internal"
