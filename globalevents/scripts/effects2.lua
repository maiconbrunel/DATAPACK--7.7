function onThink(interval, lastExecution)
local texts = {
	[" Sword"] = {{x=32363, y=32241, z=6}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_RED},
	[" Axe"] = {{x=32366, y=32241, z=6}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_GREEN},
	[" Magic"] = {{x=32375, y=32241, z=6}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_BLUE},
	[" Club"] = {{x=32369, y=32241, z=6}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_YELLOW},
	[" Distance"] = {{x=32372, y=32241, z=6}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_LIGHTBLUE}
}

for text, param in pairs(texts) do
	doSendAnimatedText(param[1], text, param[3])
	doSendMagicEffect(param[1], param[2])
	end

    return true
end


