-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Show player instant spells grouped by level
-- Notes: Corrected mana display and level grouping

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local spellsList = {}

	-- Gather all spells with level > 0
	for i = 0, getPlayerInstantSpellCount(cid) - 1 do
		local spell = getPlayerInstantSpellInfo(cid, i)
		if spell.level ~= 0 then
			if spell.manapercent and spell.manapercent > 0 then
				spell.mana = spell.manapercent .. "%"
			elseif not spell.mana then
				spell.mana = "0"
			end
			table.insert(spellsList, spell)
		end
	end

	-- Sort by level ascending
	table.sort(spellsList, function(a, b) return a.level < b.level end)

	local text = ""
	local prevLevel = -1

	for i, spell in ipairs(spellsList) do
		local line = ""
		if prevLevel ~= spell.level then
			if i ~= 1 then
				line = "\n"
			end
			line = line .. "Spells for Level " .. spell.level .. "\n"
			prevLevel = spell.level
		end

		text = text .. line .. "  " .. spell.words .. " - " .. spell.name .. " : " .. spell.mana .. "\n"
	end

	doShowTextDialog(cid, item.itemid, text)
	return true
end
