-- Extended Opcode: Client Language Detection
-- Projeto 7.7 TFS 1.5 - Conversor Automático

local OPCODE_LANGUAGE = 1

local allowedLanguages = {
	de = true,
	en = true,
	es = true,
	pl = true,
	pt = true,
	sv = true,
}

function onExtendedOpcode(player, opcode, buffer)
-- Blindagem básica: valida player
if not player then
	return false
	end

	-- Processa somente o opcode registrado
	if opcode ~= OPCODE_LANGUAGE then
		return true
		end

		-- Blindagem: buffer precisa ser string válida
		if not buffer or type(buffer) ~= "string" then
			return true
			end

			-- Aceita somente linguagens conhecidas
			if allowedLanguages[buffer] then
				-- Exemplo: salvar como storage
				-- player:setStorageValue(Storage.PlayerLanguage, buffer)

				-- Debug opcional
				-- player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Client language: " .. buffer)
				end

				return true
				end
