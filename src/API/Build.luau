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

	if Success then -- if it's successfully created
		if props then
			if props[Ref] then
				Ref.Apply(Result, nil, props[Ref])
			end

			for prop, value in props do
				-- loop over props table if provided, and apply the Children key to the result
				if prop == "Parent" or prop == Ref then
					continue -- Skip if it's the parent property
				end

				Children.Apply(Result, prop, value)
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
