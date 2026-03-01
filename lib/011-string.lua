-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: String extensions and boolean helper
-- Notes: Fixed table.maxn usage, trimmed strings, added boolean conversion

-- Split string by words
string.split = function(str)
	local t = {}
	str:gsub("%w+", function(s) table.insert(t, s) end)
	return t
end

-- Trim whitespace
string.trim = function(str)
	return str:gsub("^%s*(.-)%s*$", "%1")
end

-- Explode string by separator with optional limit
string.explode = function(str, sep, limit)
	if type(sep) ~= 'string' or #str == 0 or #sep == 0 then
		return {}
	end

	local i, pos, tmp, t = 0, 1, "", {}
	for s, e in function() return string.find(str, sep, pos) end do
		tmp = str:sub(pos, s - 1):trim()
		table.insert(t, tmp)
		pos = e + 1

		i = i + 1
		if limit ~= nil and i == limit then
			break
		end
	end

	tmp = str:sub(pos):trim()
	table.insert(t, tmp)
	return t
end

-- Expand $variable to _G variable
string.expand = function(str)
	return string.gsub(str, "$(%w+)", function(n) return _G[n] end)
end

-- Convert seconds to formatted time differences
string.diff = function(diff)
	local format = {
		{"week", diff / 60 / 60 / 24 / 7},
		{"day", diff / 60 / 60 / 24 % 7},
		{"hour", diff / 60 / 60 % 24},
		{"minute", diff / 60 % 60},
		{"second", diff % 60}
	}

	local t = {}
	for k, v in ipairs(format) do
		local d = math.floor(v[2])
		if d > 0 then
			local sep = (k < #format and (#t > 0 and ", " or "") or " and ")
			table.insert(t, sep .. d .. " " .. v[1] .. (d ~= 1 and "s" or ""))
		end
	end

	return t
end
string.timediff = string.diff

-- Convert any input to boolean
string.boolean = function(input)
	local tmpType = type(input)
	if tmpType == 'boolean' then
		return input
	elseif tmpType == 'number' then
		return input > 0
	end

	local str = string.lower(tostring(input))
	return (str == "yes" or str == "true" or (tonumber(str) ~= nil and tonumber(str) > 0))
end

getBooleanFromString = string.boolean
