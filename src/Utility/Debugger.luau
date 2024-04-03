-- // Variables
local Logs = {
	TypeMismatch = "Expected type (%s); received (%s)",
	MissingChild = "Could not find (%s) in (%s).",
	FailedToBuild = "Failed to create instance with class name (%s); Result: %s",
	APIExpected = "Expected Argument#%d to be a API.%s type. Received %s",
	-- EmptyState = "Cannot create an empty state.",
	-- FailedToAssignProp = "Failed to assign property (%s)",
}
local Debugger = {}

-- // Functions
function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		warn(`\n[Aegis warning] {string.format(FoundId, ...)}\nAt -> [{debug.traceback()}]`)
	end
end

function Debugger.Error(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		error(`[Aegis error] {string.format(FoundId, ...)}`)
	end
end

-- // Returning
return Debugger
