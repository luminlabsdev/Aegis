-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local state = Aegis.state
local compute = Aegis.compute

local MyState = state("Hello Aegis")
local MyCompute = compute(function(get)
	return get(MyState):len()
end, { MyState })

print(MyCompute:Get()) -- 11
MyState:Set("hi guys")
print(MyCompute:Get()) -- 7
