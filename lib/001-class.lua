-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Object-oriented helper for class creation
-- Notes: Fixed parent reference, compatible with Lua 5.1/5.2/5.3

function createClass(parent)
	local newClass = {}
	local baseClass = parent -- fixed undefined baseClass

	-- Constructor
	function newClass:new(instance)
		local instance = instance or {}
		setmetatable(instance, {__index = newClass})
		return instance
	end

	-- Inheritance
	if parent ~= nil then
		setmetatable(newClass, {__index = parent})
	end

	-- Get self reference
	function newClass:getSelf()
		return newClass
	end

	-- Get parent reference
	function newClass:getParent()
		return baseClass
	end

	-- Check inheritance
	function newClass:isa(class)
		local tmp = newClass
		while tmp ~= nil do
			if tmp == class then
				return true
			end
			tmp = tmp:getParent()
		end
		return false
	end

	-- Set multiple attributes
	function newClass:setAttributes(attributes)
		for k, v in pairs(attributes) do
			newClass[k] = v
		end
	end

	return newClass
end
