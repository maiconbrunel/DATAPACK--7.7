-- Player Death: Amulet of Loss Removal (TFS 1.5 Downgrade 7.72)

local AOLSLOT = CONST_SLOT_NECKLACE
local AOL_ID = 2173

function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
-- Safety: ensure valid player object
if not player or not player:isPlayer() then
	return true
	end

	-- Get item from necklace slot
	local amulet = player:getSlotItem(AOLSLOT)
	if amulet and amulet.itemid == AOL_ID then
		amulet:remove(1)
		end

		return true
		end
