-- // Dependencies
local Debugger = require(script.Parent.Debugger)
local Utils = require(script.Parent.Utils)

-- // Functions
local function Build(className: string, props: { [any]: any }): Instance?
	local Success, Result = pcall(Instance.new, className)

	if Success then
		for prop, value in props do
			if type(prop) == "string" then
				if prop == "Parent" then
					continue
				end

				Utils.ApplyNormalProperty(Result, prop, value)
			elseif type(prop) == "table" and prop.ClassName == "Robax.Keys" and prop.SubClass then
				Utils.ApplySpecialKeyProperty(Result, prop, value)
			end
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
