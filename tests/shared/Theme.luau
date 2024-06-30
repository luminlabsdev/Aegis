type Theme = {
	BackgroundMain: Color3,
	BackgroundAlt: Color3,
	Accent1: Color3,
	InnversedMain: Color3,
}

return {
	Light = {
		BackgroundMain = Color3.fromHex("#faf4ed"),
		BackgroundAlt = Color3.fromHex("#fffaf3"),

		InnversedMain = Color3.fromHex("#575279"),

		Accent1 = Color3.fromHex("#ff8547"),
	} :: Theme,
	Dark = {
		BackgroundMain = Color3.fromHex("#191724"),
		BackgroundAlt = Color3.fromHex("#1f1d2e"),

		InnversedMain = Color3.fromHex("#e0def4"),

		Accent1 = Color3.fromHex("#ff8547"),
	} :: Theme,
}
