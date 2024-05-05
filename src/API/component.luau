-- // Folders
local Types = script.Parent.Parent.Types
local Utility = script.Parent.Parent.Utility

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)
local PublicTypes = require(Types.PublicTypes)
local Debugger = require(Utility.Debugger)
local Is = require(Utility.Is)

-- // Variables
local Class = {}

-- // Functions
function Class.CreateControls(self: InternalTypes.ComponentInternal, controls: {})
	if Is.TypeSame(controls, {}) then
		self.Controls = controls
	else
		Debugger.Warn("TypeMismatch", "table", typeof(controls))
	end

	return self
end

function Class.AcceptClasses(self: InternalTypes.ComponentInternal, classes: {})
	if Is.TypeSame(classes, {}) then
		self.AcceptedClasses = classes
	else
		Debugger.Warn("TypeMismatch", "table", typeof(classes))
	end

	return self
end

function Class.AcceptFunctions(self: InternalTypes.ComponentInternal, functionalTable: { (...any) -> any })
	if Is.TypeSame(functionalTable, {}) then
		self.Functions = functionalTable
	else
		Debugger.Warn("TypeMismatch", "table", typeof(functionalTable))
	end

	return self
end

function Class.ApplyProps(self: InternalTypes.ComponentInternal, propertyTable: {})
	if Is.TypeSame(propertyTable, {}) then
		self.Properties = propertyTable
	else
		Debugger.Warn("TypeMismatch", "table", typeof(propertyTable))
	end

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
