-- Extra
export type Key = {
	KeyName: string,
	ApplyKey: (instance: Instance, value: any) -> (),
}

export type Constructor = {
	_init: (self: any, prop: string, instance: Instance) -> (),
	Get: (self: any) -> any,
	ConstructorClass: string,
}

export type Animatable = number | UDim2 | UDim | Vector3 | Vector3int16 | Vector2 | Vector2int16 | Color3

-- State types
export type StateFunc = {
	_init: (self: State, prop: string, instance: Instance) -> (),
	Get: (self: State) -> any,
	Set: (self: State, newValue: any) -> State,
	Listen: (self: State, fn: (oldValue: any, newValue: any) -> ()) -> State,
	Destroy: (self: State) -> (),
}

export type StateProps = {
	ConstructorClass: "State",
	_state: any,
	_listeners: { (newValue: any, oldValue: any) -> () },
	_protectType: boolean,
}

export type State = typeof(setmetatable({} :: StateProps, {} :: { __index: StateFunc }))

-- Spring types
export type SpringFunc = {
	_init: (self: Spring, prop: string, instance: Instance) -> (),
	Get: (self: Spring) -> any,
	_update: (self: Spring, linearTargetPosition: { number }, delta: number) -> (),
	Destroy: (self: Spring) -> (),
}

export type SpringProps = {
	ConstructorClass: "Spring",
	_state: State,
	_damping: number,
	_frequency: number,
	_velocity: { number },
	_currentLinearPosition: { number },
	_type: {
		ToLinear: (value: Animatable) -> { number },
		FromLinear: (value: { number }) -> Animatable,
	},
}

export type Spring = typeof(setmetatable({} :: SpringProps, {} :: { __index: SpringFunc }))

return "Aegis.Types.Internal"
