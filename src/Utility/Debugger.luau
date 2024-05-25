-- // Variables
local Logs = {
	TypeMismatch = "Expected type (%s); received (%s)",
	MissingChild = "Could not find (%s) in (%s).",
	FailedToBuild = "Failed to create instance with class name (%s); Result: %s",
	ServiceExpected = "Expected to receive an Aegis.%s type. Received %s",
	NotAnimatable = "DataType '%s' cannot be animated.",
	ClassNotAccepted = "Instance class (%s) is not accepted by the component. Accepted classes:\n%s",
	FailedToRegisterKey = "Failed to register key. Reason: %s",
}
local Debugger = {}

-- // Functions
function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		warn(`\n[Aegis warning] {string.format(FoundId, ...)}\nAt -> {debug.traceback()}`)
	end
end

function Debugger.Error(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		error(`\n[Aegis error] {string.format(FoundId, ...)}\nAt -> {debug.traceback()}`)
	end
end

-- // Returning
return Debugger
