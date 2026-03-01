local config = {
	loginMessage = configManager.getString(configKeys.LOGIN_MESSAGE),
	useFragHandler = configManager.getBoolean(configKeys.USE_FRAG_HANDLER)
}

function onLogin(player)
-- Remove Account Manager if disabled
if not configManager.getBoolean(configKeys.ACCOUNT_MANAGER) then
	if player:getName() == "Account Manager" then
		player:remove()
		return true
		end
		end

		-- Death loss percent
		local loss = configManager.getNumber(configKeys.DEATH_LOST_PERCENT)
		if loss and loss > 0 then
			player:setLossPercent(LOSS_EXPERIENCE, loss * 10)
			end

			--------------------------------------------------------------------
			-- Account Manager Logic
			--------------------------------------------------------------------
			local accManagerState = player:getAccountManager()

			if accManagerState == ACCOUNTMANAGER_NONE then
				local lastLogin = player:getLastLoginSaved()

				if lastLogin > 0 then
					player:sendTextMessage(MESSAGE_STATUS_DEFAULT, config.loginMessage)

					local dateText = string.format(
						"Your last visit was on %s.",
						os.date("%a %b %d %X %Y", lastLogin)
					)
					player:sendTextMessage(MESSAGE_STATUS_DEFAULT, dateText)
					else
						local message = string.format("%s Please choose your outfit.", config.loginMessage)
						player:sendTextMessage(MESSAGE_STATUS_DEFAULT, message)
						player:sendOutfitWindow()
						end

						elseif accManagerState == ACCOUNTMANAGER_NAMELOCK then
							addEvent(function()
							if player then
								player:say(
									"Hello, it appears that your character has been locked for violating name rules. What new name would you like to have?",
				   TALKTYPE_PRIVATE_NP, false, player
								)
								end
								end, 500)

							elseif accManagerState == ACCOUNTMANAGER_ACCOUNT then
								addEvent(function()
								if player then
									player:say(
										"Hello, type 'account' to manage your account. If you would like to start over, type 'cancel' anywhere.",
					TALKTYPE_PRIVATE, false, player
									)
									end
									end, 500)

								else -- ACCOUNTMANAGER_NEW
									addEvent(function()
									if player then
										player:say(
											"Hello, type 'account' to create an account or 'recover' to recover an account.",
					 TALKTYPE_PRIVATE, false, player
										)
										end
										end, 500)
									end

									--------------------------------------------------------------------
									-- Login effect (if not in ghost mode)
									--------------------------------------------------------------------
									if not player:isGhost() then
										player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
										end

										--------------------------------------------------------------------
										-- Register creature events
										--------------------------------------------------------------------
										player:registerEvent("Idle")
										player:registerEvent("Mail")
										player:registerEvent("ReportBug")

										if config.useFragHandler then
											player:registerEvent("SkullCheck")
											end

											player:registerEvent("GuildEvents")
											player:registerEvent("AdvanceSave")
											player:registerEvent("mori")

											return true
											end
