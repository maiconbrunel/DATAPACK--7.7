local s = {  -- [ACTIONID] = {"MENSAJE", NIVEL REQUERIDO}
[4010] = {"Tu necesitas tener nivel ", 2},
[4011] = {"Tu necesitas tener nivel ", 2},
}
        function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
            local b = s[item.actionid]
            if b then
                if getPlayerLevel(cid) < b[2] and isplayer(cid) then
              doTeleportThing(cid, fromPosition)
              doSendMagicEffect(getCreaturePosition(cid), 2)
              doCreatureSay(cid, " "..b[1].." "..b[2].." para poder pasar", TALKTYPE_ORANGE_2) -- mensaje que le dirá al que no pueda pasar
              else
              doCreatureSay(cid, "Go", TALKTYPE_ORANGE_2)
          end
          return true
      end
  end