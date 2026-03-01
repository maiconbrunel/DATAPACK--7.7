function onStepIn(cid, item, position, fromPosition)

local tileConfig = {
        kickPos = fromPosition,
        kickEffect = CONST_ME_POFF,
        kickMsg = "Usted necesita Premium!.",
        enterMsg = "bienvenido a la area Premium!",
        enterEffect = CONST_ME_MAGIC_BLUE,
}
	if isPremium(cid) == TRUE then
        doPlayerSendTextMessage(cid, 25, tileConfig.enterMsg)
        doSendMagicEffect(position, tileConfig.enterEffect)

        return
    end

        doTeleportThing(cid, tileConfig.kickPos)
        doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
        doPlayerSendCancel(cid, tileConfig.kickMsg)
        return true
end