-- // Returning
return {
	SubClass = "Attributes",
	Apply = function(instance: Instance, _, value: { [string]: any })
		for attributeName, val in value do
			instance:SetAttribute(attributeName, val)
		end
	end,
}
