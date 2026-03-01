-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Handle extended opcode for client language
-- Notes: Supports multi-language OTClient, safe for other opcodes

local OPCODE_LANGUAGE = 1

function onExtendedOpcode(cid, opcode, buffer)
	if opcode == OPCODE_LANGUAGE then
		-- OTClient language support
		if buffer == 'de' or buffer == 'en' or buffer == 'es' or buffer == 'pl' or buffer == 'pt' or buffer == 'sv' then
			-- Example: setting player language
			-- Uncomment and implement storage if desired:
			-- doCreatureSetStorage(cid, CREATURE_STORAGE_LANGUAGE, buffer)
		end
	else
		-- Other opcodes ignored safely
	end
end
