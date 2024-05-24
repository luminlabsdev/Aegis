-- // Returning
return {
	KeyName = "Attributes",
	ApplyKey = function(instance: Instance, value: { [string]: any })
		for attributeName, val in value do
			-- Loop over provided attributes and set it to instance
			instance:SetAttribute(attributeName, val)
		end
	end,
}
