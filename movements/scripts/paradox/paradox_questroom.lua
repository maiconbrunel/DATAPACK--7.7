-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Step-in quest progression triggers
-- Notes: melhorias, atualizações da API, otimizações

local EFFECT_ID = 5 -- magic effect sparkle

local POS = {
	[8011] = Position(32477, 31900, 1), -- Phoenix Egg
	[8012] = Position(32478, 31900, 1), -- 10k gold
	[8013] = Position(32479, 31900, 1), -- 32 Talons
	[8014] = Position(32480, 31900, 1), -- Wand of Cosmic
}

function onStepIn(creature, item, position, fromPosition)
local action = item.actionid
local pos = POS[action]
if not pos then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		player:setStorageValue(action, 1)
		pos:sendMagicEffect(EFFECT_ID)

		return true
		end
