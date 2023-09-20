local myWorld = World:new('mobarena');
local lobbysound = Location:new(myWorld, 836.0, 110.0, 161.0);


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

local worldMob = World:new('mobarena');

local mobeffects = {
        {"Angry", "ANGRY_VILLAGER", 10, 30, 1},
        {"Magical", "ENCHANTMENT_TABLE", 10, 30, 1},
};

function fireTick()
	processPlayers({world:getPlayers()});
        processPlayers({worldMob:getPlayers()});
end

function processPlayers(players)
	for index, playerName in pairs(players) do
		for key, effect in pairs(effects) do
			if playerName ~= nil then
				local player = Player:new(playerName);
				if player ~= nil and player:isOnline() then
					if player:hasItemWithName("" .. effect[1]) then
						local world, x, y, z = player:getLocation();
						local playerLoc = Location:new(world, x, y + effect[5], z);
						playerLoc:playEffect(effect[2], effect[3], effect[4], 20);
					end
				end
			end
		end
	end
end

registerHook("BLOCK_GAINS_CURRENT", "fireTick", "mobarena", 831.0, 130.0, 156.0);
registerHook("BLOCK_GAINS_CURRENT", "processPlayers", "mobarena", 831.0, 130.0, 156.0);


------------------
----Endgame---------
--------------------

function lobby_endgame_portal(data)
local player = Player:new(data.player);
          a_whisper_npc(Message, "&4&lYou are not yet worthy", player);
          lobbysound:playSound('VILLAGER_NO', 1, 1);
end

registerHook("REGION_ENTER", "lobby_endgame_portal", "mobarena-lobby_endgame1");
registerHook("REGION_ENTER", "lobby_endgame_portal", "mobarena-lobby_endgame2");


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
registerHook("REGION_ENTER", "lobby_easter_room", "mobarena-lobby_secret");

---------------------
--Mine r4 Rewards----
---------------------


local world = World:new('mobarena');
local mR4Chest = Location:new(world, 826.0, 133.0, 164.0);
local mR4ChestOpen = Location:new(world, 826.0, 133.0, 164.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr4_rewards(data)
     local player = Player:new(data.player);
		mChestPlayers[player.name] = true;
		mR4Chest:cloneChestToPlayer(player.name);
                lobbysound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 4 Rewards: you earned 9 Mob Bones!");
		end
	

registerHook("REGION_ENTER", "mr4_rewards", "mobarena-pve2_r5");
