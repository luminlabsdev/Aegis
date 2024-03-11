-- // Returning
return {
	ClassName = "Robax.Keys",
	SubClass = "Tags",
	Apply = function(instance: Instance, _, value: { string })
		for _, tag in value do
			-- Loop over provided tags and add it to instance
			instance:AddTag(tag)
		end
	end,
}
