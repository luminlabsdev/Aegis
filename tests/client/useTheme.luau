if not plugin then
	return
end

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Studio = settings().Studio

-- // Folders
local Packages = ReplicatedStorage.Packages

-- // Dependencies
local Aegis = require(Packages.Aegis)

-- // Variables
local StudioTheme = Aegis.state(Studio.Theme)

-- // Event Listeners
Studio.ThemeChanged:Connect(function()
	StudioTheme:Set(Studio.Theme)
end)

-- // Returning
return StudioTheme
