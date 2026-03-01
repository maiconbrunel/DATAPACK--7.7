-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: IP conversion utilities
-- Notes: Converts integer ↔ IP string and handles subnet masks, reversed IPs

function doConvertIntegerToIp(int, mask)
	local b = {
		bit.urshift(bit.uband(int, 4278190080), 24),
		bit.urshift(bit.uband(int, 16711680), 16),
		bit.urshift(bit.uband(int, 65280), 8),
		bit.urshift(bit.uband(int, 255), 0)
	}
	if mask then
		local m = {
			bit.urshift(bit.uband(mask, 4278190080), 24),
			bit.urshift(bit.uband(mask, 16711680), 16),
			bit.urshift(bit.uband(mask, 65280), 8),
			bit.urshift(bit.uband(mask, 255), 0)
		}
		if (m[1] == 255 or m[1] == 0) and (m[2] == 255 or m[2] == 0) and (m[3] == 255 or m[3] == 0) and (m[4] == 255 or m[4] == 0) then
			for i = 1, 4 do
				if m[i] == 0 then
					b[i] = "*"
				end
			end
		elseif (m[1] ~= 255 or m[2] ~= 255 or m[3] ~= 255 or m[4] ~= 255) then
			return b[4] .. "." .. b[3] .. "." .. b[2] .. "." .. b[1] .. ":" .. m[4] .. "." .. m[3] .. "." .. m[2] .. "." .. m[1]
		end
	end
	return b[4] .. "." .. b[3] .. "." .. b[2] .. "." .. b[1]
end

function doConvertIpToInteger(str)
	local maskIndex = str:find(":")
	if not maskIndex then
		local ip, mask, index = 0, 0, 24
		for b in str:gmatch("([x%d]+)%.?") do
			if b ~= "x" then
				if b:find("x") then return 0,0 end
				local t = tonumber(b)
				if not t or t < 0 or t > 255 then return 0,0 end
				mask = bit.ubor(mask, bit.ulshift(t, index))
				ip = bit.ubor(ip, bit.ulshift(t, index))
			end
			index = index - 8
			if index < 0 then break end
		end
		if index ~= -8 then return 0,0 end
		return ip, mask
	end

	if maskIndex <= 1 then return 0,0 end

	local ipString = str:sub(1, maskIndex - 1)
	local maskString = str:sub(maskIndex + 1)
	local ip, mask, index = 0, 0, 0
	for b in ipString:gmatch("(%d+)%.?") do
		local t = tonumber(b)
		if not t or t < 0 or t > 255 then return 0,0 end
		ip = bit.ubor(ip, bit.ulshift(t, index))
		index = index + 8
		if index > 24 then break end
	end
	if index ~= 32 then return 0,0 end

	index = 0
	for b in maskString:gmatch("(%d+)%.?") do
		local t = tonumber(b)
		if not t or t < 0 or t > 255 then return 0,0 end
		mask = bit.ubor(mask, bit.ulshift(t, index))
		index = index + 8
		if index > 24 then break end
	end
	if index ~= 32 then return 0,0 end

	return ip, mask
end

function doRevertIp(str)
	local i, ip = 4, {}
	for b in str:gmatch("(%d+).?") do
		ip[i] = b
		i = i - 1
	end
	if not ip[1] or not ip[2] or not ip[3] or not ip[4] then return nil end
	return table.concat(ip, ".")
end
