-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Random gift box system
-- Notes: Fixed random selection and count handling

local config = {
	-- blue
	[6570] = {		
		{ rate = 1132, item = 6280, count = { const = 1 }},
		{ rate = 1132, item = 2114, count = { const = 1 }},
		{ rate = 991, item = 6575, count = { const = 1 }},
		{ rate = 943, item = 6576, count = { const = 1 }},
		{ rate = 991, item = 6578, count = { const = 1 }},
		{ rate = 991, item = 6572, count = { const = 1 }},
		{ rate = 802, item = 6577, count = { const = 1 }},
		{ rate = 802, item = 2687, count = { const = 10 }},
		{ rate = 849, item = 6569, count = { const = 3 }},
		{ rate = 755, item = 6574, count = { const = 1 }},
		{ rate = 613, item = 6394, count = { const = 1 }}
	},
	-- red
	[6571] = {
		{ rate = 4745, item = 6576, count = { const = 1 }},
		{ rate = 2072, item = 6394, count = { const = 1 }},
		{ rate = 1152, item = 6574, count = { const = 1 }},
		{ rate = 1017, item = 6578, count = { const = 1 }},
		{ rate = 538, item = 2114, count = { const = 1 }},
		{ rate = 20, item = 2112, count = { const = 1 }},
		{ rate = 17, item = 2195, count = { const = 1 }},
		{ rate = 17, item = 5080, count = { const = 1 }},
		{ rate = 15, item = 2520, count = { const = 1 }},
		{ rate = 7, item = 2173, count = { const = 1 }},
		{ rate = 17, item = 2492, count = { const = 1 }},
		{ rate = 167, item = 2153, count = { const = 1 }},
		{ rate = 37, item = 2156, count = { const = 1 }},
		{ rate = 159, item = 5944, count = { const = 1 }},
		{ rate = 7, item = 6566, count = { const = 1 }},
		{ rate = 13, item = 2498, count = { const = 1 }}
	},
}

local sumOfRate = {}

for itemid, items in pairs(config) do
	local total = 0
	for _, v in ipairs(items) do
		total = total + v.rate
	end
	sumOfRate[itemid] = total
end

local function randomGift(itemid)
	local rand = math.random(1, sumOfRate[itemid])
	local subSum = 0

	for i, v in ipairs(config[itemid]) do
		subSum = subSum + v.rate
		if rand <= subSum then
			return i
		end
	end

	return #config[itemid] -- fallback in case of rounding errors
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if not config[item.itemid] then
		return false
	end

	local giftIndex = randomGift(item.itemid)
	local gift = config[item.itemid][giftIndex]

	local amount = 1
	if gift.count.const then
		amount = gift.count.const
	elseif gift.count.min and gift.count.max then
		amount = math.random(gift.count.min, gift.count.max)
	end

	doPlayerAddItem(cid, gift.item, amount)
	doSendMagicEffect(fromPosition, CONST_ME_GIFT_WRAPS)
	doRemoveItem(item.uid, 1)

	return true
end
