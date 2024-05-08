-- // Folders
local API = script.API
local Keys = script.Keys

-- // Returning
return table.freeze({
	-- API
	component = require(API.component),
	spring = require(API.spring),
	state = require(API.state),
	new = require(API.new),

	-- Keys
	Tags = require(Keys.Tags),
	Events = require(Keys.Events),
	Changes = require(Keys.Changes),
	Children = require(Keys.Children),
	Attributes = require(Keys.Attributes),
})
