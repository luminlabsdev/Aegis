-- Extra
export type Animatable =
	boolean
	| number
	| BrickColor
	| CFrame
	| Vector3
	| Vector2
	| UDim2
	| UDim
	| Color3
	| Vector3int16
	| Vector2int16
	| ColorSequence
	| NumberSequence
	| NumberRange
	| Rect

export type DefaultKeys = "Ref" | "Events" | "Changes" | "Cleanup" | "Attributes" | "Tags"

export type Key = {
	KeyName: DefaultKeys | string,
	ApplyKey: (instance: Instance, value: any) -> (),
}

export type Constructor = {
	_init: (self: any, prop: string, instance: Instance) -> (),
	Get: (self: any) -> any,
	Destroy: (self: any) -> (),
	ConstructorClass: string,
}

export type SpringInfo = {
	State: State,
	Damping: number?,
	Frequency: number?,
}

-- State types
export type StateFunc = {
	_init: (self: State, prop: string, instance: Instance) -> (),
	Get: (self: State) -> any,
	Set: (self: State, newValue: any) -> State,
	Listen: (self: State, fn: (newValue: any, oldValue: any) -> ()) -> () -> (),
	Destroy: (self: State) -> (),
}

export type StateProps = {
	ConstructorClass: "state",
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
	Destroy: (self: Spring) -> nil,
}

export type SpringProps = {
	ConstructorClass: "spring",
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

-- Compute types
export type ComputeFunc = {
	_init: (self: Compute, prop: string, instance: Instance) -> (),
	Get: (self: Compute) -> any,
	Destroy: (self: Compute) -> nil,
}

export type ComputeProps = {
	ConstructorClass: "compute",
	_processor: (get: (value: Constructor | any) -> ()) -> (),
	_dependencies: { [State | Spring | Constructor]: () -> () }?,
	_result: any,
	_instances: { [string]: Instance }?,
}

export type Compute = typeof(setmetatable({} :: ComputeProps, {} :: { __index: ComputeFunc }))

return {}
