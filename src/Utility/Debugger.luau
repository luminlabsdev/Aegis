-- // Variables
local Logs = {
	TypeMismatch = "Expected type (%s); received (%s)",
	MissingChild = "Could not find (%s) in (%s).",
	FailedToBuild = "Failed to create instance with class name (%s); Result: %s",
	EmptyState = "Cannot create an empty state.",
	-- FailedToAssignProp = "Failed to assign property (%s)",
}
local Debugger = {}

-- // Functions
function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		warn(`[Robax warning] {string.format(FoundId, ...)}`)
	end
end

function Debugger.Error(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		error(`[Robax error] {string.format(FoundId, ...)}`)
	end
end

-- // Returning
return Debugger
