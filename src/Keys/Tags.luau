-- // Returning
return {
	KeyName = "Tags",
	ApplyKey = function(instance: Instance, value: { string })
		for _, tag in value do
			-- Loop over provided tags and add it to instance
			instance:AddTag(tag)
		end
	end,
}
