-- // Folders
local Keys = script.Parent.Keys

-- // Dependencies
local Debugger = require(script.Parent.Debugger)
local Children = require(Keys.Children)

-- // Functions
local function Build(className: string, props: { [any]: any }): Instance?
	local Success, Result = pcall(Instance.new, className)

	if Success then
		for prop, value in props do
			if type(prop) == "string" and prop == "Parent" then
				continue
			end

			Children:Apply(Result, prop, value)
		end

		if props.Parent ~= nil then
			Result.Parent = props.Parent
		end

		return Result
	else
		Debugger.Error("FailedToBuild", className, Result)
		return nil
	end
end

-- // Returning
return Build
