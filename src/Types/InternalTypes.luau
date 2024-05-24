-- Instance types
export type InstanceClass = {
	ReadComponent: (self: InstanceInternal, component: ComponentInternal) -> InstanceInternal,
	ApplyProps: (self: InstanceInternal, propertyTable: { [any]: any }) -> InstanceInternal,
	Get: (self: InstanceInternal) -> Instance,
}
export type InstanceInternal = {
	AegisName: "Instance",

	Instance: Instance,
	Component: ComponentInternal,
} & InstanceClass & API<InstanceInternal>

-- Component types
export type ComponentClass = {
	AcceptFunctions: (self: ComponentInternal, functionalTable: { (...any) -> any }) -> ComponentInternal,
	CreateControls: (self: ComponentInternal, controls: {}) -> ComponentInternal,
	ApplyProps: (self: ComponentInternal, propertyTable: {}) -> ComponentInternal,
	AcceptClasses: (self: ComponentInternal, classes: {}) -> ComponentInternal,
}

export type ComponentInternal = {
	Functions: { (...any) -> any },
	AcceptedClasses: { string },
	Properties: { [any]: any },
	Controls: { [any]: any },
} & ComponentClass & API<ComponentInternal>

-- State types
export type StateClass = {
	Get: (self: StateInternal) -> any,
	Set: (self: StateInternal, newValue: any) -> (),
	Listen: (self: StateInternal, fn: (oldValue: any, newValue: any) -> ()) -> (),
}

export type StateInternal = {
	_state: any,
	_listeners: { (oldValue: any, newValue: any) -> () },
	_protectType: boolean,
} & StateClass & API<StateInternal>

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
} & SpringClass<State> & API<SpringInternal<State>>

-- Extra
export type Key = {
	KeyName: string,
	ApplyKey: (instance: Instance, index: any, value: any) -> (),
}

export type API<self> = {
	APIName: string,
	_initapi: (self: self, prop: string, instance: Instance) -> (),
	Get: (self: self) -> any,
}

export type Animatable = number | UDim2 | UDim | Vector3 | Vector3int16 | Vector2 | Vector2int16

return "Aegis.Types.Internal"
