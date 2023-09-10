
local myWorld = World:new('mobarena');

--------
---AI---
--------

local Overlord = 'PVE'
local Message = ''

function a_broadcast(msg)
	myWorld:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast('&f&c' .. npc .. '&6: &f' .. msg);
end

function a_whisper_npc(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&f' .. msg);
end

-----------------
--Testing Lanes--
-----------------

local OrangeLocation = Location:new(myWorld, 832, 101, 132);
local oTimer = Timer:new("o_despawn", 1);
local oCount = 0;
local oMobs = {};

local BlueLocation = Location:new(myWorld, 835, 101, 132);
local bTimer = Timer:new("b_despawn", 1);
local bCount = 0;
local bMobs = {};

local GreenLocation = Location:new(myWorld, 838, 101, 132);
local gTimer = Timer:new("g_despawn", 1);
local gCount = 0;
local gMobs = {};

local YellowLocation = Location:new(myWorld, 841, 101, 132);
local yTimer = Timer:new("y_despawn", 1);
local yCount = 0;
local yMobs = {};


local function orangelane(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
        table.insert(oMobs, entity);
end

local function purgeEntityList_o()
	for index, value in pairs(oMobs) do
		oMobs[index] = nil;
	end
end

function check_alive_stats_o()
	for key, value in pairs(oMobs) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

function o_spawn(data)
     if oCount < 4 then
        oTimer:startRepeating()
	orangelane(OrangeLocation, "CREEPER");
        oCount = oCount + 1;
      else
          local player = Player:new(data.player);
          a_whisper_npc(Message, "&cSorry you can't spawn more mobs until the current 4 are dead!", player);
end
end

function o_despawn(data)
      if check_alive_stats_o() then
        oCount = 0;
        oTimer:cancel()
end
end

local function bluelane(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
        table.insert(bMobs, entity);
end

local function purgeEntityList_b()
	for index, value in pairs(oMobs) do
		bMobs[index] = nil;
	end
end

function check_alive_stats_b()
	for key, value in pairs(bMobs) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

function b_spawn(data)
     if bCount < 4 then
        bTimer:startRepeating()
	bluelane(BlueLocation, "ZOMBIE");
        bCount = bCount + 1;
      else
          local player = Player:new(data.player);
          a_whisper_npc(Message, "&cSorry you can't spawn more mobs until the current 4 are dead!", player);
end
end

function b_despawn(data)
      if check_alive_stats_b() then
        bCount = 0;
        bTimer:cancel()
end
end

local function greenlane(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
        table.insert(gMobs, entity);
end

local function purgeEntityList_g()
	for index, value in pairs(gMobs) do
		gMobs[index] = nil;
	end
end

function check_alive_stats_g()
	for key, value in pairs(gMobs) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

function g_spawn(data)
     if gCount < 4 then
        gTimer:startRepeating()
	greenlane(GreenLocation, "SKELETON");
        gCount = gCount + 1;
      else
          local player = Player:new(data.player);
          a_whisper_npc(Message, "&cSorry you can't spawn more mobs until the current 4 are dead!", player);
end
end

function g_despawn(data)
      if check_alive_stats_g() then
        gCount = 0;
        gTimer:cancel()
end
end

local function yellowlane(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
        table.insert(yMobs, entity);
end

local function purgeEntityList_y()
	for index, value in pairs(oMobs) do
		bMobs[index] = nil;
	end
end

function check_alive_stats_y()
	for key, value in pairs(yMobs) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

function y_spawn(data)
     if yCount < 4 then
        yTimer:startRepeating()
	yellowlane(YellowLocation, "WITCH");
        yCount = yCount + 1;
      else
          local player = Player:new(data.player);
          a_whisper_npc(Message, "&cSorry you can't spawn more mobs until the current 4 are dead!", player);
end
end

function y_despawn(data)
      if check_alive_stats_y() then
        yCount = 0;
        yTimer:cancel()
end
end


registerHook("INTERACT", "o_spawn", 77, "mobarena", 831, 101, 143);
registerHook("INTERACT", "b_spawn", 77, "mobarena", 834, 101, 143);
registerHook("INTERACT", "g_spawn", 77, "mobarena", 837, 101, 143);
registerHook("INTERACT", "y_spawn", 77, "mobarena", 840, 101, 143);

--------------
--Teleports---
--------------

local lobbyeasterdoor = Location:new(myWorld, 824, 101, 143);
local lobbydoor = Location:new(myWorld, 837, 97, 149);

function to_easter_door(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(lobbyeasterdoor);
end

function to_lobby_door(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(lobbydoor);
end

registerHook("REGION_ENTER", "to_easter_door", "mobarena-lobby_secret_door");
registerHook("REGION_ENTER", "to_lobby_door", "mobarena-lobby_tolobby");


-----------------------
------ Effects ------
-----------------------


local surfacearenaeffects = {
	Location:new(myWorld, 801.0, 101.0, 165.0),
	Location:new(myWorld, 803.0, 101.0, 165.0),
	Location:new(myWorld, 805.0, 100.0, 167.0),
	Location:new(myWorld, 805.0, 100.0, 163.0),
	Location:new(myWorld, 814.0, 100.0, 172.0),
	Location:new(myWorld, 810.0, 100.0, 172.0),
	Location:new(myWorld, 812.0, 101.0, 174.0),
	Location:new(myWorld, 812.0, 101.0, 176.0)
};

function surface_effects()
	for key, value in pairs(surfacearenaeffects) do
		value:playEffect('PORTAL', 1, 5, 5);
	end
end

registerHook("BLOCK_GAINS_CURRENT", "surface_effects", "mobarena", 837, 132, 160);


---------------------
--Cheeves------------
---------------------

function lobby_vanish_ach(data)
        local p = Player:new(data["player"]);
        p:sendEvent("achievement.vanish");
end

function lobby_easter_room(data)
        local p = Player:new(data["player"]);
        p:sendEvent("achievement.welcometotheclub");
end

registerHook("INTERACT", "lobby_vanish_ach", 77, "mobarena", 841.0, 99.0, 172.0);
registerHook("REGION_ENTER", "lobby_easter_room", "mobarena-lobby_secret_door");


--Bug Report--

local bugbook = Location:new(myWorld, 832, 133, 164);

function bug_report(data)
       local player = Player:new(data.player);
             bugbook:cloneChestToPlayer(player.name);
       a_whisper_npc(Message, "&dType /may to send this book. Please use this book to report bugs only! Visit our discord for more bug reports!", player);
end

registerHook("INTERACT", "bug_report", 77, "mobarena", 834.0, 99.0, 152.0);

