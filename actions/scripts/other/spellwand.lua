-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Random outfit wand
-- Notes: Fixed table length, break chance, and effect display

local config = {
	outfits = {"rat", "green frog", "chicken"}, -- possible outfits
	duration = 45, -- duration of the outfit in seconds
	breakChance = 1 -- percent chance of losing the wand
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	-- Chance to break wand
	if math.random(1, 100) <= config.breakChance then
		doSummonCreature("Sheep", toPosition) -- fallback summon
		doRemoveItem(item.uid, 1)
		return true
	end

	-- Apply random outfit to player
	if isPlayer(itemEx.uid) then
		local outfit = config.outfits[math.random(1, #config.outfits)]
		doSetMonsterOutfit(itemEx.uid, outfit, config.duration * 1000)
		doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
	end

	return true
end
