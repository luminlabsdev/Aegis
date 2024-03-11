-- // Returning
return {
	ClassName = "Robax.Keys",
	SubClass = "Attributes",
	Apply = function(instance: Instance, _, value: { [string]: any })
		for attributeName, val in value do
			-- Loop over provided attributes and set it to instance
			instance:SetAttribute(attributeName, val)
		end
	end,
}
