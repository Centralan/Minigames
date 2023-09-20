---------------
--Worlds--
---------------

local myWorld = World:new('mobarena_nether');
local oldWorld = World:new('mobarena');
local myWorld2 = World:new('spawn2');
local myWorld3 = World:new('survival3');
local myWorld4 = World:new('creative');
local nethersound = Location:new(myWorld, 0.0, 86.0, 0.0);

-------------
--teleports--
-------------

local nethercatch = Location:new(myWorld, 0, 62.0, 4.0);
local netherenter = Location:new(myWorld, 0, 62.0, 4.0);
local netherexit = Location:new(oldWorld, 837.0, 97, 149.0);

----------------
--Chests--
----------------

local NGearChest = Location:new(oldWorld, 834.0, 133.0, 164.0);

--------
-----AI---
----------

local Overlord = 'PvE'
local Overlord6 = '&d[PvE] &fA Player has &ajoined &6Nether Arena&f.'
local Overlord7 = '&d[PvE] &fA Player has &adefeated &6Nether Arena&f.'
local Message = ''
local Message2 = ''

function a_broadcast(msg)
	myWorld:broadcast(msg);
end

function a_broadcast2(msg)
	myWorld2:broadcast(msg);
end

function a_broadcast3(msg)
	myWorld3:broadcast(msg);
end

function a_broadcast4(msg)
	myWorld4:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast('&f&c' .. npc .. '&6: &f' .. msg);
end

function a_whisper_error(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&c' .. msg);
end

function a_whisper_good(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&f' .. msg);
end

--------------------------------
----Player Control--
----------------------------------

local NarenaPlayers = {};
local NplayerCount = 0;

--------------------------------
----Mob Control--
----------------------------------

local entityList = {};

local function NspawnMob(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
	table.insert(entityList, entity);
end

local function purgeEntityListN()
	for index, value in pairs(entityList) do
		entityList[index] = nil;
	end
end

function check_alive_statsN()
	for key, value in pairs(entityList) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

---------------------
----Toggles/Timers------
-----------------------

local nR1Done = false;
local nR2Done = false;
local nR3Done = false;
local nR4Done = false;
local nR5Done = false;
local nRoundRunning = false;
local nR1 = Timer:new("n_end_r1", 1);
local nR2 = Timer:new("n_end_r2", 1);
local nR3 = Timer:new("n_end_r3", 1);
local nR4 = Timer:new("n_end_r4", 1);
local nR5 = Timer:new("n_end_r5", 1);


----------------
--Arena Catch --
----------------

function nether_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(nethercatch);
end

registerHook("REGION_ENTER", "nether_catch", "mobarena_nether-pve_nether_catch");

-------------------
--lobby managment--
-------------------

function tp_to_arena3(data)
       if NplayerCount < 4 then
        local player = Player:new(data.player);
         player:teleport(netherenter);	  
         NGearChest:cloneChestToPlayer(player.name);
	  nethersound:playSound('HORSE_SADDLE', 1, 0);
	  player:sendMessage("&dYou have been granted with free gear.");
          NarenaPlayers[player.name] = true;
          NplayerCount = NplayerCount + 1;
         a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast2(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast3(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast4(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nther Arena&f!");
        else
         local player = Player:new(data.player);
          a_whisper_error(Message, "Sorry this Arena is full, try joining when someone leaves!", player);
          player:teleport(netherexit);
  end
end

function button_out_arena3(data)
        local player = Player:new(data.player);
          player:teleport(netherexit);
          NarenaPlayers[player.name] = nil;
          NplayerCount = NplayerCount - 1;
end

function command_out_arena3(data)
        local player = Player:new(data.player);
          NarenaPlayers[player.name] = nil;
          NplayerCount = NplayerCount - 1;
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Nether Arena&f!");
end

registerHook("REGION_ENTER", "tp_to_arena3", "mobarena-nether_arena_e");
registerHook("INTERACT", "button_out_arena3", 143, "mobarena_nether", 1.0, 62.0, 5.0);
registerHook("REGION_LEAVE", "command_out_arena3", "mobarena_nether-pve_nether_main");
