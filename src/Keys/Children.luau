-- // Dependencies
local Utils = require(script.Parent.Parent.Utility.Utils)

-- // Functions
local function CheckTypeAndParent(instance: Instance, ancestor: Instance)
	if typeof(instance) == "Instance" and typeof(ancestor) == "Instance" then
		instance.Parent = ancestor
	end
end

-- // Returning
return {
	AegisClass = "Key",
	AegisName = "Children",
	Apply = function(instance: Instance, index: any, value: any)
		if type(index) == "string" and index ~= "Parent" then
			Utils.ApplyNormalProperty(instance, index, value)
		elseif type(index) == "table" and index.AegisClass and index.AegisName then
			if index.AegisClass == "Key" then
				if index.AegisName == "Children" then
					if type(value) == "table" then
						for _, v: Instance in value do
							CheckTypeAndParent(v, instance)
						end
					elseif typeof(value) == "Instance" then
						CheckTypeAndParent(value, instance)
					end
				else
					Utils.ApplySpecialKeyProperty(instance, index, value)
				end
			elseif index.AegisClass == "API" then
				index:_apply(index, instance)
			end
		end
	end,
}
