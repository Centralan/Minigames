local world = World:new('mobarena');

--------
-----AI---
----------

local PVEAI = AI:new("SERVER", "WIZARD", "mobarena"); --temple ai
local surfacestart = 'PVE'
local Overlord4 = '&d[PvE] &fA Player has &ajoined &6Surface Arena&f.'
local Overlord5 = '&d[PvE] &fA Player has &adefeated &6Surface Arena&f.'

function a_broadcast(msg)
	world:broadcast(msg);
end

function a_whisper_error(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&c' .. msg);
end

--------------------------------
----Player Control--
----------------------------------

local arenaPlayers = {};
local playerCount = 0;

--------------------------------
----Mob Control--
----------------------------------

local entityList = {};

local function spawnMob(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
	table.insert(entityList, entity);
end

local function purgeEntityList()
	for index, value in pairs(entityList) do
		entityList[index] = nil;
	end
end

function check_alive_stats()
	for key, value in pairs(entityList) do
		if value:isAlive() then
			return false;
		end
	end

	return true;
end

---------------------
----Toggles------
-----------------------

local sR1Done = false;
local sR2Done = false;
local sR3Done = false;
local sR4Done = false;
local sR5Done = false;
local sRoundRunning = false;

---------------------
----Timers------
-----------------------

local R1 = Timer:new("end_r1", 1);
local R2 = Timer:new("end_r2", 1);
local R3 = Timer:new("end_r3", 1);
local R4 = Timer:new("end_r4", 1);
local R5 = Timer:new("reset_rounds", 1);

---------------------
----Teleports------
-----------------------

local surfacearenaenter = Location:new(world, 41, 67, 1);
local surfacearenaexit = Location:new(world, 837, 97, 149);
local surfaceround5 = Location:new(world, 834, 119, 153);
local pve1reset = Location:new(world, -2.7, 74, -0);
local world = World:new('mobarena');
local GearChest = Location:new(world, 834.0, 133.0, 164.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function tp_to_arena(data)
       if playerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(surfacearenaenter);
	  GearChest:cloneChestToPlayer(player.name);
	  player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
	  player:sendMessage("&dYou have been granted with free gear.");
          arenaPlayers[player.name] = true;
          playerCount = playerCount + 1;
          a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Surface Arena&f!");
        else
         local player = Player:new(data.player);
          a_whisper_error(Message, "Sorry this Arena is full, try joining when someone leaves!", player);
          player:teleport(surfacearenaexit);
  end
end

function button_out_arena(data)
        local player = Player:new(data.player);
          player:teleport(surfacearenaexit);
          arenaPlayers[player.name] = nil;
          playerCount = playerCount - 1;
	  a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Surface Arena&f!");
end

function command_out_arena(data)
        local player = Player:new(data.player);
          player:teleport(surfacearenaexit);
          arenaPlayers[player.name] = nil;
          playerCount = playerCount - 1;
          a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Surface Arena&f!");
end

registerHook("REGION_ENTER", "tp_to_arena", "mobarena-portal_surfacearena_multi");
registerHook("INTERACT", "button_out_arena", 77, "mobarena", 30, 65, -2);
registerHook("REGION_LEAVE", "command_out_arena", "mobarena-pve_sur_main");

--------------------------
----Respawning/Game Over----
----------------------------

local surfacerespawn = Location:new(world, 41, 67, 1);
local respawngear = Location:new(world, 48, 67, 1);

function respawn_surface(data)
       if sRoundRunning then
         for playerName, value in pairs(arenaPlayers) do
             local player = Player:new(data.player);
             player:setHealth(20);
             player:teleport(surfacerespawn);

      end
   end
end

registerHook("PLAYER_DEATH", "respawn_surface", "mobarena");

---------------------------------------
---mob spawn points------
----------------------------------------

local rS1 = Location:new(world, 27.0, 65.0, -5.0);
local rS2 = Location:new(world, 27.0, 65.0, 3.0);
local rS3 = Location:new(world, 20.0, 65.0, -1.0);
local rS4 = Location:new(world, 15.0, 65.0, -7.0);
local rS5 = Location:new(world, 7.0, 65.0, -12.0);
local rS6 = Location:new(world, 12.0, 65.0, 9.0);
local rS7 = Location:new(world, 4.0, 65.0, 15.0);
local rS8 = Location:new(world, 0.0, 65.0, 15.0);
local rS9 = Location:new(world, -3.0, 65.0, -1.0);
local rS10 = Location:new(world, 0.0, 65.0, -18.0);
local rS11 = Location:new(world, 0.0, 65.0, -30.0);
local rS12 = Location:new(world, -14.0, 65.0, -22.0);
local rS13 = Location:new(world, -14.0, 65.0, -11.0);
local rS14 = Location:new(world, -18.0, 65.0, -1.0);
local rS15 = Location:new(world, -20.0, 65.0, -12.0);
local rS16 = Location:new(world, -29.0, 66.0, -2.0);
local rS17 = Location:new(world, -27.0, 66.0, 4.0);
local rS18 = Location:new(world, -14.0, 65.0, 12.0);
local rS19 = Location:new(world, -24.0, 68.0, 21.0);
local rS20 = Location:new(world, -14.0, 65.0, 18.0);
local rS21 = Location:new(world, -6.0, 65.0, 25.0);
local rS22 = Location:new(world, -1.0, 65.0, 29.0);

-----------------------
-----ROUND 1 (20 Mobs)---
-------------------------

function start_r1(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if not sR1Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R1:startRepeating()
         player:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         PVEAI:speak( player.name .. " has started round 1 in the Surface Arena.");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS2, "ZOMBIE");
	spawnMob(rS3, "SKELETON");
	spawnMob(rS4, "SKELETON");
	spawnMob(rS5, "ZOMBIE");
	spawnMob(rS6, "ZOMBIE");
	spawnMob(rS7, "SKELETON");
	spawnMob(rS8, "SKELETON");
	spawnMob(rS9, "ZOMBIE");
	spawnMob(rS10, "SKELETON");
	spawnMob(rS11, "ZOMBIE");
	spawnMob(rS12, "SKELETON");
	spawnMob(rS20, "ZOMBIE");
	spawnMob(rS13, "ZOMBIE");
	spawnMob(rS14, "SKELETON");
	spawnMob(rS15, "SKELETON");
	spawnMob(rS16, "ZOMBIE");
	spawnMob(rS17, "ZOMBIE");
	spawnMob(rS18, "SKELETON");
	spawnMob(rS19, "SKELETON");

      else
         a_whisper_error(Message, "Round 1 Already Running!", player);

         end
      end
   end
end

function end_r1()
	if check_alive_stats() then
           R1:cancel()
           sRoundRunning = false;
           sR1Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve1reset);
           a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Surface Arena &fhas ended!")
	end
	end
end 


registerHook("REGION_ENTER", "start_r1", "mobarena-surface_start"); 

------------------------------------------------------
----R1 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local R1Chest = Location:new(world, -52.0, 114.0, 9.0);
local R1ChestOpen = Location:new(world, -3.0, 65.0, -1.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function r1_rewards(data)
     local player = Player:new(data.player);
	if not sRoundRunning then 
	if sR1Done then
	if not sR2Done then
	if not sR3Done then
        if not sR4Done then
        if not sR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		R1Chest:cloneChestToPlayer(player.name);
                player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 1 Rewards: you earned 2 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "r1_rewards", "mobarena-pve1_reset");


-----------------------
-----ROUND 2 (25 Mobs)---
-------------------------

function start_r2(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR1Done then
      if not sR2Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R2:startRepeating()
         player:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 2 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 2 has started, kill all mobs to move to Round 3.", player);
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS2, "SKELETON");
	spawnMob(rS3, "SKELETON");
	spawnMob(rS4, "SPIDER");
	spawnMob(rS5, "ZOMBIE");
	spawnMob(rS6, "SKELETON");
	spawnMob(rS7, "SKELETON");
	spawnMob(rS8, "SPIDER");
	spawnMob(rS9, "SPIDER");
	spawnMob(rS10, "ZOMBIE");
	spawnMob(rS11, "SKELETON");
	spawnMob(rS12, "SPIDER");
	spawnMob(rS13, "SPIDER");
	spawnMob(rS14, "SPIDER");
	spawnMob(rS15, "ZOMBIE");
	spawnMob(rS16, "SKELETON");
	spawnMob(rS17, "SKELETON");
	spawnMob(rS18, "SPIDER");
	spawnMob(rS19, "SPIDER");
	spawnMob(rS20, "ZOMBIE");
	spawnMob(rS21, "ZOMBIE");
	spawnMob(rS22, "SKELETON");
	spawnMob(rS11, "SKELETON");
	spawnMob(rS18, "SKELETON");

      else
         a_whisper_error(Message, "Round 2 Already Running!", player);
 
            end
         end
      end
   end
end

function end_r2()
	if check_alive_stats() then
           R2:cancel()
           sRoundRunning = false;
           sR2Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve1reset);
           a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Surface Arena &fhas ended!")
	end
	end
end

registerHook("REGION_ENTER", "start_r2", "mobarena-surface_start"); 

------------------------------------------------------
----R2 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local R2Chest = Location:new(world, -52.0, 114.0, 11.0);
local R2ChestOpen = Location:new(world, -3.0, 65.0, -1.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function r2_rewards(data)
     local player = Player:new(data.player);
	if not sRoundRunning then 	
	if sR1Done then
	if sR2Done then
	if not sR3Done then
        if not sR4Done then
        if not sR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		R1Chest:cloneChestToPlayer(player.name);
                player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 2 Rewards: you earned 3 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "r2_rewards", "mobarena-pve1_reset");

-----------------------
-----ROUND 3 (30 Mobs)---
-------------------------

function start_r3(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR2Done then
      if not sR3Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R3:startRepeating()
         player:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 3 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 3 has started, kill all mobs to move to Round 4.", player);
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS2, "VINDICATOR");
	spawnMob(rS3, "HUSK");
	spawnMob(rS4, "VINDICATOR");
	spawnMob(rS5, "SPIDER");
	spawnMob(rS6, "SKELETON");
	spawnMob(rS7, "ZOMBIE");
	spawnMob(rS8, "ZOMBIE");
	spawnMob(rS9, "HUSK");
	spawnMob(rS10, "SPIDER");
	spawnMob(rS11, "SKELETON");
	spawnMob(rS12, "SKELETON");
	spawnMob(rS13, "ZOMBIE");
	spawnMob(rS14, "HUSK");
	spawnMob(rS15, "VINDICATOR");
	spawnMob(rS16, "SPIDER");
	spawnMob(rS17, "SPIDER");
	spawnMob(rS18, "WITCH");
	spawnMob(rS19, "ZOMBIE");
	spawnMob(rS20, "ZOMBIE");
	spawnMob(rS21, "HUSK");
	spawnMob(rS22, "CREEPER");
	spawnMob(rS1, "SPIDER");
	spawnMob(rS5, "SPIDER");
	spawnMob(rS9, "ZOMBIE");
	spawnMob(rS11, "HUSK");
	spawnMob(rS15, "VINDICATOR");
	spawnMob(rS17, "SKELETON");
	spawnMob(rS19, "SKELETON");
	spawnMob(rS20, "SPIDER");

      else
         a_whisper_error(Message, "Round 3 Already Running!", player);
 
            end
         end
      end
   end
end

function end_r3()
	if check_alive_stats() then
           R3:cancel()
           sRoundRunning = false;
           sR3Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve1reset);
           a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Surface Arena &fhas ended!")
	end
		end
end

registerHook("REGION_ENTER", "start_r3", "mobarena-surface_start"); 

--R3 REWARDS--

local world = World:new('mobarena');
local R3Chest = Location:new(world, -52.0, 114.0, 13.0);
local R3ChestOpen = Location:new(world, -3.0, 65.0, -1.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function r3_rewards(data)
     local player = Player:new(data.player);
	if not sRoundRunning then 	
	if sR1Done then
	if sR2Done then
	if sR3Done then
        if not sR4Done then
        if not sR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		R3Chest:cloneChestToPlayer(player.name);
                player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 3 Rewards: you earned 4 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end

registerHook("REGION_ENTER", "r3_rewards", "mobarena-pve1_reset");

-----------------------
-----ROUND 4 (35 Mobs)---
-------------------------

function start_r4(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR3Done then
      if not sR4Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R4:startRepeating()
         player:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 4 has started, kill all mobs to move to Round 5.", player);
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS2, "WITCH");
	spawnMob(rS3, "VINDICATOR");
	spawnMob(rS4, "SPIDER");
	spawnMob(rS5, "SPIDER");
	spawnMob(rS6, "SKELETON");
	spawnMob(rS7, "SKELETON");
	spawnMob(rS8, "ZOMBIE");
	spawnMob(rS9, "ZOMBIE");
	spawnMob(rS10, "HUSK");
	spawnMob(rS11, "SPIDER");
	spawnMob(rS12, "SPIDER");
	spawnMob(rS13, "ENDERMAN");
	spawnMob(rS14, "SKELETON");
	spawnMob(rS15, "ZOMBIE");
	spawnMob(rS16, "WITCH");
	spawnMob(rS17, "HUSK");
	spawnMob(rS18, "VINDICATOR");
	spawnMob(rS19, "SPIDER");
	spawnMob(rS20, "ENDERMAN");
	spawnMob(rS21, "SKELETON");
	spawnMob(rS22, "ZOMBIE");
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS5, "WITCH");
	spawnMob(rS8, "SPIDER");
	spawnMob(rS9, "SPIDER");
	spawnMob(rS10, "SKELETON");
	spawnMob(rS13, "SKELETON");
	spawnMob(rS15, "ZOMBIE");
	spawnMob(rS19, "VINDICATOR");
	spawnMob(rS20, "VINDICATOR");
	spawnMob(rS22, "SPIDER");
	spawnMob(rS6, "SPIDER");
	spawnMob(rS12, "ENDERMAN");
	spawnMob(rS17, "SKELETON");

      else
         a_whisper_error(Message, "Round 4 Already Running!", player);
 
            end
         end
      end
   end
end

function end_r4()
	if check_alive_stats() then
           R4:cancel()
           sRoundRunning = false;
           sR4Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve1reset);
           a_broadcast_npc(Overlord, "&aRound 4 &fin the &6Surface Arena &fhas ended!")
	end
		end
end

registerHook("REGION_ENTER", "start_r4", "mobarena-surface_start"); 

------------------------------------------------------
----R4 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local R4Chest = Location:new(world, -52.0, 114.0, 15.0);
local R4ChestOpen = Location:new(world, -3.0, 65.0, -1.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function r4_rewards(data)
     local player = Player:new(data.player);
	if not sRoundRunning then 	
	if sR1Done then
	if sR2Done then
	if sR3Done then
        if sR4Done then
        if not sR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		R4Chest:cloneChestToPlayer(player.name);
                player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 4 Rewards: you earned 5 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end

registerHook("REGION_ENTER", "r4_rewards", "mobarena-pve1_reset");

-----------------------
-----ROUND 5 (40 Mobs)---
-------------------------

function start_r5(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR4Done then
      if not sR5Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R5:startRepeating()
         player:playSound('BLOCK_PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 5 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 5 has started, kill all mobs to beat the arena!", player);
	spawnMob(rS1, "ZOMBIE");
	spawnMob(rS2, "ZOMBIE");
	spawnMob(rS3, "ILLUSIONER");
	spawnMob(rS4, "SPIDER");
	spawnMob(rS5, "SPIDER");
	spawnMob(rS6, "HUSK");
	spawnMob(rS7, "SKELETON");
	spawnMob(rS8, "WITCH");
	spawnMob(rS9, "ZOMBIE");
	spawnMob(rS10, "ZOMBIE");
	spawnMob(rS11, "EVOKER");
	spawnMob(rS12, "ENDERMAN");
	spawnMob(rS13, "SPIDER");
	spawnMob(rS14, "SKELETON");
	spawnMob(rS15, "SKELETON");
	spawnMob(rS16, "WITCH");
	spawnMob(rS17, "ZOMBIE");
	spawnMob(rS18, "HUSK");
	spawnMob(rS19, "EVOKER");
	spawnMob(rS20, "ILLUSIONER");
	spawnMob(rS21, "SPIDER");
	spawnMob(rS22, "SKELETON");
	spawnMob(rS1, "WITCH");
	spawnMob(rS5, "ENDERMAN");
	spawnMob(rS7, "ZOMBIE");
	spawnMob(rS9, "ZOMBIE");
	spawnMob(rS11, "EVOKER");
	spawnMob(rS13, "ENDERMAN");
	spawnMob(rS15, "EVOKER");
	spawnMob(rS17, "SPIDER");
	spawnMob(rS19, "SPIDER");
	spawnMob(rS21, "WITCH");
	spawnMob(rS2, "ZOMBIE");
	spawnMob(rS4, "EVOKER");
	spawnMob(rS6, "HUSK");
	spawnMob(rS8, "GIANT");
	spawnMob(rS10, "SKELETON");
	spawnMob(rS12, "WITCH");
	spawnMob(rS14, "WITCH");
	spawnMob(rS16, "ENDERMAN");

      else
         a_whisper_error(Message, "Round 5 Already Running!", player);
 
            end
         end
      end
   end
end

function reset_rounds()
	if check_alive_stats() then
           R5:cancel()
           sRoundRunning = false;
           sR1Done = false;
           sR2Done = false;
           sR3Done = false;
           sR4Done = false;
           a_broadcast_npc(Overlord, "The &6Surface Arena &fhas been &adefeated&f!");
         for playerName, value in pairs(arenaPlayers) do
             local player = Player:new(playerName);
             player:teleport(surfaceround5);
             arenaPlayers[player.name] = nil;
             playerCount = playerCount - 1;

      end
   end
end 

registerHook("REGION_ENTER", "start_r5", "mobarena-surface_start"); 

------------------------------------------------------
----R5 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local R5Chest = Location:new(world, -52.0, 114.0, 17.0);
local R5ChestOpen = Location:new(world, -3.0, 65.0, -1.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function r5_rewards(data)
     local player = Player:new(data.player);
		ChestPlayers[player.name] = true;
		player:closeInventory();
		R5Chest:cloneChestToPlayer(player.name);
                player:playSound('ENTITY_HORSE_SADDLE', 1, 0);
	        player:sendEvent("achievement.surfacechampion");
                player:sendMessage("&dRound 5 Rewards: you earned 6 Mob Bones!");
								end
					
	
registerHook("REGION_ENTER", "r5_rewards", "mobarena-pve1_r5");

