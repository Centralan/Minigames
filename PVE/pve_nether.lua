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
local netherr5 = Location:new(myWorld, 838, 119.0, 153.0);
local nlrewards = Location:new(myWorld, -4, 83.0, 38.0);

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
local Overlord9 = '&d[PvE] A &aLightning Round &fhas started in the &6Nether &fArena!.'
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
----Mob Control---
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
local nRLDone = false;
local nRoundRunning = false;
local nLRoundRunning = false;
local nR1 = Timer:new("n_end_r1", 1);
local nR2 = Timer:new("n_end_r2", 1);
local nR3 = Timer:new("n_end_r3", 1);
local nR4 = Timer:new("n_end_r4", 1);
local nR5 = Timer:new("n_end_r5", 1);
local nR5 = Timer:new("n_end_r5_2", 1);
local nRL = Timer:new("n_end_light", 1);


--------------
----Chat Mon--
--------------

local function hasPrefix(subject, prefix)
	return string.sub(subject, 1, string.len(prefix)) == prefix;
end

local function splitPlayerName(message, len)
	return string.sub(message, len, string.len(message));
end

function chatMonitor_nether(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		local player = Player:new(data.player);
		local message = data.message;

		if hasPrefix(message, "#ResetNether") then
			local playerName = splitPlayerName(message, 16);
		        nRoundRunning = false;
			nR1Done = false;
                        nR2Done = false;
                        nR3Done = false;
                        nR4Done = false;
			nR5Done = false;
			nRLDone = false;
			NarenaPlayers[player.name] = nil;
                        NplayerCount = NplayerCount - 1;
			player:sendMessage("&5Server:&6Nether &fArena has been reset.");
		end
	end
end
		
registerHook("CHAT_MESSAGE", "chatMonitor_nether", "mobarena_nether");

function add_nether(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		local player = Player:new(data.player);
		local message = data.message;

		if hasPrefix(message, "#AddNether") then
			local playerName = splitPlayerName(message, 16);
			NarenaPlayers[player.name] = true;
		        NplayerCount = NplayerCount + 1;
			player:sendMessage("&5Server: &6Nether &fArena player count +1");
		end
	end
end
registerHook("CHAT_MESSAGE", "add_nether", "mobarena_nether");

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
	  nethersound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
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
registerHook("REGION_ENTER", "button_out_arena3", "mobarena_nether-pve_n_back");
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
local nS1 = Location:new(myWorld5, 3.0, 63.0, 26.0);
local nS2 = Location:new(myWorld5, -2.0, 63.0, 20.0);
local nS3 = Location:new(myWorld5, 3.0, 63.0, 14.0);
local nS4 = Location:new(myWorld5, -4.0, 63.0, 11.0);
local nS5 = Location:new(myWorld5, 5.0, 63.0, 7.0);
local nS6 = Location:new(myWorld5, 1.0, 63.0, 5.0);
local nS7 = Location:new(myWorld5, -10.0, 62.0, 4.0);
local nS8 = Location:new(myWorld5, 11.0, 61.0, 2.0);
local nS9 = Location:new(myWorld5, 7.0, 58.0, -10.0);
local nS10 = Location:new(myWorld5, 1.0, 57.0, -15.0);
local nS11 = Location:new(myWorld5, -3.0, 57.0, -23.0);
local nS12 = Location:new(myWorld5, 1.0, 57.0, -15.0);
local nS13 = Location:new(myWorld5, -12.0, 60.0, -3.0);
local nS14 = Location:new(myWorld5, 4.0, 57.0, -26.0);
local nS15 = Location:new(myWorld5, -4.0, 57.0, -30.0);
local nS16 = Location:new(myWorld5, -8.0, 57.0, -36.0);
local nS17 = Location:new(myWorld5, 5.0, 57.0, -32.0);
local nS18 = Location:new(myWorld5, 2.0, 56.0, -40.0);
local nS19 = Location:new(myWorld5, -22.0, 48.0, -20.0);
local nS20 = Location:new(myWorld5, -17.0, 49.0, -14.0);
local nS21 = Location:new(myWorld5, -11.0, 49.0, -8.0);
local nS22 = Location:new(myWorld5, 0.0, 49.0, -14.0);
local nS23 = Location:new(myWorld5, -2.0, 49.0, -17.0);
local nS24 = Location:new(myWorld5, 4.0, 49.0, -23.0);
local nS25 = Location:new(myWorld5, -11.0, 49.0, -30.0);
local nS26 = Location:new(myWorld5, 7.0, 49.0, -13.0);
local nS27 = Location:new(myWorld5, 17.0, 49.0, -19.0);
local nS28 = Location:new(myWorld5, 22.0, 49.0, -28.0);
local nS29 = Location:new(myWorld5, 32.0, 49.0, -30.0);
local nS30 = Location:new(myWorld5, -32.0, 49.0, -23.0);
local nS31 = Location:new(myWorld5, -29.0, 49.0, -12.0);
local nS32 = Location:new(myWorld5, 20.0, 49.0, -12.0);
local nS33 = Location:new(myWorld5, 29.0, 49.0, -20.0);
local nS34 = Location:new(myWorld5, -26.0, 49.0, -4.0);
local nS35 = Location:new(myWorld5, -12.0, 49.0, 2.0);
local nS36 = Location:new(myWorld5, -25.0, 49.0, 5.0);
local nS37 = Location:new(myWorld5, 30.0, 49.0, -3.0);
local nS38 = Location:new(myWorld5, 15.0, 49.0, -2.0);
local nS39 = Location:new(myWorld5, -10.0, 48.0, 12.0);
local nS40 = Location:new(myWorld5, -30.0, 49.0, 12.0);
local nS41 = Location:new(myWorld5, 0.0, 49.0, 17.0);
local nS42 = Location:new(myWorld5, 15.0, 49.0, 8.0);
local nS43 = Location:new(myWorld5, 29.0, 49.0, 14.0);
local nS44 = Location:new(myWorld5, 21.0, 49.0, 21.0);
local nS45 = Location:new(myWorld5, -25.0, 49.0, 17.0);
local nS46 = Location:new(myWorld5, -15.0, 49.0, 23.0);
local nS47 = Location:new(myWorld5, -4.0, 49.0, 27.0);
local nS48 = Location:new(myWorld5, -7.0, 49.0, 23.0);
local nS49 = Location:new(myWorld5, -24.0, 49.0, 32.0);
local nS50 = Location:new(myWorld5, -20.0, 70.0, 8.0);  --air spawn point
local nS51 = Location:new(myWorld5, 16.0, 71.0, 23.0);  --air spawn point
local nS52 = Location:new(myWorld5, 22.0, 70.0, 10.0);  --air spawn point
local nS53 = Location:new(myWorld5, 27.0, 70.0, -9.0);  --air spawn point
local nS54 = Location:new(myWorld5, 18.0, 70.0, -22.0);  --air spawn point
local nS55 = Location:new(myWorld5, -20.0, 70.0, 8.0);  --air spawn point
local nS56 = Location:new(myWorld5, 2.0, 75.0, -21.0);  --air spawn point
local nS57 = Location:new(myWorld5, -26.0, 68.0, -15.0);  --air spawn point
local nS58 = Location:new(myWorld5, -1.0, 79.0, 20.0);  --air spawn point
local nS59 = Location:new(myWorld5, 14.0, 80.0, 1.0);  --air spawn point
local nS60 = Location:new(myWorld5, 0.0, 63.0, -4.0);  --LAVA spawn point

--BLAZE
--GHAST
--LAVASLIME
--PIGZOMBIE
--SKELETON
--WITHER

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
         nethersound:playSound('BLOCK_PORTAL_TRIGGER', 100, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	 a_whisper_good(Message, "&eLook out &620 &eMobs spawning in!", player);
	NspawnMob(nS1, "WITHER_SKELETON");
	NspawnMob(nS2, "WITHER_SKELETON");
	NspawnMob(nS3, "WITHER_SKELETON");
	NspawnMob(nS4, "WITHER_SKELETON");
	NspawnMob(nS5, "WITHER_SKELETON");
	NspawnMob(nS6, "WITHER_SKELETON");
	NspawnMob(nS7, "WITHER_SKELETON");
	NspawnMob(nS8, "WITHER_SKELETON");
	NspawnMob(nS9, "WITHER_SKELETON");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS11, "WITHER_SKELETON");
	NspawnMob(nS12, "WITHER_SKELETON");
	NspawnMob(nS13, "WITHER_SKELETON");
	NspawnMob(nS14, "WITHER_SKELETON");
	NspawnMob(nS15, "WITHER_SKELETON");
	NspawnMob(nS16, "WITHER_SKELETON");
	NspawnMob(nS17, "WITHER_SKELETON");
	NspawnMob(nS18, "WITHER_SKELETON");
	NspawnMob(nS20, "WITHER_SKELETON");

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

------------------------------------------------------
----R1 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena_nether');
local nR1Chest = Location:new(world, -3.0, 85.0, 47.0);
local nR1ChestOpen = Location:new(world, -3.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;

function nr1_rewards(data)
     local player = Player:new(data.player);
	if not nRoundRunning then 
	if nR1Done then
	if not nR2Done then
	if not nR3Done then
        if not nR4Done then
        if not nR5Done then
		nChestPlayers[player.name] = true;
		player:closeInventory();
		nR1Chest:cloneChestToPlayer(player.name);
                nethersound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 1 Rewards: you earned 6 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "nr1_rewards", "mobarena_nether-nether_rewards");

---------------------------
-----------Round 2---------
---------------------------

function n_start_r2(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if nR1Done then
      if not nR2Done then
      if not nRoundRunning then  
         nRoundRunning = true;
         nR2:startRepeating()
         nethersound:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 2 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 2 has started, kill all mobs to move to Round 3.", player);
	 a_whisper_good(Message, "&eLook out &640 &eMobs spawning in!", player);
	NspawnMob(nS1, "WITHER_SKELETON");
	NspawnMob(nS2, "WITHER_SKELETON");
	NspawnMob(nS3, "PIGZOMBIE");
	NspawnMob(nS4, "WITHER_SKELETON");
	NspawnMob(nS5, "WITHER_SKELETON");
	NspawnMob(nS6, "PIGZOMBIE");
	NspawnMob(nS7, "WITHER_SKELETON");
	NspawnMob(nS8, "WITHER_SKELETON");
	NspawnMob(nS9, "WITHER_SKELETON");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS11, "LAVASLIME");
	NspawnMob(nS12, "PIGZOMBIE");
	NspawnMob(nS13, "WITHER_SKELETON");
	NspawnMob(nS14, "WITHER_SKELETON");
	NspawnMob(nS15, "LAVASLIME");
	NspawnMob(nS16, "WITHER_SKELETON");
	NspawnMob(nS17, "WITHER_SKELETON");
	NspawnMob(nS18, "PIGZOMBIE");
	NspawnMob(nS19, "WITHER_SKELETON");
	NspawnMob(nS20, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "LAVASLIME");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS22, "PIGZOMBIE");
	NspawnMob(nS23, "WITHER_SKELETON");
	NspawnMob(nS24, "PIGZOMBIE");
	NspawnMob(nS25, "WITHER_SKELETON");
	NspawnMob(nS26, "WITHER_SKELETON");
	NspawnMob(nS27, "LAVASLIME");
	NspawnMob(nS28, "PIGZOMBIE");
	NspawnMob(nS29, "WITHER_SKELETON");
	NspawnMob(nS30, "WITHER_SKELETON");
	NspawnMob(nS31, "WITHER_SKELETON");
	NspawnMob(nS32, "PIGZOMBIE");
	NspawnMob(nS33, "LAVASLIME");
	NspawnMob(nS34, "WITHER_SKELETON");
	NspawnMob(nS35, "WITHER_SKELETON");
	NspawnMob(nS36, "WITHER_SKELETON");
	NspawnMob(nS37, "LAVASLIME");
	NspawnMob(nS38, "PIGZOMBIE");
	NspawnMob(nS39, "WITHER_SKELETON");
	NspawnMob(nS40, "WITHER_SKELETON");
	NspawnMob(nS60, "PIGZOMBIE");

 else
         a_whisper_error(Message, "Joining the fight for Round 2.", player);

         end
      end
   end
end
end

function n_end_r2()
	if check_alive_statsN() then
           nR2:cancel()
           nRoundRunning = false;
           nR2Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Nether Arena &fhas ended!")
	end
	end
end 

registerHook("REGION_ENTER", "n_start_r2", "mobarena_nether-nether_round");

------------------------------------------------------
----R2 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena_nether');
local nR2Chest = Location:new(world, -1.0, 85.0, 47.0);
local nR2ChestOpen = Location:new(world, -1.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;

function nr2_rewards(data)
     local player = Player:new(data.player);
	if not nRoundRunning then 
	if nR1Done then
	if nR2Done then
	if not nR3Done then
        if not nR4Done then
        if not nR5Done then
		nChestPlayers[player.name] = true;
		player:closeInventory();
		nR2Chest:cloneChestToPlayer(player.name);
                nethersound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 2 Rewards: you earned 8 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "nr2_rewards", "mobarena_nether-nether_rewards");

---------------------------
-----------Round 3---------
---------------------------

function n_start_r3(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if nR1Done then
      if nR2Done then
      if not nR3Done then
      if not nRoundRunning then  
         nRoundRunning = true;
         nR3:startRepeating()
         nethersound:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 3 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 3 has started, kill all mobs to move to Round 4.", player);
	 a_whisper_good(Message, "&eLook out &655 &eMobs spawning in!", player);
	NspawnMob(nS1, "LAVASLIME");
	NspawnMob(nS2, "PIGZOMBIE");
	NspawnMob(nS3, "WITHER_SKELETON");
	NspawnMob(nS4, "PIGZOMBIE");
	NspawnMob(nS5, "WITHER_SKELETON");
	NspawnMob(nS6, "PIGZOMBIE");
	NspawnMob(nS7, "WITHER_SKELETON");
	NspawnMob(nS8, "WITHER_SKELETON");
	NspawnMob(nS9, "PIGZOMBIE");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS11, "LAVASLIME");
	NspawnMob(nS12, "PIGZOMBIE");
	NspawnMob(nS13, "WITHER_SKELETON");
	NspawnMob(nS14, "WITHER_SKELETON");
	NspawnMob(nS15, "LAVASLIME");
	NspawnMob(nS16, "WITHER_SKELETON");
	NspawnMob(nS17, "PIGZOMBIE");
	NspawnMob(nS18, "PIGZOMBIE");
	NspawnMob(nS19, "WITHER_SKELETON");
	NspawnMob(nS20, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "LAVASLIME");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS22, "PIGZOMBIE");
	NspawnMob(nS23, "WITHER_SKELETON");
	NspawnMob(nS24, "PIGZOMBIE");
	NspawnMob(nS25, "WITHER_SKELETON");
	NspawnMob(nS26, "WITHER_SKELETON");
	NspawnMob(nS27, "LAVASLIME");
	NspawnMob(nS28, "LAVASLIME");
	NspawnMob(nS29, "PIGZOMBIE");
	NspawnMob(nS30, "WITHER_SKELETON");
	NspawnMob(nS31, "PIGZOMBIE");
	NspawnMob(nS32, "LAVASLIME");
	NspawnMob(nS33, "PIGZOMBIE");
	NspawnMob(nS34, "LAVASLIME");
	NspawnMob(nS35, "WITHER_SKELETON");
	NspawnMob(nS36, "SKELETON");
	NspawnMob(nS37, "LAVASLIME");
	NspawnMob(nS38, "PIGZOMBIE");
	NspawnMob(nS39, "SKELETON");
	NspawnMob(nS40, "PIGZOMBIE");
	NspawnMob(nS41, "PIGZOMBIE");
	NspawnMob(nS42, "LAVASLIME");
	NspawnMob(nS43, "WITHER_SKELETON");
	NspawnMob(nS44, "LAVASLIME");
	NspawnMob(nS45, "WITHER_SKELETON");
	NspawnMob(nS46, "LAVASLIME");
	NspawnMob(nS47, "PIGZOMBIE");
	NspawnMob(nS48, "LAVASLIME");
	NspawnMob(nS49, "WITHER_SKELETON");
	NspawnMob(nS50, "GHAST");
	NspawnMob(nS51, "BLAZE");
	NspawnMob(nS52, "BLAZE");
	NspawnMob(nS53, "GHAST");
	NspawnMob(nS54, "BLAZE");
	NspawnMob(nS55, "BLAZE");
	NspawnMob(nS60, "PIGZOMBIE");

 else
         a_whisper_error(Message, "Joining the fight for Round 3.", player);

         end
      end
   end
end
end
end

function n_end_r3()
	if check_alive_statsN() then
           nR3:cancel()
           nRoundRunning = false;
           nR3Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Nether Arena &fhas ended!")
	end
	end
end 

registerHook("REGION_ENTER", "n_start_r3", "mobarena_nether-nether_round");

------------------------------------------------------
----R3 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena_nether');
local nR3Chest = Location:new(world, 1.0, 85.0, 47.0);
local nR3ChestOpen = Location:new(world, 1.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;

function nr3_rewards(data)
     local player = Player:new(data.player);
	if not nRoundRunning then 
	if nR1Done then
	if nR2Done then
	if nR3Done then
        if not nR4Done then
        if not nR5Done then
		nChestPlayers[player.name] = true;
		player:closeInventory();
		nR3Chest:cloneChestToPlayer(player.name);
                nethersound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 3 Rewards: you earned 10 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "nr3_rewards", "mobarena_nether-nether_rewards");

---------------------------
-----------Round 4---------
---------------------------

function n_start_r4(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if nR1Done then
      if nR2Done then
      if nR3Done then
      if not nR4Done then			
      if not nRoundRunning then  
         nRoundRunning = true;
         nR4:startRepeating()
         nethersound:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 4 has started, kill all mobs to move to Round 5.", player);
	 a_whisper_good(Message, "&eLook out &660 &eMobs spawning in!", player);
	NspawnMob(nS1, "PIGZOMBIE");
	NspawnMob(nS2, "PIGZOMBIE");
	NspawnMob(nS3, "PIGZOMBIE");
	NspawnMob(nS4, "PIGZOMBIE");
	NspawnMob(nS5, "PIGZOMBIE");
	NspawnMob(nS6, "PIGZOMBIE");
	NspawnMob(nS7, "PIGZOMBIE");
	NspawnMob(nS8, "PIGZOMBIE");
	NspawnMob(nS9, "PIGZOMBIE");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS11, "LAVASLIME");
	NspawnMob(nS12, "PIGZOMBIE");
	NspawnMob(nS13, "WITHER_SKELETON");
	NspawnMob(nS14, "WITHER_SKELETON");
	NspawnMob(nS15, "LAVASLIME");
	NspawnMob(nS16, "WITHER_SKELETON");
	NspawnMob(nS17, "PIGZOMBIE");
	NspawnMob(nS18, "PIGZOMBIE");
	NspawnMob(nS19, "LAVASLIME");
	NspawnMob(nS20, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "LAVASLIME");
	NspawnMob(nS22, "PIGZOMBIE");
	NspawnMob(nS23, "WITHER_SKELETON");
	NspawnMob(nS24, "WITHER_SKELETON");
	NspawnMob(nS25, "WITHER_SKELETON");
	NspawnMob(nS26, "WITHER_SKELETON");
	NspawnMob(nS27, "LAVASLIME");
	NspawnMob(nS28, "LAVASLIME");
	NspawnMob(nS29, "WITHER_SKELETON");
	NspawnMob(nS30, "WITHER_SKELETON");
	NspawnMob(nS31, "PIGZOMBIE");
	NspawnMob(nS32, "LAVASLIME");
	NspawnMob(nS33, "PIGZOMBIE");
	NspawnMob(nS34, "LAVASLIME");
	NspawnMob(nS35, "WITHER_SKELETON");
	NspawnMob(nS36, "WITHER_SKELETON");
	NspawnMob(nS37, "LAVASLIME");
	NspawnMob(nS38, "WITHER_SKELETON");
	NspawnMob(nS39, "WITHER_SKELETON");
	NspawnMob(nS40, "PIGZOMBIE");
	NspawnMob(nS41, "PIGZOMBIE");
	NspawnMob(nS42, "LAVASLIME");
	NspawnMob(nS43, "WITHER_SKELETON");
	NspawnMob(nS44, "LAVASLIME");
	NspawnMob(nS45, "WITHER_SKELETON");
	NspawnMob(nS46, "LAVASLIME");
	NspawnMob(nS47, "PIGZOMBIE");
	NspawnMob(nS48, "LAVASLIME");
	NspawnMob(nS49, "LAVASLIME");
	NspawnMob(nS50, "GHAST");
	NspawnMob(nS51, "BLAZE");
	NspawnMob(nS52, "BLAZE");
	NspawnMob(nS53, "GHAST");
	NspawnMob(nS54, "BLAZE");
	NspawnMob(nS55, "GHAST");
	NspawnMob(nS56, "BLAZE");
	NspawnMob(nS57, "BLAZE");
	NspawnMob(nS58, "GHAST");
	NspawnMob(nS59, "BLAZE");
	NspawnMob(nS60, "PIGZOMBIE");

 else
         a_whisper_error(Message, "Joining the fight for Round 4.", player);

         end
      end
   end
end
end
end
end

function n_end_r4()
	if check_alive_statsN() then
           nR4:cancel()
           nRoundRunning = false;
           nR4Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&aRound 4 &fin the &6Nether Arena &fhas ended!")
	end
	end
end 

registerHook("REGION_ENTER", "n_start_r4", "mobarena_nether-nether_round");

------------------------------------------------------
----R4 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena_nether');
local nR4Chest = Location:new(world, 3.0, 85.0, 47.0);
local nR4ChestOpen = Location:new(world, 3.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;

function nr4_rewards(data)
     local player = Player:new(data.player);
	if not nRoundRunning then 
	if nR1Done then
	if nR2Done then
	if nR3Done then
        if nR4Done then
        if not nR5Done then
		nChestPlayers[player.name] = true;
		player:closeInventory();
		nR4Chest:cloneChestToPlayer(player.name);
                nethersound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 4 Rewards: you earned 12 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "nr4_rewards", "mobarena_nether-nether_rewards");

---------------------------------------
-----------Round  5 ---------
---------------------------------------

function n_start_r5(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if nR1Done then
      if nR2Done then
      if nR3Done then
      if nR4Done then	
      if not nRoundRunning then  
         nRoundRunning = true;
         nR5:startRepeating()
         nethersound:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 5 &fin the &6Nether Arena&f!");
         a_whisper_good(Message, "&cRound 5 has started, kill all mobs defeat the Nether Arena.", player);
	 a_whisper_good(Message, "&eLook out &660 &eMobs spawning in!", player);
         NspawnMob(nS1, "PIGZOMBIE");
	NspawnMob(nS1, "WITHER_SKELETON");
	NspawnMob(nS2, "PIGZOMBIE");
	NspawnMob(nS3, "PIGZOMBIE");
	NspawnMob(nS4, "PIGZOMBIE");
	NspawnMob(nS4, "WITHER_SKELETON");
	NspawnMob(nS5, "PIGZOMBIE");
	NspawnMob(nS6, "PIGZOMBIE");
	NspawnMob(nS7, "PIGZOMBIE");
	NspawnMob(nS8, "PIGZOMBIE");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS9, "PIGZOMBIE");
	NspawnMob(nS10, "WITHER_SKELETON");
	NspawnMob(nS10, "PIGZOMBIE");
	NspawnMob(nS11, "LAVASLIME");
	NspawnMob(nS12, "PIGZOMBIE");
	NspawnMob(nS12, "LAVASLIME");
	NspawnMob(nS13, "WITHER_SKELETON");
	NspawnMob(nS14, "WITHER_SKELETON");
	NspawnMob(nS15, "LAVASLIME");
	NspawnMob(nS16, "WITHER_SKELETON");
	NspawnMob(nS17, "PIGZOMBIE");
	NspawnMob(nS18, "PIGZOMBIE");
	NspawnMob(nS19, "LAVASLIME");
	NspawnMob(nS20, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "WITHER_SKELETON");
	NspawnMob(nS21, "LAVASLIME");
	NspawnMob(nS22, "PIGZOMBIE");
	NspawnMob(nS23, "WITHER_SKELETON");
	NspawnMob(nS24, "WITHER_SKELETON");
	NspawnMob(nS25, "WITHER_SKELETON");
	NspawnMob(nS26, "WITHER_SKELETON");
	NspawnMob(nS27, "LAVASLIME");
	NspawnMob(nS28, "LAVASLIME");
	NspawnMob(nS29, "WITHER_SKELETON");
	NspawnMob(nS30, "WITHER_SKELETON");
	NspawnMob(nS31, "PIGZOMBIE");
	NspawnMob(nS32, "LAVASLIME");
	NspawnMob(nS33, "LAVASLIME");
	NspawnMob(nS33, "PIGZOMBIE");
	NspawnMob(nS34, "LAVASLIME");
	NspawnMob(nS35, "WITHER_SKELETON");
	NspawnMob(nS36, "WITHER_SKELETON");
	NspawnMob(nS37, "LAVASLIME");
	NspawnMob(nS38, "WITHER_SKELETON");
	NspawnMob(nS39, "WITHER_SKELETON");
	NspawnMob(nS39, "LAVASLIME");
	NspawnMob(nS40, "PIGZOMBIE");
	NspawnMob(nS41, "PIGZOMBIE");
	NspawnMob(nS42, "LAVASLIME");
	NspawnMob(nS43, "WITHER_SKELETON");
	NspawnMob(nS44, "LAVASLIME");
	NspawnMob(nS45, "WITHER_SKELETON");
	NspawnMob(nS46, "LAVASLIME");
	NspawnMob(nS47, "PIGZOMBIE");
	NspawnMob(nS47, "LAVASLIME");
	NspawnMob(nS48, "LAVASLIME");
	NspawnMob(nS49, "LAVASLIME");
	NspawnMob(nS49, "PIGZOMBIE");
	NspawnMob(nS50, "GHAST");
	NspawnMob(nS51, "BLAZE");
	NspawnMob(nS58, "BLAZE");
	NspawnMob(nS52, "BLAZE");
	NspawnMob(nS53, "GHAST");
        NspawnMob(nS51, "BLAZE");
	NspawnMob(nS54, "BLAZE");
	NspawnMob(nS55, "GHAST");
	NspawnMob(nS56, "BLAZE");
	NspawnMob(nS51, "BLAZE");
	NspawnMob(nS57, "BLAZE");
	NspawnMob(nS58, "GHAST");
	NspawnMob(nS51, "GHAST");
	NspawnMob(nS59, "BLAZE");
	NspawnMob(nS60, "PIGZOMBIE");

 else
         a_whisper_error(Message, "Joining the fight for Round 5.", player);

         end
      end
   end
end
end
end
end
end

function n_end_r5()
        if not player:hasItem("263", 25) then
	if check_alive_statsN() then
           nR5:cancel()
           nRoundRunning = false;
           nR5Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&fThe &6Nether Arena &fhas been defeated!")
           a_broadcast2(Overlord7, player.name .." has &adefeated &fthe &6Nether Arena&f!");
           a_broadcast3(Overlord7, player.name .." has &adefeated &fthe &6Nether Arena&f!");
           a_broadcast4(Overlord7, player.name .." has &adefeated &fthe &6Nether Arena&f!");
           player:sendEvent("achievement.netherchampion"); 
           nR1Done = false;
           nR2Done = false;
           nR3Done = false;
           nR4Done = false;
	   nR5Done = false;
	   nRLDone = false;
	   NarenaPlayers[player.name] = nil;
           NplayerCount = NplayerCount - 1;
	end
	end
end 

function n_end_r5_2()
        if player:hasItem("263", 25) then
	   player:removeItem("263", 25);
	if check_alive_statsN() then
           nR5:cancel()
           nRoundRunning = false;
           nR5Done = true;
for playerName, value in pairs(NarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(netherreset);
           a_broadcast_npc(Overlord, "&aRound 5 &fin the &6Nether Arena &fhas ended!")
	   player:sendMessage("&6 The arena is now over feel free to leave!");
           player:sendEvent("achievement.netherchampion"); 
	end
	end
end

registerHook("REGION_ENTER", "n_start_r5_2", "mobarena_nether-nether_round");

---------------------
--Nether r5 Rewards----
---------------------


local world = World:new('mobarena_nether');
local nR5Chest = Location:new(world, 5.0, 85.0, 47.0);
local nR5ChestOpen = Location:new(world, 5.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;
local nChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function nr5_rewards(data)
     local player = Player:new(data.player);
		nChestPlayers[player.name] = true;
		nR5Chest:cloneChestToPlayer(player.name);
                lobbysound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 5 Rewards: you earned 15 Mob Bones!");
		end
	

registerHook("REGION_ENTER", "nr4_rewards", "mobarena_nether-nether_rewards");


---------------------------------------
-----------Lightning---------
---------------------------------------

function n_start_light(data)
        for playerName, value in pairs(NarenaPlayers) do
         local player = Player:new(data.player);
      if nR1Done then
      if nR2Done then
      if nR3Done then
      if nR4Done then
      if nR5Done then
      if not nRoundRunning then
             nLRoundRunning = true;
         nRL:startRepeating()
         nethersound:playSound('ENTITY_HORSE_ANGRY', 1, 2);
	 nethersound:playSound('ENTITY_HORSE_HURT', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started the &aLightning Round! &fRound rewards are &6increased!");
         a_whisper_good(Message, "&cA lightning round has started, kill all the bosses and its minons!", player);
	  a_broadcast2(Overlord9, player.name .." &fA &aLightning Round &fhas started in the &6Nether &fArena!");
           a_broadcast3(Overlord9, player.name .."&fA &aLightning Round &fhas started in the &6Nether &fArena!");
           a_broadcast4(Overlord9, player.name .." &fA &aLightning Round &fhas started in the &6Nether &fArena!");
	 a_whisper_good(Message, "&eLook out &219 &emobs and &22 &eBosses are spawning in!", player);
		NspawnMob(nS50, "WITHER");
	        NspawnMob(nS51, "BLAZE");
	        NspawnMob(nS52, "BLAZE");
	        NspawnMob(nS53, "BLAZE");
	        NspawnMob(nS54, "WITHER");
	        NspawnMob(nS55, "BLAZE");
	        NspawnMob(nS56, "BLAZE");
	        NspawnMob(nS57, "BLAZE");
	        NspawnMob(nS58, "BLAZE");
	        NspawnMob(nS59, "BLAZE");
		NspawnMob(nS10, "WITHER_SKELETON");
	        NspawnMob(nS22, "WITHER_SKELETON");
	        NspawnMob(nS33, "WITHER_SKELETON");
	        NspawnMob(nS44, "WITHER_SKELETON");
	        NspawnMob(nS30, "WITHER_SKELETON");
	        NspawnMob(nS60, "WITHER_SKELETON");
	        NspawnMob(nS17, "WITHER_SKELETON");
	        NspawnMob(nS19, "WITHER_SKELETON");
	        NspawnMob(nS9, "WITHER_SKELETON");
	        NspawnMob(nS24, "WITHER_SKELETON");
	        NspawnMob(nS18, "WITHER_SKELETON");

								end
							end
						end
					end
				end
			end
		end


function n_end_light()
	if check_alive_statsN() then
	if nLRoundRunning then
           nRL:cancel()
           nLRoundRunning = false;
           nRLDone = true;
           for playerName, value in pairs(NarenaPlayers) do
           local player = Player:new(playerName);
	   player:teleport(nlrewards);
           a_broadcast_npc(Overlord, "&aThe Lightning round has ended!")
	   player:sendEvent("achievement.lightninground");
			end
		end
	end
end
	

registerHook("REGION_ENTER", "n_start_light", "mobarena_nether-nether_round");

------------------------------------------------------
----Lightning Rewards----------
--------------------------------------------------------

local world = World:new('mobarena_nether');
local nRLChest = Location:new(world, 7.0, 85.0, 47.0);
local nRLChestOpen = Location:new(world, 7.0, 85.0, 47.0);
local nChestPlayers = {};
local nChestTimerRunning = false;

function nrL_rewards(data)
     local player = Player:new(data.player);
	if not nRoundRunning then 
	if nR1Done then
	if nR2Done then
	if nR3Done then
        if nR4Done then
	if nR5Done then
	if nRLDone then
		nChestPlayers[player.name] = true;
		player:closeInventory();
		nRLChest:cloneChestToPlayer(player.name);
                nethersound:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dLightning Round Rewards: you earned 30 Mob Bones!");
		player:sendMessage("&6 The arena is now over feel free to leave!");
							end 
						end
					end
				end
			end
		end
	end
										end

registerHook("REGION_ENTER", "nrL_rewards", "mobarena_nether-nrl_rewards");
	
