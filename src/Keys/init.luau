-- // Variables
local Keys = {
	Children = require(script.Children),
	Events = require(script.Events),
	Changes = require(script.Changes),
	Attributes = require(script.Attributes),
	Tags = require(script.Tags),
}

-- // Initialize
--[[
	for name, key in Required do
		local Key = require(key) :: {
			SubClass: string,
			Apply: (instance: Instance, index: any, value: any) -> (),
		}

		if Key.SubClass and Key.Apply then
			Keys[Key.SubClass] = Key.Apply
		end
	end
]]

-- // Returning
return {
	GetKey = function(class: string)
		return Keys[class] or nil
	end,
	Keys = Keys,
}
