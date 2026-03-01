-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Random item transformation
-- Notes: Fixed random selection and transformation logic

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local randomChoice = math.random(1, 2)

	if itemEx.itemid == 7528 then
		doTransformItem(itemEx.uid, 7529)
	elseif itemEx.itemid == 7529 then
		if randomChoice == 1 then
			doTransformItem(itemEx.uid, 7530)
		else
			doTransformItem(itemEx.uid, 7531)
		end
	elseif itemEx.itemid == 7530 then
		if randomChoice == 1 then
			doTransformItem(itemEx.uid, 7532)
		else
			doTransformItem(itemEx.uid, 7533)
		end
	elseif itemEx.itemid == 7532 then
		if randomChoice == 1 then
			doTransformItem(itemEx.uid, 7534)
		else
			doTransformItem(itemEx.uid, 7535)
		end
	end

	return true
end
