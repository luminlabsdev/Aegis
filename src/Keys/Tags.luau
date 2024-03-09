-- // Returning
return {
	SubClass = "Tags",
	Apply = function(instance: Instance, _, value: { string })
		for _, tag in value do
			instance:AddTag(tag)
		end
	end,
}
