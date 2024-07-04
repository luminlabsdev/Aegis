-- // Variables
local Debugger = {}
local Logs = {
	TypeMismatch = "Expected type (%s); received (%s)",
	MissingChild = "Could not find (%s) in (%s).",
	FailedToCreate = "Failed to create instance with class name (%s); Result: %s",
	ServiceExpected = "Expected to receive an Aegis.%s type. Received %s",
	RestrictedType = "DataType '%s' is not compatible.",
	FailedToRegisterKey = "Failed to register key. Reason: %s",
	KeyNotFound = "Key (%s) isn't registered.",
	MissingConstructor = "Missing a Aegis.%s constructor.",
	NotAnimatable = "Data type (%s) is not animatable. Change to an animatable data type.",
	CannotFindIndex = "Cannot find index (%s)",
	ConstructorNotSupported = "`%s` constructor is not supported.",
}

-- // Functions
function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		warn(`\n[AEGIS] {string.format(FoundId, ...)}\nAt -> {debug.traceback()}`)
	end
end

function Debugger.Error(id: string, ...: any)
	local FoundId = Logs[id] or nil :: string?

	if FoundId then
		error(`\n[AEGIS] {string.format(FoundId, ...)}\nAt -> {debug.traceback()}`)
	end
end

-- // Returning
return Debugger
