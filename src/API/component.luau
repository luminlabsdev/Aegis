-- // Folders
local Types = script.Parent.Parent.Types
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Debugger = require(Utility.Debugger)
local Utils = require(Utility.Utils)

-- // Variables
local Class = {}

-- // Functions
function Class.CreateControls(self: InternalTypes.ComponentInternal, controls: {})
	Utils.CheckTypeAndCall(controls, {}, function()
		self.Controls = controls
	end)

	return self
end

function Class.AcceptClasses(self: InternalTypes.ComponentInternal, classes: {})
	Utils.CheckTypeAndCall(classes, {}, function()
		self.AcceptedClasses = classes
	end)

	return self
end

function Class.AcceptFunctions(self: InternalTypes.ComponentInternal, functionalTable: { (...any) -> any })
	Utils.CheckTypeAndCall(functionalTable, {}, function()
		self.Functions = functionalTable
	end)

	return self
end

function Class.ApplyProps(self: InternalTypes.ComponentInternal, propertyTable: {})
	Utils.CheckTypeAndCall(propertyTable, {}, function()
		self.Properties = propertyTable
	end)

	return self
end

local function component(): PublicTypes.Component
	local self = setmetatable({} :: InternalTypes.ComponentInternal, { __index = Class })

	self.AcceptedClasses = {}
	self.Properties = {}
	self.Functions = {}
	self.Controls = {}

	return self
end

-- // Returning
return component
