-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Special tool usage with jam chance
-- Notes: Validates tool functions and applies random jam with decay

local config = {
	functions = {
		[10511] = { -- sneaky stabber of eliteness
			TOOLS.ROPE,
			TOOLS.SHOVEL,
			TOOLS.PICK,
			TOOLS.MACHETE,
			TOOLS.KNIFE
		},
		[10513] = { -- squeezing gear of girlpower
			TOOLS.ROPE,
			TOOLS.SHOVEL,
			TOOLS.PICK,
			TOOLS.MACHETE,
			TOOLS.SCYTHE
		},
		[10515] = { -- whacking driller of fate
			TOOLS.ROPE,
			TOOLS.SHOVEL,
			TOOLS.PICK,
			TOOLS.MACHETE,
			TOOLS.KNIFE
		}
	},
	jamChance = 10
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local funcs = config.functions[item.itemid]
	if not funcs then
		return false
	end

	local used = false
	for _, func in ipairs(funcs) do
		if func(cid, item, fromPosition, itemEx, toPosition) then
			used = true
			break
		end
	end

	if not used then
		return false
	end

	-- Apply jam chance
	if math.random(1, 100) <= config.jamChance then
		doTransformItem(item.uid, item.itemid + 1)
		doDecayItem(item.uid)
	end

	return true
end
