-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local MyState = Aegis.state(
	CFrame.new(
		-19.3999977,
		8.69644356,
		10.8699999,
		0.509962916,
		0.860196471,
		0,
		-0.532223463,
		0.315525889,
		-0.785609186,
		-0.675778151,
		0.400631547,
		0.618723154
	)
)
local CustomSpring = Aegis.spring({ State = MyState })

-- // Main
local Part = workspace.Part :: Part
Aegis.Update(Part, {
	CFrame = CustomSpring,
})

task.wait(5)
print("animating")
task.wait(1)

MyState:Set(
	CFrame.new(
		-9.01551628,
		6.97786474,
		10.869998,
		0.491626054,
		-0.11554049,
		0.863107324,
		-0.787276864,
		-0.5,
		-24,
		6,
		-5,
		-0.5
	)
)
