-- // Dependencies
local Utility = script.Parent.Parent.Utility
local Debugger = require(Utility.Debugger)
local Keys = require(script.Parent.Parent.Keys)
local Children = Keys.Children
local Ref = Keys.Ref

-- // Functions
--[[
	@param className The class name of the instance to create
	@param props The property table of the instance which is to be applied
	@return Instance
]]
local function Build(className: string, props: { [any]: any }?): Instance?
	local Success, Result = pcall(Instance.new, className) -- Create the instance wrapped inside pcall

	if Success == true then -- if it's successfully created
		if props ~= nil then
			local RefLoaded = false
			if props[Ref] ~= nil then
				print(props[Ref]:Get())
				Children.Apply(Result, nil, props[Ref])
				RefLoaded = true
				print(props[Ref]:Get())
			else
				RefLoaded = true
			end

			repeat
				task.wait()
			until RefLoaded == true

			for prop, value in props do
				-- loop over props table if provided, and apply the Children key to the result
				if prop == ("Parent" or Ref) then
					print(prop)
					continue -- Skip if it's the parent property
				else
					Children.Apply(Result, prop, value)
				end
			end

			if props.Parent ~= nil then
				-- If parent property is given, then set it.
				Result.Parent = props.Parent
			end
		end

		return Result
	else
		-- If it wasn't successful, error it because instance creation has to be complete.
		Debugger.Error("FailedToBuild", className, Result)
		return nil
	end
end

-- // Returning
return Build
