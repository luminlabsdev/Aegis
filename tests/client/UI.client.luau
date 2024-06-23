-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local Player = Players.LocalPlayer

local new = Aegis.new
local Key = Aegis.Key
local State = Aegis.state
local Spring = Aegis.spring

-- // UI
local LoadingGUI = Aegis.new("ScreenGui", {
	Name = "LoadingGUI",
	IgnoreGuiInset = false,
	Parent = Player:WaitForChild("PlayerGui"),
})

task.wait(10)
print("changing")

Aegis.Update(LoadingGUI, {
	Name = "MenuGUI",
	IgnoreGuiInset = true,
})
