-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
local function LoopAndParent(t: any, parent: Instance)
	local Type = typeof(t)

	if Type == "table" then
		for _, descendant in t do
			LoopAndParent(descendant, parent)
		end
	elseif Type == "Instance" then
		Utils.CheckTypeAndCall(t, parent, function()
			(t :: Instance).Parent = parent
		end)
	end
end

-- // Returning
return {
	KeyName = "Children",
	ApplyKey = function(instance: Instance, value: any)
		LoopAndParent(value, instance)
	end,
}
