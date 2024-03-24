-- // Folders
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local Utils = require(Utility.Utils)
local Is = require(Utility.Is)
local InternalTypes = require(Utility.InternalTypes)

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
		if type(index) == "string" then
			-- Index the property
			local Property = (instance :: any)[index]
			local IsAPI = Is.API(value)

			if IsAPI == true then -- Check if the value is an API
				print(Property, value:Get())
				-- Call the _apply method of the API class.
				Utils.CheckTypeAndCall(Property, value:Get(), function()
					(value :: InternalTypes.API<typeof(value)>):_apply(index, instance)
				end)
			elseif IsAPI == false then -- if it's a normal property, just check the type and set the value
				Utils.CheckTypeAndCall(Property, value, function()
					(instance :: any)[index] = value
				end)
			end
		elseif Is.Key(index) == true then
			if (index :: InternalTypes.Key).AegisName == "Children" then
				if type(value) == "table" then
					for _, v: Instance in value do
						print(v)
						CheckTypeAndParent(v, instance)
					end
				elseif typeof(value) == "Instance" then
					CheckTypeAndParent(value, instance)
				end
			end
		end
	end,
}
