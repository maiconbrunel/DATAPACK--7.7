-- [PROJECT 7.7 TFS 1.5] Unified globals, table helpers, math utilities, and legacy OO layer
-- Purpose: Single-file base for scripts; constants, helpers, math.round, table functions, and OO classes
-- Notes: Fully compatible with TFS 1.5 Downgrade 7.72 / Tibia 7.7

-- =====================
-- GLOBAL CONSTANTS
-- =====================

-- Directions
NORTH = 0; EAST = 1; SOUTH = 2; WEST = 3
SOUTHWEST = 4; SOUTHEAST = 5; NORTHWEST = 6; NORTHEAST = 7

-- Combat formulas
COMBAT_FORMULA_UNDEFINED = 0
COMBAT_FORMULA_LEVELMAGIC = 1
COMBAT_FORMULA_SKILL = 2
COMBAT_FORMULA_DAMAGE = 3

-- Conditions
CONDITION_NONE = 0
CONDITION_POISON = 1
CONDITION_FIRE = 2
CONDITION_ENERGY = 4
CONDITION_BLEEDING = 8
CONDITION_HASTE = 16
CONDITION_PARALYZE = 32
CONDITION_OUTFIT = 64
CONDITION_INVISIBLE = 128
CONDITION_LIGHT = 256
CONDITION_MANASHIELD = 512
CONDITION_INFIGHT = 1024
CONDITION_DRUNK = 2048
CONDITION_EXHAUST = 4096
CONDITION_FOOD = 8192
CONDITION_REGENERATION = 8192
CONDITION_SOUL = 16384
CONDITION_DROWN = 32768
CONDITION_MUTED = 65536
CONDITION_ATTRIBUTES = 131072
CONDITION_FREEZING = 262144
CONDITION_DAZZLED = 524288
CONDITION_CURSED = 1048576
CONDITION_PACIFIED = 2097152
CONDITION_GAMEMASTER = 4194304
CONDITION_HUNTING = 8388608
CONDITION_SPELLCOOLDOWN = 16777216
CONDITION_LOGINPROTECTION = 33554432

-- Player flags
PLAYERFLAG_CANNOTUSECOMBAT = 0
PLAYERFLAG_CANNOTATTACKPLAYER = 1
PLAYERFLAG_CANNOTATTACKMONSTER = 2
PLAYERFLAG_CANNOTBEATTACKED = 3
PLAYERFLAG_CANCONVINCEALL = 4
PLAYERFLAG_CANSUMMONALL = 5
PLAYERFLAG_CANILLUSIONALL = 6
PLAYERFLAG_CANSENSEINVISIBILITY = 7
PLAYERFLAG_IGNOREDBYMONSTERS = 8
PLAYERFLAG_NOTGAININFIGHT = 9
PLAYERFLAG_HASINFINITEMANA = 10
PLAYERFLAG_HASINFINITESOUL = 11
PLAYERFLAG_HASNOEXHAUSTION = 12
PLAYERFLAG_CANNOTUSESPELLS = 13
PLAYERFLAG_CANNOTPICKUPITEM = 14
PLAYERFLAG_CANALWAYSLOGIN = 15
PLAYERFLAG_CANBROADCAST = 16
PLAYERFLAG_CANEDITHOUSES = 17
PLAYERFLAG_CANNOTBEBANNED = 18
PLAYERFLAG_CANNOTBEPUSHED = 19
PLAYERFLAG_HASINFINITECAPACITY = 20
PLAYERFLAG_CANPUSHALLCREATURES = 21
PLAYERFLAG_CANTALKREDPRIVATE = 22
PLAYERFLAG_CANTALKREDCHANNEL = 23
PLAYERFLAG_TALKORANGEHELPCHANNEL = 24
PLAYERFLAG_NOTGAINEXPERIENCE = 25
PLAYERFLAG_NOTGAINMANA = 26
PLAYERFLAG_NOTGAINHEALTH = 27
PLAYERFLAG_NOTGAINSKILL = 28
PLAYERFLAG_SETMAXSPEED = 29
PLAYERFLAG_SPECIALVIP = 30
PLAYERFLAG_NOTGENERATELOOT = 31
PLAYERFLAG_CANTALKREDCHANNELANONYMOUS = 32
PLAYERFLAG_IGNOREPROTECTIONZONE = 33
PLAYERFLAG_IGNORESPELLCHECK = 34
PLAYERFLAG_IGNOREWEAPONCHECK = 35
PLAYERFLAG_CANNOTBEMUTED = 36
PLAYERFLAG_ISALWAYSPREMIUM = 37
PLAYERFLAG_SHOWGROUPINSTEADOFVOCATION = 40
PLAYERFLAG_HASINFINITESTAMINA = 41
PLAYERFLAG_CANNOTMOVEITEMS = 42
PLAYERFLAG_CANNOTMOVECREATURES = 43
PLAYERFLAG_CANREPORTBUGS = 44
PLAYERFLAG_CANNOTBESEEN = 46
PLAYERFLAG_HIDEHEALTH = 47
PLAYERFLAG_CANPASSTHROUGHALLCREATURES = 48

-- Player custom flags
PLAYERCUSTOMFLAG_ALLOWIDLE = 0
PLAYERCUSTOMFLAG_CANSEEPOSITION = 1
PLAYERCUSTOMFLAG_CANSEEITEMDETAILS = 2
PLAYERCUSTOMFLAG_CANSEECREATUREDETAILS = 3
PLAYERCUSTOMFLAG_NOTSEARCHABLE = 4
PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES = 5
PLAYERCUSTOMFLAG_CANTHROWANYWHERE = 6
PLAYERCUSTOMFLAG_CANPUSHALLITEMS = 7
PLAYERCUSTOMFLAG_CANMOVEANYWHERE = 8
PLAYERCUSTOMFLAG_CANMOVEFROMFAR = 9
PLAYERCUSTOMFLAG_CANUSEFAR = 10
PLAYERCUSTOMFLAG_CANLOGINMULTIPLECHARACTERS = 11
PLAYERCUSTOMFLAG_CANLOGOUTANYTIME = 12
PLAYERCUSTOMFLAG_HIDELEVEL = 13
PLAYERCUSTOMFLAG_ISPROTECTED = 14
PLAYERCUSTOMFLAG_ISIMMUNE = 15
PLAYERCUSTOMFLAG_NOTGAINSKULL = 16
PLAYERCUSTOMFLAG_NOTGAINUNJUSTIFIED = 17
PLAYERCUSTOMFLAG_IGNOREPACIFICATION = 18
PLAYERCUSTOMFLAG_IGNORELOGINDELAY = 19
PLAYERCUSTOMFLAG_CANSTAIRHOP = 20
PLAYERCUSTOMFLAG_CANTURNHOP = 21
PLAYERCUSTOMFLAG_IGNOREHOUSERENT = 22
PLAYERCUSTOMFLAG_CANWEARALLADDONS = 23
PLAYERCUSTOMFLAG_ISWALKABLE = 24
PLAYERCUSTOMFLAG_HASFULLLIGHT = 26

-- =====================
-- TABLE HELPERS
-- =====================

table.append = table.insert
table.empty = function(t) return next(t) == nil end
table.size = function(t) local s=0; for _,_ in pairs(t) do s=s+1 end; return s end
table.find = function(tbl,value,sensitive)
	local sensitive = sensitive or true
	if not sensitive and type(value)=="string" then
		for i,v in pairs(tbl) do if type(v)=="string" and v:lower()==value:lower() then return i end end
		return nil
	end
	for i,v in pairs(tbl) do if v==value then return i end end
	return nil
end
table.getPos = table.find
table.contains = function(txt,str) for _,v in pairs(str) do if txt:find(v) and not txt:find('(%w+)'..v) and not txt:find(v..'(%w+)') then return true end end return false end
table.isStrIn = table.contains
table.count = function(tbl,item) local c=0; for _,v in pairs(tbl) do if v==item then c=c+1 end end; return c end
table.countElements = table.count
table.getCombinations = function(tbl,num)
	local a={},n= {},table.size(tbl); for i=1,num do table.insert(a,i) end
	local newList={}
	while true do
		local row={}
		for i=1,num do table.insert(row,tbl[a[i]]) end
		table.insert(newList,row)
		local i=num
		while a[i]==(n-num+i) do i=i-1 end
		if i<1 then break end
		a[i]=a[i]+1
		for j=i,num do a[j]=a[i]+j-i end
	end
	return newList
end
function table.serialize(x,recur)
	recur=recur or {}; local t=type(x)
	if t==nil then return "nil" elseif t=="string" then return string.format("%q",x)
	elseif t=="number" then return tostring(x)
	elseif t=="boolean" then return x and "true" or "false"
	elseif getmetatable(x) then error("Cannot serialize table with metatable") 
	elseif t=="table" then
		if table.find(recur,x) then error("Cannot serialize recursive table") end
		table.append(recur,x)
		local s="{"
		for k,v in pairs(x) do s=s.."["..table.serialize(k,recur).."] = "..table.serialize(v,recur)..", " end
		return s:sub(0,s:len()-2).."}"
	end
	error("Cannot serialize value of type '"..t.."'")
end
function table.unserialize(str) if type(str)~='string' or str:len()==0 then return {} end; return loadstring("return "..str)() end

-- =====================
-- MATH UTILITIES
-- =====================
math.round = function(num,idp) return tonumber(string.format("%."..(idp or 0).."f",num)) end

-- =====================
-- LEGACY / OO COMPATIBILITY
-- =====================
TRUE = true; FALSE = false; LUA_ERROR=false; LUA_NO_ERROR=true; LUA_NULL=nil
Creature={}; Player={}; Monster={}; Npc={}; Game={}; Condition={}; Combat={}

-- createClass and OO setup
function createClass(class,inheritance)
	setmetatable(class,{
		__index=inheritance or nil,
		__call=function(self,cid)
			if not cid then self={__index=class}; setmetatable(self,self); return self end
			cid=type(cid)=="number" and cid or type(cid)=="string" and getPlayerByNameWildcard(cid)
			if cid then
				if not self[cid] then self[cid]={__index=class}; setmetatable(self[cid],self[cid]); self[cid].cid=cid; return self[cid] else return self[cid] end
			else return nil end
		end
	})
end
createClass(Creature); createClass(Player,Creature); createClass(Monster,Creature); createClass(Npc,Creature); createClass(Game); createClass(Condition); createClass(Combat)

-- Creature example methods
function Creature:getId() return self.cid end
function Creature:getName() return getCreatureName(self.cid) end
function Creature:getHealth() return getCreatureHealth(self.cid) end
function Creature:getMaxHealth() return getCreatureMaxHealth(self.cid) end
function Creature:getMana() return getCreatureMana(self.cid) end
function Creature:getMaxMana() return getCreatureMaxMana(self.cid) end
function Creature:getStorageValue(id) return getCreatureStorageValue(self.cid,id) end
function Creature:getLookDirection() return getCreatureLookDirection(self.cid) end
function Creature:setMaxHealth(h) return setCreatureMaxHealth(self.cid,h) end
function Creature:setMaxMana(m) return setCreatureMaxMana(self.cid,m) end
function Creature:setStorageValue(s,v) return setCreatureStorageValue(self.cid,s,v) end
function Creature:teleportTo(pos,push) doTeleportThing(self.cid,pos,push or false) end
function Creature:addHealth(h,e,c,f) doCreatureAddHealth(self.cid,h,e,c,f) end
function Creature:addMana(m) doCreatureAddMana(self.cid,m) end
function Creature:say(text,t,ghost,cid,pos) doCreatureSay(self.cid,text,t or SPEAK_SAY,ghost or false,cid or 0,pos) end
function Creature:addCondition(cond) doAddCondition(self.cid,cond) end
function Creature:removeCondition(only,type,sub) if only then doRemoveConditions(self.cid,only) else doRemoveCondition(self.cid,type,sub) end end
function Creature:moveCreature(dir) doMoveCreature(self.cid,dir) end
function Creature:isCreature() return isCreature(self.cid) end
function Creature:isPlayer() return isPlayer(self.cid) end
function Creature:isMonster() return isMonster(self.cid) end
function Creature:isNpc() return isNpc(self.cid) end
function Creature:remove(force) doRemoveCreature(self.cid,force or true) end

-- Player example methods
function Player:getLevel() return getPlayerLevel(self.cid) end
function Player:getExperience() return getPlayerExperience(self.cid) end
function Player:getMagicLevel(ignore) return getPlayerMagLevel(self.cid,ignore) end
function Player:addMoney(m) doPlayerAddMoney(self.cid,m) end
function Player:removeMoney(m) doPlayerRemoveMoney(self.cid,m) end
function Player:transferMoney(target,m) doPlayerTransferMoneyTo(self.cid,target,m) end
function Player:addItem(item,count,drop,sub) return doPlayerAddItem(self.cid,item,count,drop,sub) end
function Player:addItemEx(uid,drop) return doPlayerAddItemEx(self.cid,uid,drop or false) end
function Player:addExperience(exp) doPlayerAddExperience(self.cid,exp) end
function Player:feed(food) doPlayerFeed(self.cid,food) end
function Player:savePlayer(shallow) doPlayerSave(self.cid,shallow or false) end
function Player:isPzLocked() return isPlayerPzLocked(self.cid) end
