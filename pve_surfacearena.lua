local myWorld = World:new('mobarena');
local surfacesound = Location:new(myWorld, -3, 65, -1);

--------
---AI---
--------

local Overlord = 'PVE'
local Message = ''
local Message2 = ''

function a_broadcast(msg)
	myWorld:broadcast(msg);
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
--Player Control--
--------------------------------

local arenaPlayers = {};
local playerCount = 0;

--------------------------------
--Mob Control--
--------------------------------

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
--Toggles------
---------------------

--To know when a Round is completed.
local sR1Done = false;
local sR2Done = false;
local sR3Done = false;
local sR4Done = false;
local sR5Done = false;
--To know when a Round is in-progress.
local sRoundRunning = false;

---------------------
--Timers------
---------------------

local R1 = Timer:new("end_r1", 1);
local R2 = Timer:new("end_r2", 1);
local R3 = Timer:new("end_r3", 1);
local R4 = Timer:new("end_r4", 1);
local R5 = Timer:new("reset_rounds", 1);

---------------------
--Teleports------
---------------------

local surfacearenaenter = Location:new(myWorld, 41, 67, 1);
local surfacearenaexit = Location:new(myWorld, 837, 97, 149);


function tp_to_arena(data)
       if playerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(surfacearenaenter);
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

registerHook("REGION_ENTER", "tp_to_arena", "mobarena-portal_surfacearena_multi");
registerHook("INTERACT", "button_out_arena", 77, "mobarena", 30, 65, -2);

--------------------------
--Respawning/Game Over----
--------------------------

local surfacerespawn = Location:new(myWorld, 41, 67, 1);
local respawngear = Location:new(myWorld, 48, 67, 1);

--When Player dies repspawn here.
function respawn(data)
       if sRoundRunning then
         for playerName, value in pairs(arenaPlayers) do
             local player = Player:new(data.player);
             respawngear:cloneChestToPlayer(player.name);
             player:setHealth(20);
             player:teleport(surfacerespawn);

      end
   end
end

registerHook("PLAYER_DEATH", "respawn", "mobarena");


-----------------------
---ROUND 1 (20 Mobs)---
-----------------------

--Has Nothing
--Added Zombies, Skellys

local R1S1 = Location:new(myWorld, 10.0, 65.0, 11.0);
local R1S2 = Location:new(myWorld, 22.0, 65.0, -4.0);
local R1S3 = Location:new(myWorld, 4.0, 65.0,-4.0);
local R1S4 = Location:new(myWorld, -14.0, 66.0, -14.0);
local R1S5 = Location:new(myWorld, -27.0, 66.0, 7.0);

function start_r1(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if not sR1Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R1:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	spawnMob(R1S1, "ZOMBIE");
	spawnMob(R1S1, "ZOMBIE");
	spawnMob(R1S1, "SKELETON");
	spawnMob(R1S1, "SKELETON");
	spawnMob(R1S2, "ZOMBIE");
	spawnMob(R1S2, "ZOMBIE");
	spawnMob(R1S2, "SKELETON");
	spawnMob(R1S2, "SKELETON");
	spawnMob(R1S3, "ZOMBIE");
	spawnMob(R1S3, "SKELETON");
	spawnMob(R1S3, "ZOMBIE");
	spawnMob(R1S3, "SKELETON");
	spawnMob(R1S4, "ZOMBIE");
	spawnMob(R1S4, "ZOMBIE");
	spawnMob(R1S4, "SKELETON");
	spawnMob(R1S4, "SKELETON");
	spawnMob(R1S5, "ZOMBIE");
	spawnMob(R1S5, "ZOMBIE");
	spawnMob(R1S5, "SKELETON");
	spawnMob(R1S5, "SKELETON");

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
           a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Surface Arena &fhas ended!")
	end
end 

registerHook("INTERACT", "start_r1", 143, "mobarena", -7.0, 66.0, 1.0);   

-----------------------
---ROUND 2 (25 Mobs)---
-----------------------

--Has Zombies, Skellys
--Added Spiders

local R2S1 = Location:new(myWorld, 28.0, 65.0, 5.0);
local R2S2 = Location:new(myWorld, 0.0, 65.0, -30.0);
local R2S3 = Location:new(myWorld, -30.0, 66.0, 1.0);
local R2S4 = Location:new(myWorld, -23.0, 66.0, 20.0);
local R2S5 = Location:new(myWorld, -1.0, 65.0, 30.0);


function start_r2(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR1Done then
      if not sR2Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R2:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 2 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 2 has started, kill all mobs to move to Round 3.", player);
	spawnMob(R2S1, "ZOMBIE");
	spawnMob(R2S1, "ZOMBIE");
	spawnMob(R2S1, "SKELETON");
	spawnMob(R2S1, "SKELETON");
	spawnMob(R2S1, "SPIDER");
	spawnMob(R2S2, "ZOMBIE");
	spawnMob(R2S2, "SKELETON");
	spawnMob(R2S2, "SKELETON");
	spawnMob(R2S2, "SPIDER");
	spawnMob(R2S2, "SPIDER");
	spawnMob(R2S3, "ZOMBIE");
	spawnMob(R2S3, "SKELETON");
	spawnMob(R2S3, "SPIDER");
	spawnMob(R2S3, "SPIDER");
	spawnMob(R2S3, "SPIDER");
	spawnMob(R2S4, "ZOMBIE");
	spawnMob(R2S4, "SKELETON");
	spawnMob(R2S4, "SKELETON");
	spawnMob(R2S4, "SPIDER");
	spawnMob(R2S4, "SPIDER");
	spawnMob(R2S5, "ZOMBIE");
	spawnMob(R2S5, "ZOMBIE");
	spawnMob(R2S5, "SKELETON");
	spawnMob(R2S5, "SKELETON");
	spawnMob(R2S5, "SKELETON");

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
           a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Surface Arena &fhas ended!");
	end
end 

registerHook("INTERACT", "start_r2", 143, "mobarena", -7.0, 66.0, 0.0);  

-----------------------
---ROUND 3 (30 Mobs)---
-----------------------

--Has Zombies, Skellys, Spiders
--Added Creeper, Witches

local R3S1 = Location:new(myWorld, -20.0, 65.0, -13.0);
local R3S2 = Location:new(myWorld, 22.0, 67.0, -16.0);
local R3S3 = Location:new(myWorld, 15.0, 65.0, 9.0);
local R3S4 = Location:new(myWorld, -10.0, 65.0, 26.0);
local R3S5 = Location:new(myWorld, -21.0, 65.0, 7.0);


function start_r3(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR2Done then
      if not sR3Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R3:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 3 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 3 has started, kill all mobs to move to Round 4.", player);
	spawnMob(R3S1, "ZOMBIE");
	spawnMob(R3S1, "ZOMBIE");
	spawnMob(R3S1, "CREEPER");
	spawnMob(R3S1, "SPIDER");
	spawnMob(R3S1, "SPIDER");
	spawnMob(R3S1, "SKELETON");
	spawnMob(R3S2, "ZOMBIE");
	spawnMob(R3S2, "ZOMBIE");
	spawnMob(R3S2, "CREEPER");
	spawnMob(R3S2, "SPIDER");
	spawnMob(R3S2, "SKELETON");
	spawnMob(R3S2, "SKELETON");
	spawnMob(R3S3, "ZOMBIE");
	spawnMob(R3S3, "CREEPER");
	spawnMob(R3S3, "CREEPER");
	spawnMob(R3S3, "SPIDER");
	spawnMob(R3S3, "SPIDER");
	spawnMob(R3S3, "WITCH");
	spawnMob(R3S4, "ZOMBIE");
	spawnMob(R3S4, "ZOMBIE");
	spawnMob(R3S4, "CREEPER");
	spawnMob(R3S4, "CREEPER");
	spawnMob(R3S4, "SPIDER");
	spawnMob(R3S4, "SPIDER");
	spawnMob(R3S5, "ZOMBIE");
	spawnMob(R3S5, "CREEPER");
	spawnMob(R3S5, "CREEPER");
	spawnMob(R3S5, "SKELETON");
	spawnMob(R3S5, "SKELETON");
	spawnMob(R3S5, "SPIDER");

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
           a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Surface Arena &fhas ended!");
	end
end 

registerHook("INTERACT", "start_r3", 143, "mobarena", -7.0, 66.0, -1.0); 

-----------------------
---ROUND 4 (35 Mobs)---
-----------------------

--Has Zombies, Skellys, Spiders, Creeper, Witches
--Added Endermen

local R4S1 = Location:new(myWorld, -18.0, 65.0, -3.0);
local R4S2 = Location:new(myWorld, -8.0, 65.0, 20.0);
local R4S3 = Location:new(myWorld, 6.0, 65.0, 11.0);
local R4S4 = Location:new(myWorld, 25.0, 65.0, 20.0);
local R4S5 = Location:new(myWorld, 5.0, 65.0, -20.0);


function start_r4(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR3Done then
      if not sR4Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R4:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 4 has started, kill all mobs to move to Round 5.", player);
	spawnMob(R4S1, "ZOMBIE");
	spawnMob(R4S1, "WITCH");
	spawnMob(R4S1, "CREEPER");
	spawnMob(R4S1, "SPIDER");
	spawnMob(R4S1, "SPIDER");
	spawnMob(R4S1, "SKELETON");
	spawnMob(R4S1, "SKELETON");
	spawnMob(R4S2, "ZOMBIE");
	spawnMob(R4S2, "ZOMBIE");
	spawnMob(R4S2, "CREEPER");
	spawnMob(R4S2, "SPIDER");
	spawnMob(R4S2, "SPIDER");
	spawnMob(R4S2, "ENDERMAN");
	spawnMob(R4S2, "SKELETON");
	spawnMob(R4S3, "ZOMBIE");
	spawnMob(R4S3, "WITCH");
	spawnMob(R4S3, "CREEPER");
	spawnMob(R4S3, "CREEPER");
	spawnMob(R4S3, "SPIDER");
	spawnMob(R4S3, "ENDERMAN");
	spawnMob(R4S3, "SKELETON");
	spawnMob(R4S4, "ZOMBIE");
	spawnMob(R4S4, "ZOMBIE");
	spawnMob(R4S4, "WITCH");
	spawnMob(R4S4, "SPIDER");
	spawnMob(R4S4, "SPIDER");
	spawnMob(R4S4, "SKELETON");
	spawnMob(R4S4, "SKELETON");
	spawnMob(R4S5, "ZOMBIE");
	spawnMob(R4S5, "CREEPER");
	spawnMob(R4S5, "CREEPER");
	spawnMob(R4S5, "SPIDER");
	spawnMob(R4S5, "SPIDER");
	spawnMob(R4S5, "ENDERMAN");
	spawnMob(R4S5, "SKELETON");

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
           a_broadcast_npc(Overlord, "&aRound 4 &fin the &6Surface Arena &fhas ended!");
	end
end 

registerHook("INTERACT", "start_r4", 143, "mobarena", -7.0, 66.0, -2.0);

-----------------------
---ROUND 5 (40 Mobs)---
-----------------------

--Has Zombies, Skellys, Spiders, Creeper, Witches, Endermen
--Added Giants

local R5S1 = Location:new(myWorld, 6.0, 65.0, -13.0);
local R5S2 = Location:new(myWorld, -25.0, 65.0, -18.0);
local R5S3 = Location:new(myWorld, 9.0, 65.0, 29.0);
local R5S4 = Location:new(myWorld, 18.0, 65.0, 2.0);
local R5S5 = Location:new(myWorld, -15.0, 65.0, 12.0);


function start_r5(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if sR4Done then
      if not sR5Done then
      if not sRoundRunning then  
         sRoundRunning = true;
         R5:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 5 &fin the &6Surface Arena&f!");
         a_whisper_good(Message, "&cRound 5 has started, kill all mobs to beat the arena!", player);
	spawnMob(R5S1, "ZOMBIE");
	spawnMob(R5S1, "ZOMBIE");
	spawnMob(R5S1, "CREEPER");
	spawnMob(R5S1, "SPIDER");
	spawnMob(R5S1, "SPIDER");
	spawnMob(R5S1, "GIANT");
	spawnMob(R5S1, "SKELETON");
	spawnMob(R5S1, "WITCH");
	spawnMob(R5S2, "ZOMBIE");
	spawnMob(R5S2, "ZOMBIE");
	spawnMob(R5S2, "CREEPER");
	spawnMob(R5S2, "ENDERMAN");
	spawnMob(R5S2, "SPIDER");
	spawnMob(R5S2, "SKELETON");
	spawnMob(R5S2, "SKELETON");
	spawnMob(R5S2, "WITCH");
	spawnMob(R5S3, "ZOMBIE");
	spawnMob(R5S3, "CREEPER");
	spawnMob(R5S3, "CREEPER");
	spawnMob(R5S3, "CREEPER");
	spawnMob(R5S3, "SPIDER");
	spawnMob(R5S3, "SKELETON");
	spawnMob(R5S3, "WITCH");
	spawnMob(R5S3, "ENDERMAN");
	spawnMob(R5S4, "ZOMBIE");
	spawnMob(R5S4, "ZOMBIE");
	spawnMob(R5S4, "CREEPER");
	spawnMob(R5S4, "ENDERMAN");
	spawnMob(R5S4, "CREEPER");
	spawnMob(R5S4, "SPIDER");
	spawnMob(R5S4, "SPIDER");
	spawnMob(R5S4, "WITCH");
	spawnMob(R5S5, "ZOMBIE");
	spawnMob(R5S5, "CREEPER");
	spawnMob(R5S5, "CREEPER");
	spawnMob(R5S5, "GIANT");
	spawnMob(R5S5, "SKELETON");
	spawnMob(R5S5, "WITCH");
	spawnMob(R5S5, "WITCH");
	spawnMob(R5S5, "ENDERMAN");

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
             player:teleport(surfacearenaexit);
             player:sendEvent("achievement.mobgrinder");
            local player = Player:new(data.player);
             arenaPlayers[player.name] = nil;
             playerCount = playerCount - 1;

      end
   end
end 

registerHook("INTERACT", "start_r5", 143, "mobarena", -7.0, 66.0, -3.0);

------------------------------------------------------
--R1 Rewards----------
------------------------------------------------------

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
                surfacesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 1 Rewards: you earned 2 Mob Bones!";
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("INTERACT", "r1_rewards", 54, "mobarena", -3.0, 65.0, -1.0);

------------------------------------------------------
--R2 Rewards----------
------------------------------------------------------


local world = World:new('mobarena');
local R2Chest = Location:new(world, -52.0, 114.0, 9.0);
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
                surfacesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 1 Rewards: you earned 3 Mob Bones!";
						end
					end
				end
			end
		end
	end
	

registerHook("INTERACT", "r2_rewards", 54, "mobarena", -3.0, 65.0, -1.0);
