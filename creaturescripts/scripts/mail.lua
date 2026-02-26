-- mail.lua (TFS 1.5 - Downgrade 7.72)
function onMailReceive(player, fromPlayer, item, openBox)
if not player then
	return true
	end

	-- Safety check: ensure the mail item exists
	if not item then
		print("[Mail] Warning: Mail event triggered without valid item.")
		return true
		end

		-- Only send message if the mailbox is opened
		if openBox then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received new mail.")
			end

			return true
			end
