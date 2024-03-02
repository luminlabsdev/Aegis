--[[
	Modified from BasicState, huge thanks to https://github.com/cxmeel/BasicState
	Check out BasicState docs for more info: https://cxmeel.github.io/BasicState/
]]

-- // Variables
local State = {}

-- // Modifications
State.__index = State

-- // Functions
function State.Create(initialState: { [any]: any }, ProtectType: boolean?): State
	local self = setmetatable({} :: self, State)

	-- Linters are unhappy about JoinDictionary return type :<
	self.__initialState = (self :: any):__joinDictionary((type(initialState) == "table" and initialState) or {})
	self.__state = (self :: any):__joinDictionary(self.__initialState)

	self.__listeners = {}
	self.__protectType = ProtectType or false

	return self
end

function State.__joinDictionary(self: self, ...)
	local NewDictionary = {}

	for _, Dictionary in { ... } do
		-- Since it is a function to join dictionaries, check if it really is a table or not.
		if type(Dictionary) ~= "table" then
			continue
		end

		-- Loop over the dictionary for joining
		for Key, Value in Dictionary do
			-- Protect the types!
			if self.__protectType and NewDictionary[Key] and typeof(NewDictionary[Key]) ~= typeof(Value) then
				error(
					string.format(
						'attempt to set "%s" to new value type "%s". Disable State.ProtectType to allow this.',
						tostring(Key),
						typeof(Value)
					),
					2
				)
			end

			--[[
				Check if the type of the value inside the dictionary is another table or not.
				If it is, call the function again
			]]
			if type(Value) == "table" then
				NewDictionary[Key] = self.__joinDictionary(NewDictionary[Key], Value)
				continue
			end

			-- Finally after all the nested joining and such, set the value to the new dictionary's assigned key.
			NewDictionary[Key] = Value
		end
	end

	return NewDictionary :: { [any]: any }
end

function State.Set(self: self, Key: any, newValue: any)
	local OldState = self:Get()

	if OldState == newValue then
		return
	end

	if self.__protectType then
		if OldState[Key] and typeof(newValue) ~= typeof(OldState[Key]) then
			error(
				string.format(
					'attempt to set "%s" to new value type "%s". Disable State.ProtectType to allow this.',
					tostring(Key),
					typeof(newValue)
				),
				2
			)
		end
	end

	if type(newValue) == "table" then
		newValue = self:__joinDictionary(OldState[Key], newValue)
	end

	local OldValue = self.__state[Key]

	self.__state[Key] = newValue

	for _, listener: (oldValue: any, newValue: any) -> () in self.__listeners do
		listener(OldValue, newValue)
	end
end

function State.Get(self: self, Key: any?)
	local Dictionary = self.__joinDictionary(self, self.__state)

	if not Key then
		return Dictionary
	else
		return Dictionary[Key]
	end
end

function State.Listen(self: self, Key: any, fn: (oldValue: any, newValue: any) -> ())
	self.__listeners[Key] = (self :: any).__listeners[Key] or {} -- Have to define it as 'any' because of type checking

	local ListenerTable = self.__listeners[Key] :: { [number]: () -> () } | any
	local Index = (#ListenerTable + 1);
	(ListenerTable :: { [number]: () -> () })[Index] = fn

	return (ListenerTable :: { [number]: () -> () })[Index] -- Returns the function
end

-- // Types
type self = {
	__initialState: { [any]: any },
	__state: { [any]: any },
	__listeners: { [any]: () -> () },
	__protectType: boolean,

	__joinDictionary: (self: self, ...any) -> { [any]: any },
	Get: (self: self, Key: any?) -> any,
}

export type State = typeof(setmetatable({} :: self, State))

-- // Returning
return State
