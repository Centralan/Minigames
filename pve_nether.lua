---------------
--Worlds--
---------------

local myWorld5 = World:new('mobarena_nether');
local myWorld = World:new('mobarena');
local myWorld2 = World:new('spawn2');
local myWorld3 = World:new('survival3');
local myWorld4 = World:new('creative');
local nethersound = Location:new(myWorld5, 0.0, 86.0, 0.0);

-------------
--teleports--
-------------

local nethercatch = Location:new(myWorld5, 0, 62.0, 4.0);
local netherenter = Location:new(myWorld5, 0, 75.0, 42.0);
local netherexit = Location:new(myWorld, 837.0, 97, 149.0);
local netherrespawn = Location:new(myWorld5, 0, 62.0, 4.0);
local netherreset = Location:new(myWorld5, 0, 85.0, 38.0);

----------------
--Chests--
----------------

local NGearChest = Location:new(myWorld, 834.0, 133.0, 164.0);

--------
-----AI---
----------

local Overlord = 'PvE'
local Overlord6 = '&d[PvE] &fA Player has &ajoined &6Nether Arena&f.'
local Overlord7 = '&d[PvE] &fA Player has &adefeated &6Nether Arena&f.'
local Overlord8 = '&d[PvE] &fA Player has &cabandoned &6Nether Arena&f.'
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

function a_broadcast5(msg)
	myWorld5:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast5('&f&c' .. npc .. '&6: &f' .. msg);
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
	 a_broadcast(Overlord6, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast2(Overlord6, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast3(Overlord6, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast4(Overlord6, player.name .." has &ajoined &fthe struggle in the &6Nther Arena&f!");
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
         a_broadcast_npc(Overlord8, player.name .. " has &cabandoned &fthe struggle in the &6Nether Arena&f!");
	 a_broadcast(Overlord8, player.name .. " has &cabandoned &fthe struggle in the &6Nether Arena&f!");
end

registerHook("REGION_ENTER", "tp_to_arena3", "mobarena-nether_arena_e");
registerHook("INTERACT", "button_out_arena3", 143, "mobarena_nether", 1.0, 62.0, 5.0);
registerHook("REGION_LEAVE", "command_out_arena3", "mobarena_nether-pve_nether_main");

--------------------------
----Respawning/Game Over----
----------------------------

function respawn3(data)
       if nRoundRunning then
         for playerName, value in pairs(NarenaPlayers) do
             local player = Player:new(data.player);
             player:setHealth(20);
             player:teleport(netherrespawn);

      end
   end
end

registerHook("PLAYER_DEATH", "respawn3", "mobarena_nether");

--------------------
-----traps----------
--------------------

function applyBlind(data)
        local player = Player:new(data.player);
        EventEngine.player.addPotionEffect(player.name, 'BLINDNESS', 10, 5);
end

registerHook("REGION_ENTER", "applyBlind", "mobarena_nether-pve_nether_b1");

---------------------------------------
---mob spawn points------
----------------------------------------
local nS1 = Location:new(myWorld5, 2.0, 66.0, 26.0);
local nS2 = Location:new(myWorld5, 0.0, 66.0, 26.0);
local nS3 = Location:new(myWorld5, -2.0, 66.0, 26.0);
local nS4 = Location:new(myWorld5, -4.0, 66.0, 26.0);
local nS5 = Location:new(myWorld5, -6.0, 66.0, 26.0);

---------------------------
-----------Round 1---------
---------------------------

function n_start_r1(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if not nR1Done then
      if not nRoundRunning then  
         nRoundRunning = true;
         nR1:startRepeating()
         nethersound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	 a_whisper_good(Message, "&eLook out &630 &eMobs spawning in!", player);
	NspawnMob(nS1, "SKELETON");
	NspawnMob(nS2, "SKELETON");
	NspawnMob(nS3, "SKELETON");
	NspawnMob(nS4, "SKELETON");
	NspawnMob(nS5, "SKELETON");

 else
         a_whisper_error(Message, "Joining the fight for Round 1.", player);

         end
      end
   end
end

function n_end_r1()
	if check_alive_statsN() then
           nR1:cancel()
           nRoundRunning = false;
           nR1Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Nether Arena &fhas ended!")
	end
	end
end 

registerHook("REGION_ENTER", "n_start_r1", "mobarena_nether-nether_round");
