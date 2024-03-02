-- // Variables
local Logs = {
	Warnings = {},
	Errors = {},
}
local Debugger = {}

-- // Functions
function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs.Warnings[id] or nil :: string?

	if FoundId then
		warn(`[Robax] {string.format(FoundId, ...)}`)
	end
end

function Debugger.Warn(id: string, ...: any)
	local FoundId = Logs.Errors[id] or nil :: string?

	if FoundId then
		error(`[Robax] {string.format(FoundId, ...)}`)
	end
end

-- // Event Listeners
-- // Returning
