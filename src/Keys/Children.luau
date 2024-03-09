-- // Returning
return {
	SubClass = "Children",
	Apply = function(
		instance: Instance,
		index: any,
		value: any,
		Utils: {
			ApplyNormalProperty: (Instance, string, any) -> (),
			ApplySpecialKeyProperty: (Instance, any, any) -> (),
		}
	)
		if type(index) == "string" then
			Utils.ApplyNormalProperty(instance, index, value)
		elseif type(index) == "table" then
			Utils.ApplySpecialKeyProperty(instance, index, value)
		end
	end,
}
