-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)

-- // Returning
return {
	KeyName = "Children",
	ApplyKey = function(instance: Instance, value: any)
		local Type = typeof(value)

		if Type == "table" then
			for _, descendant in value do
				if Is.API(descendant) and descendant.AegisName == "Instance" then
					descendant:Get().Parent = instance
				else
					Utils.CheckTypeAndCall(descendant, instance, function()
						descendant.Parent = instance
					end)
				end
			end
		elseif Type == "Instance" then
			Utils.CheckTypeAndCall(value, instance, function()
				value.Parent = instance
			end)
		end
	end,
}
