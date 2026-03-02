-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Timed transform of a lever/stone
-- Notes: melhorias, atualizações da API, otimizações

local POS_MAIN   = Position(32478, 31902, 7)
local POS_CHECK  = Position(32478, 31906, 7)

local ITEM_MAIN_DEFAULT = 1304 -- item padrão
local ITEM_MAIN_ACTIVE  = 1385 -- item ativado
local ITEM_CHECK_ID     = 2782 -- item de validação

local function changeBack()
local tile = Tile(POS_MAIN)
if tile then
	local item = tile:getItemById(ITEM_MAIN_ACTIVE)
	if item then
		item:transform(ITEM_MAIN_DEFAULT)
		end
		end
		end

		function onStepIn(creature, item, position, fromPosition)
		if item.actionid == 8008 then
			local tileCheck = Tile(POS_CHECK)
			local tileMain = Tile(POS_MAIN)

			if tileCheck and tileMain then
				local checkItem = tileCheck:getItemById(ITEM_CHECK_ID)
				local mainItem  = tileMain:getItemById(ITEM_MAIN_DEFAULT)

				if checkItem and mainItem then
					addEvent(changeBack, 45000)
					mainItem:transform(ITEM_MAIN_ACTIVE)
					return true
					end
					end
					end

					creature:sendCancelMessage(" ")
					return true
					end
