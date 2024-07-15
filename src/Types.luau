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

export type PropertyTable = { 
	[string | Key]: any,
	BackgroundTransparency: number,
	Transparency: number | NumberSequence,
	Offset: Vector2,
	Color3: Color3,
	BackgroundColor3: Color3,
	TextColor3: Color3,
	AnchorPoint: Vector2,
	ClipsDescendants: boolean,
	Visible: boolean,
	ZIndex: number,
	Size: UDim2,
	Position: UDim2,
	Rotation: number,
	Name: string,
	AspectRatio: number,
	AspectType: Enum.AspectType,
	DominantAxis: Enum.DominantAxis,
	CornerRadius: UDim,
	Color: Color3 | ColorSequence,
	Enabled: boolean,
	Parent: Instance,
	SizeConstraint: Enum.SizeConstraint,
	AutomaticCanvasSize: Enum.AutomaticSize,
	CanvasSize: UDim2,
	ElasticBehavior: Enum.ElasticBehavior,
	FillDirection: Enum.FillDirection,
	FillDirectionMaxCells: number,
	SortOrder: Enum.SortOrder,
	StartCorner: Enum.StartCorner,
	HorizontalAlignment: Enum.HorizontalAlignment,
	VerticalAlignment: Enum.VerticalAlignment,
	PaddingBottom: UDim,
	PaddingLeft: UDim,
	PaddingRight: UDim,
	PaddingTop: UDim,
	Image: string,
	ImageColor3: Color3,
	ImageTransparency: number,
	Texture: string,
	Font: Enum.Font,
	Text: string,
	TextSize: number,
	TextWrapped: boolean,
	TextScaled: boolean,
	TextXAlignment: Enum.TextXAlignment,
	TextYAlignment: Enum.TextYAlignment,
	BorderColor3: Color3,
	BorderSizePixel: number,
	SelectionImageObject: Instance,
	AutoButtonColor: boolean,
	Modal: boolean,
	MultiLine: boolean,
	ClearTextOnFocus: boolean,
	ShowNativeInput: boolean,
	TextEditable: boolean,
	TextStrokeColor3: Color3,
	TextStrokeTransparency: number,
	PlaceholderText: string,
	PlaceholderColor3: Color3,
	CanvasPosition: Vector2,
	ScrollBarImageColor3: Color3,
	ScrollBarImageTransparency: number,
	ScrollBarThickness: number,
	TopImage: string,
	MidImage: string,
	BottomImage: string,
	SliceCenter: Rect,
	SliceScale: number,
	ScaleType: Enum.ScaleType,
	TileSize: UDim2,
	TextTransparency: number,
	LineHeight: number,
	LineColor3: Color3,
	LineThickness: number,
	MaxVisibleGraphemes: number,
	TextBounds: Vector2,
	FontSize: Enum.FontSize,
	BackgroundColor: Color3,
	CursorPosition: number,
	SelectionStart: number,
	NextSelectionUp: GuiObject,
	NextSelectionDown: GuiObject,
	NextSelectionLeft: GuiObject,
	NextSelectionRight: GuiObject,
	OverlayFrame: GuiObject,
	IsLoaded: boolean,
	AutoLocalize: boolean,
	LocalizeText: string,
	ResampleMode: Enum.ResamplerMode,
	AnimationId: string,
	Looped: boolean,
	Playing: boolean,
	TimePosition: number,
	Volume: number,
	Pitch: number,
	SoundGroup: SoundGroup,
	PlaybackSpeed: number,
	SourceAssetId: string,
	TransparencyModifySize: boolean,
	RootLocalizationTable: LocalizationTable,
	ThreeSliceCenter: Rect,
	TileLayout: boolean,
	TileSizeX: number,
	TileSizeY: number,
	ZOffset: number,
	Archivable: boolean,
	Active: boolean,
	Adornee: Instance,
	AlwaysOnTop: boolean,
	Face: unknown, -- couldnt find the enum lol
	MaxDistance: number,
	ResetOnSpawn: boolean,
	['ZIndex Behavior']: Enum.ZIndexBehavior,
	PixelsPerStud: number,
	LineJoinMode: Enum.LineJoinMode,
	Thickness: number,
	ApplyStrokeMode: Enum.ApplyStrokeMode,
	FillEmptySpaceColumns: boolean,
	FillEmptySpaceRows: boolean,
	MaxTextSize: number,
	MinTextSize: number,
	CurrentCamera: Camera,
	Video: string,
}
export type ChildrenTable = { [string | any]: any }

export type DefaultKeys = "Ref" | "Events" | "Changes" | "Cleanup" | "Attributes" | "Tags"
export type ClassName =
	"CanvasGroup"
	| "Frame"
	| "TextButton"
	| "TextLabel"
	| "ScrollingFrame"
	| "TextBox"
	| "VideoFrame"
	| "ViewportFrame"
	| "ImageButton"
	| "ImageLabel"
	| "BillboardGui"
	| "ScreenGui"
	| "SurfaceGui"
	| "UICorner"
	| "UIGradient"
	| "UIPadding"
	| "UIScale"
	| "UIStroke"
	| "UIGridLayout"
	| "UIListLayout"
	| "UIPageLayout"
	| "UITableLayout"
	| string

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
