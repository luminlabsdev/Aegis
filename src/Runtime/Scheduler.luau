-- // Services
local RunService = game:GetService("RunService")

-- // Dependencies
local Storage = require(script.Parent.Storage)

-- // Variables
local Scheduler = {}

-- // Functions
function Scheduler:Add(to: string, taskFn: (deltaTime: number) -> ())
	local Tab = Storage.Scheduler[to]

	table.insert(Tab.Active, taskFn)

	if not Tab.Connection then
		Tab.Connection = (RunService[if to == "Client" then "RenderStepped" else "Heartbeat"] :: RBXScriptSignal):Connect(
			function(deltaTime)
				for _, taskFunc in Tab.Active do
					taskFunc(deltaTime)
				end
			end
		)
	end

	return taskFn
end

function Scheduler:Remove(from: string, taskFn: (deltaTime: number) -> ())
	local Tab = Storage.Scheduler[from]
	local index = table.find(Tab.Active, taskFn)

	if index then
		table.remove(Tab.Active, index)

		if #Tab.Active == 0 and Tab.Connection then
			Tab.Connection:Disconnect()
			Tab.Connection = nil
		end
	end
end

return Scheduler
