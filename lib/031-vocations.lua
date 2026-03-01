-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Vocation helper functions
-- Notes: Standardized vocation checks using 7.7 vocation IDs

function isSorcerer(cid)
	return table.isStrIn({1, 5}, getPlayerVocation(cid))
end

function isDruid(cid)
	return table.isStrIn({2, 6}, getPlayerVocation(cid))
end

function isPaladin(cid)
	return table.isStrIn({3, 7}, getPlayerVocation(cid))
end

function isKnight(cid)
	return table.isStrIn({4, 8}, getPlayerVocation(cid))
end

function isRookie(cid)
	return table.isStrIn({0}, getPlayerVocation(cid))
end
