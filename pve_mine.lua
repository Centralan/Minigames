local myWorld = World:new('mobarena');
local myWorld2 = World:new('spawn2');
local myWorld3 = World:new('survival3');
local myWorld4 = World:new('creative');
local minesound = Location:new(myWorld, -2999.0, 111.0, 3001.0);

--------
---AI---
--------

local Overlord = 'PVE'
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
local mR1Done = false;
local mR2Done = false;
local mR3Done = false;
local mR4Done = false;
local mR5Done = false;
--To know when a Round is in-progress.
local mRoundRunning = false;

---------------------
--Timers------
---------------------

local mR1 = Timer:new("end_r1", 1);
local mR2 = Timer:new("end_r2", 1);
local mR3 = Timer:new("end_r3", 1);
local mR4 = Timer:new("end_r4", 1);
local mR5 = Timer:new("reset_rounds", 1);

---------------------
--Teleports------
---------------------

local minearenaenter = Location:new(myWorld, -3000.0, 105.0, 2975.0);
local minearenaexit = Location:new(myWorld, -837.0, 97, 149.0);
local mineround5 = Location:new(myWorld, 836, 119, 153);
local pve2reset = Location:new(myWorld, -2999.0, 118, -3001.0);
local world = World:new('mobarena');
local GearChest = Location:new(world, 834.0, 133.0, 164.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);


function tp_to_arena(data)
       if playerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(minearenaenter);
	  GearChest:cloneChestToPlayer(player.name);
	  minesound:playSound('HORSE_SADDLE', 1, 0);
	  player:sendMessage("&dYou have been granted with free gear.");
          arenaPlayers[player.name] = true;
          playerCount = playerCount + 1;
         a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Mine Arena&f!");
	  a_broadcast2(Overlord, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
	   a_broadcast3(Overlord, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
	   a_broadcast4(Overlord, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
        else
         local player = Player:new(data.player);
          a_whisper_error(Message, "Sorry this Arena is full, try joining when someone leaves!", player);
          player:teleport(minearenaexit);
  end
end

function button_out_arena(data)
        local player = Player:new(data.player);
          player:teleport(minearenaexit);
          arenaPlayers[player.name] = nil;
          playerCount = playerCount - 1;
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Mine Arena&f!");
end

registerHook("REGION_ENTER", "tp_to_arena", "mobarena-mine_arena_e");
registerHook("INTERACT", "button_out_arena", 143, "mobarena", -3002.0, 105.0, -2977.0);

--------------------------
--Respawning/Game Over----
--------------------------

local minerespawn = Location:new(myWorld, -2999.0, 105.0, 2975);
local respawngear = Location:new(myWorld, 48, 67, 1);

--When Player dies repspawn here.
function respawn2(data)
       if mRoundRunning then
         for playerName, value in pairs(arenaPlayers) do
             local player = Player:new(data.player);
             respawngear:cloneChestToPlayer(player.name);
             player:setHealth(20);
             player:teleport(minerespawn);

      end
   end
end

registerHook("PLAYER_DEATH", "respawn2", "mobarena");


-----------------------
---ROUND 1 (30 Mobs)---
-----------------------


local world = World:new('mobarena');
local mS1 = Location:new(myWorld, -2980.0, 106.0, 2980.0);
local mS2 = Location:new(myWorld, -2980.0, 106.0, 2991.0);
local mS3 = Location:new(myWorld, -2988.0, 106.0, 3004.0);
local mS4 = Location:new(myWorld, -2979.0, 106.0, 3015.0);
local mS5 = Location:new(myWorld, -2999.0, 106.0, 3018.0);
local mS6 = Location:new(myWorld, -2996.0, 106.0, 2982.0);
local mS7 = Location:new(myWorld, -2987.0, 106.0, 2998.0);
local mS8 = Location:new(myWorld, -2987.0, 106.0, 2983.0);
local mS9 = Location:new(myWorld, -3010.0, 106.0, 3001.0);
local mS10 = Location:new(myWorld, -3008.0, 106.0, 3007.0);
local mS11 = Location:new(myWorld, -2994.0, 106.0, 2988.0);
local mS12 = Location:new(myWorld, -2981.0, 106.0, 3009.0);
local mS13 = Location:new(myWorld, -3015.0, 106.0, 2995.0);
local mS14 = Location:new(myWorld, -3015.0, 106.0, 3005.0);
local mS15 = Location:new(myWorld, -3010.0, 106.0, 2983.0);
local mS16 = Location:new(myWorld, -3021.0, 106.0, 2981.0);
local mS17 = Location:new(myWorld, -3002.0, 106.0, 3011.0);
local mS18 = Location:new(myWorld, -3009.0, 106.0, 3021.0);
local mS19 = Location:new(myWorld, -3015.0, 106.0, 3023.0);
local mS20 = Location:new(myWorld, -3022.0, 106.0, 3017.0);
local mS21 = Location:new(myWorld, -2998.0, 106.0, 3025.0);
local mS22 = Location:new(myWorld, -2987.0, 113.0, 3001.0);
local mS23 = Location:new(myWorld, -2980.0, 113.0, 3000.0);
local mS24 = Location:new(myWorld, -3013.0, 113.0, 3001.0);
local mS25 = Location:new(myWorld, -3023.0, 113.0, 3001.0);
local mS26 = Location:new(myWorld, -3028.0, 106.0, 3019.0);
local mS27 = Location:new(myWorld, -3037.0, 106.0, 3019.0);
local mS28 = Location:new(myWorld, -2965.0, 106.0, 3018.0);
local mS29 = Location:new(myWorld, -2973.0, 106.0, 3018.0);

function start_r1(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if not mR1Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR1:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS2, "SKELETON");
	spawnMob(mS3, "SKELETON");
	spawnMob(mS4, "ZOMBIE");
	spawnMob(mS5, "ZOMBIE");
	spawnMob(mS6, "SKELETON");
	spawnMob(mS7, "SKELETON");
	spawnMob(mS7, "ZOMBIE");
	spawnMob(mS9, "SPIDER");
	spawnMob(mS10, "ZOMBIE");
	spawnMob(mS11, "CAVESPIDER");
	spawnMob(mS12, "ZOMBIE");
	spawnMob(mS13, "ZOMBIE");
	spawnMob(mS14, "SKELETON");
	spawnMob(mS15, "SKELETON");
	spawnMob(mS16, "SPIDER");
	spawnMob(mS17, "ZOMBIE");
	spawnMob(mS18, "SKELETON");
	spawnMob(mS19, "SKELETON");
	spawnMob(mS20, "ZOMBIE");
	spawnMob(mS21, "CAVESPIDER");
	spawnMob(mS22, "ZOMBIE");
	spawnMob(mS23, "ZOMBIE");
	spawnMob(mS24, "SKELETON");
	spawnMob(mS25, "SKELETON");
	spawnMob(mS26, "ZOMBIE");
	spawnMob(mS27, "ZOMBIE");
	spawnMob(mS28, "SKELETON");
	spawnMob(mS29, "SKELETON");

      else
         a_whisper_error(Message, "Round 1 Already Running!", player);

         end
      end
   end
end

function end_r1()
	if check_alive_stats() then
           mR1:cancel()
           mRoundRunning = false;
           mR1Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("INTERACT", "start_r1", 143, "mobarena", -2997, 108.0, 3003.0);   

-----------------------
---ROUND 2 (35 Mobs)---
-----------------------

--Added creeper and witch

local mS1 = Location:new(myWorld, -2980.0, 106.0, 2980.0);
local mS2 = Location:new(myWorld, -2980.0, 106.0, 2991.0);
local mS3 = Location:new(myWorld, -2988.0, 106.0, 3004.0);
local mS4 = Location:new(myWorld, -2979.0, 106.0, 3015.0);
local mS5 = Location:new(myWorld, -2999.0, 106.0, 3018.0);
local mS6 = Location:new(myWorld, -2996.0, 106.0, 2982.0);
local mS7 = Location:new(myWorld, -2987.0, 106.0, 2998.0);
local mS8 = Location:new(myWorld, -2987.0, 106.0, 2983.0);
local mS9 = Location:new(myWorld, -3010.0, 106.0, 3001.0);
local mS10 = Location:new(myWorld, -3008.0, 106.0, 3007.0);
local mS11 = Location:new(myWorld, -2994.0, 106.0, 2988.0);
local mS12 = Location:new(myWorld, -2981.0, 106.0, 3009.0);
local mS13 = Location:new(myWorld, -3015.0, 106.0, 2995.0);
local mS14 = Location:new(myWorld, -3015.0, 106.0, 3005.0);
local mS15 = Location:new(myWorld, -3010.0, 106.0, 2983.0);
local mS16 = Location:new(myWorld, -3021.0, 106.0, 2981.0);
local mS17 = Location:new(myWorld, -3002.0, 106.0, 3011.0);
local mS18 = Location:new(myWorld, -3009.0, 106.0, 3021.0);
local mS19 = Location:new(myWorld, -3015.0, 106.0, 3023.0);
local mS20 = Location:new(myWorld, -3022.0, 106.0, 3017.0);
local mS21 = Location:new(myWorld, -2998.0, 106.0, 3025.0);
local mS22 = Location:new(myWorld, -2987.0, 113.0, 3001.0);
local mS23 = Location:new(myWorld, -2980.0, 113.0, 3000.0);
local mS24 = Location:new(myWorld, -3013.0, 113.0, 3001.0);
local mS25 = Location:new(myWorld, -3023.0, 113.0, 3001.0);
local mS26 = Location:new(myWorld, -3028.0, 106.0, 3019.0);
local mS27 = Location:new(myWorld, -3037.0, 106.0, 3019.0);
local mS28 = Location:new(myWorld, -2965.0, 106.0, 3018.0);
local mS29 = Location:new(myWorld, -2973.0, 106.0, 3018.0);
local mS30 = Location:new(myWorld, -2969.0, 106.0, 3018.0);
local mS31 = Location:new(myWorld, -2973.0, 106.0, 2984.0);
local mS32 = Location:new(myWorld, -2964.0, 106.0, 2985.0);
local mS33 = Location:new(myWorld, -2964.0, 106.0, 2996.0);
local mS34 = Location:new(myWorld, -2964.0, 106.0, 3012.0);

local world = World:new('mobarena');

function start_r2(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if mR1Done then
      if not mR2Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR2:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 2 has started, kill all mobs to move to Round 3.", player);
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS2, "WITCH");
	spawnMob(mS3, "SKELETON");
	spawnMob(mS4, "ZOMBIE");
	spawnMob(mS5, "CAVESPIDER");
	spawnMob(mS6, "SKELETON");
	spawnMob(mS7, "SKELETON");
	spawnMob(mS7, "ZOMBIE");
	spawnMob(mS9, "SPIDER");
	spawnMob(mS10, "ZOMBIE");
	spawnMob(mS11, "CAVESPIDER");
	spawnMob(mS12, "ZOMBIE");
	spawnMob(mS13, "ZOMBIE");
	spawnMob(mS14, "SKELETON");
	spawnMob(mS15, "SKELETON");
	spawnMob(mS16, "SPIDER");
	spawnMob(mS17, "ZOMBIE");
	spawnMob(mS18, "SKELETON");
	spawnMob(mS19, "SKELETON");
	spawnMob(mS20, "ZOMBIE");
	spawnMob(mS21, "CAVESPIDER");
	spawnMob(mS22, "CAVESPIDER");
	spawnMob(mS23, "ZOMBIE");
	spawnMob(mS24, "SKELETON");
	spawnMob(mS25, "SKELETON");
	spawnMob(mS26, "CREEPER");
	spawnMob(mS27, "ZOMBIE");
	spawnMob(mS28, "SKELETON");
	spawnMob(mS29, "WITCH");
	spawnMob(mS30, "SKELETON");
	spawnMob(mS31, "CREEPER");
	spawnMob(mS32, "SKELETON");
	spawnMob(mS33, "SKELETON");
	spawnMob(mS34, "WITCH");

      else
         a_whisper_error(Message, "Round 2 Already Running!", player);

         end
      end
   end
end

function end_r2()
	if check_alive_stats() then
           mR2:cancel()
           mRoundRunning = false;
           mR2Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("INTERACT", "start_r2", 143, "mobarena", -2998, 108.0, 3003.0);  
-----------------------
---ROUND 3 (40 Mobs)---
-----------------------

--Added slime

local mS1 = Location:new(myWorld, -2980.0, 106.0, 2980.0);
local mS2 = Location:new(myWorld, -2980.0, 106.0, 2991.0);
local mS3 = Location:new(myWorld, -2988.0, 106.0, 3004.0);
local mS4 = Location:new(myWorld, -2979.0, 106.0, 3015.0);
local mS5 = Location:new(myWorld, -2999.0, 106.0, 3018.0);
local mS6 = Location:new(myWorld, -2996.0, 106.0, 2982.0);
local mS7 = Location:new(myWorld, -2987.0, 106.0, 2998.0);
local mS8 = Location:new(myWorld, -2987.0, 106.0, 2983.0);
local mS9 = Location:new(myWorld, -3010.0, 106.0, 3001.0);
local mS10 = Location:new(myWorld, -3008.0, 106.0, 3007.0);
local mS11 = Location:new(myWorld, -2994.0, 106.0, 2988.0);
local mS12 = Location:new(myWorld, -2981.0, 106.0, 3009.0);
local mS13 = Location:new(myWorld, -3015.0, 106.0, 2995.0);
local mS14 = Location:new(myWorld, -3015.0, 106.0, 3005.0);
local mS15 = Location:new(myWorld, -3010.0, 106.0, 2983.0);
local mS16 = Location:new(myWorld, -3021.0, 106.0, 2981.0);
local mS17 = Location:new(myWorld, -3002.0, 106.0, 3011.0);
local mS18 = Location:new(myWorld, -3009.0, 106.0, 3021.0);
local mS19 = Location:new(myWorld, -3015.0, 106.0, 3023.0);
local mS20 = Location:new(myWorld, -3022.0, 106.0, 3017.0);
local mS21 = Location:new(myWorld, -2998.0, 106.0, 3025.0);
local mS22 = Location:new(myWorld, -2987.0, 113.0, 3001.0);
local mS23 = Location:new(myWorld, -2980.0, 113.0, 3000.0);
local mS24 = Location:new(myWorld, -3013.0, 113.0, 3001.0);
local mS25 = Location:new(myWorld, -3023.0, 113.0, 3001.0);
local mS26 = Location:new(myWorld, -3028.0, 106.0, 3019.0);
local mS27 = Location:new(myWorld, -3037.0, 106.0, 3019.0);
local mS28 = Location:new(myWorld, -2965.0, 106.0, 3018.0);
local mS29 = Location:new(myWorld, -2973.0, 106.0, 3018.0);
local mS30 = Location:new(myWorld, -2969.0, 106.0, 3018.0);
local mS31 = Location:new(myWorld, -2973.0, 106.0, 2984.0);
local mS32 = Location:new(myWorld, -2964.0, 106.0, 2985.0);
local mS33 = Location:new(myWorld, -2964.0, 106.0, 2996.0);
local mS34 = Location:new(myWorld, -2964.0, 106.0, 3012.0);
local mS35 = Location:new(myWorld, -3032.0, 106.0, 3019.0);
local mS36 = Location:new(myWorld, -3039.0, 106.0, 3013.0);
local mS37 = Location:new(myWorld, -3039.0, 106.0, 3009.0);
local mS38 = Location:new(myWorld, -3039.0, 106.0, 2996.0);
local mS39 = Location:new(myWorld, -3037.0, 106.0, 2989.0);

local world = World:new('mobarena');

function start_r3(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if mR1Done then
      if mR2Done then
      if not mR3Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR3:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 3 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 3 has started, kill all mobs to move to Round 4.", player);
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS1, "CAVESPIDER");
	spawnMob(mS2, "WITCH");
	spawnMob(mS3, "SKELETON");
	spawnMob(mS4, "ZOMBIE");
	spawnMob(mS5, "CAVESPIDER");
	spawnMob(mS6, "SKELETON");
	spawnMob(mS7, "SKELETON");
	spawnMob(mS7, "ZOMBIE");
	spawnMob(mS9, "SPIDER");
	spawnMob(mS10, "ZOMBIE");
	spawnMob(mS11, "CAVESPIDER");
	spawnMob(mS12, "ZOMBIE");
	spawnMob(mS13, "SLIME");
	spawnMob(mS14, "SKELETON");
	spawnMob(mS15, "SKELETON");
	spawnMob(mS16, "SPIDER");
	spawnMob(mS17, "ZOMBIE");
	spawnMob(mS18, "CAVESPIDER");
	spawnMob(mS19, "SKELETON");
	spawnMob(mS20, "ZOMBIE");
	spawnMob(mS21, "CAVESPIDER");
	spawnMob(mS22, "CAVESPIDER");
	spawnMob(mS23, "ZOMBIE");
	spawnMob(mS24, "SKELETON");
	spawnMob(mS25, "SKELETON");
	spawnMob(mS26, "CREEPER");
	spawnMob(mS27, "ZOMBIE");
	spawnMob(mS28, "SKELETON");
	spawnMob(mS29, "WITCH");
	spawnMob(mS30, "SKELETON");
	spawnMob(mS31, "CREEPER");
	spawnMob(mS32, "SKELETON");
	spawnMob(mS33, "SLIME");
	spawnMob(mS34, "WITCH");
	spawnMob(mS35, "SKELETON");
	spawnMob(mS36, "CREEPER");
	spawnMob(mS37, "SKELETON");
	spawnMob(mS38, "ZOMBIE");
	spawnMob(mS39, "WITCH");

      else
         a_whisper_error(Message, "Round 3 Already Running!", player);

         end
      end
   end
end

function end_r3()
	if check_alive_stats() then
           mR3:cancel()
           mRoundRunning = false;
           mR3Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("INTERACT", "start_r3", 143, "mobarena", -2999, 108.0, 3003.0);  

-----------------------
---ROUND 4 (45 Mobs)---
-----------------------

--Added iron golem

local mS1 = Location:new(myWorld, -2980.0, 106.0, 2980.0);
local mS2 = Location:new(myWorld, -2980.0, 106.0, 2991.0);
local mS3 = Location:new(myWorld, -2988.0, 106.0, 3004.0);
local mS4 = Location:new(myWorld, -2979.0, 106.0, 3015.0);
local mS5 = Location:new(myWorld, -2999.0, 106.0, 3018.0);
local mS6 = Location:new(myWorld, -2996.0, 106.0, 2982.0);
local mS7 = Location:new(myWorld, -2987.0, 106.0, 2998.0);
local mS8 = Location:new(myWorld, -2987.0, 106.0, 2983.0);
local mS9 = Location:new(myWorld, -3010.0, 106.0, 3001.0);
local mS10 = Location:new(myWorld, -3008.0, 106.0, 3007.0);
local mS11 = Location:new(myWorld, -2994.0, 106.0, 2988.0);
local mS12 = Location:new(myWorld, -2981.0, 106.0, 3009.0);
local mS13 = Location:new(myWorld, -3015.0, 106.0, 2995.0);
local mS14 = Location:new(myWorld, -3015.0, 106.0, 3005.0);
local mS15 = Location:new(myWorld, -3010.0, 106.0, 2983.0);
local mS16 = Location:new(myWorld, -3021.0, 106.0, 2981.0);
local mS17 = Location:new(myWorld, -3002.0, 106.0, 3011.0);
local mS18 = Location:new(myWorld, -3009.0, 106.0, 3021.0);
local mS19 = Location:new(myWorld, -3015.0, 106.0, 3023.0);
local mS20 = Location:new(myWorld, -3022.0, 106.0, 3017.0);
local mS21 = Location:new(myWorld, -2998.0, 106.0, 3025.0);
local mS22 = Location:new(myWorld, -2987.0, 113.0, 3001.0);
local mS23 = Location:new(myWorld, -2980.0, 113.0, 3000.0);
local mS24 = Location:new(myWorld, -3013.0, 113.0, 3001.0);
local mS25 = Location:new(myWorld, -3023.0, 113.0, 3001.0);
local mS26 = Location:new(myWorld, -3028.0, 106.0, 3019.0);
local mS27 = Location:new(myWorld, -3037.0, 106.0, 3019.0);
local mS28 = Location:new(myWorld, -2965.0, 106.0, 3018.0);
local mS29 = Location:new(myWorld, -2973.0, 106.0, 3018.0);
local mS30 = Location:new(myWorld, -2969.0, 106.0, 3018.0);
local mS31 = Location:new(myWorld, -2973.0, 106.0, 2984.0);
local mS32 = Location:new(myWorld, -2964.0, 106.0, 2985.0);
local mS33 = Location:new(myWorld, -2964.0, 106.0, 2996.0);
local mS34 = Location:new(myWorld, -2964.0, 106.0, 3012.0);
local mS35 = Location:new(myWorld, -3032.0, 106.0, 3019.0);
local mS36 = Location:new(myWorld, -3039.0, 106.0, 3013.0);
local mS37 = Location:new(myWorld, -3039.0, 106.0, 3009.0);
local mS38 = Location:new(myWorld, -3039.0, 106.0, 2996.0);
local mS39 = Location:new(myWorld, -3037.0, 106.0, 2989.0);
local mS40 = Location:new(myWorld, -3030.0, 106.0, 2985.0);
local mS41 = Location:new(myWorld, -3026.0, 106.0, 2987.0);
local mS42 = Location:new(myWorld, -3030.0, 113.0, 3000.0);
local mS43 = Location:new(myWorld, -2973.0, 113.0, 3001.0);
local mS44 = Location:new(myWorld, -2967.0, 113.0, 3003.0);

local world = World:new('mobarena');

function start_r4(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if mR1Done then
      if mR2Done then
      if mR3Done then						
      if not mR4Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR4:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 4 has started, kill all mobs to move to Round 5.", player);
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS1, "CAVESPIDER");
	spawnMob(mS2, "WITCH");
	spawnMob(mS3, "SKELETON");
	spawnMob(mS4, "IRONGOLEM");
	spawnMob(mS5, "CAVESPIDER");
	spawnMob(mS6, "SKELETON");
	spawnMob(mS7, "SKELETON");
	spawnMob(mS7, "ZOMBIE");
	spawnMob(mS9, "CAVESPIDER");
	spawnMob(mS10, "IRONGOLEM");
	spawnMob(mS11, "CAVESPIDER");
	spawnMob(mS12, "SKELETON");
	spawnMob(mS13, "SLIME");
	spawnMob(mS14, "SKELETON");
	spawnMob(mS15, "CAVESPIDER");
	spawnMob(mS16, "SPIDER");
	spawnMob(mS17, "ZOMBIE");
	spawnMob(mS18, "CAVESPIDER");
	spawnMob(mS19, "SKELETON");
	spawnMob(mS20, "IRONGOLEM");
	spawnMob(mS21, "CAVESPIDER");
	spawnMob(mS22, "CAVESPIDER");
	spawnMob(mS23, "SKELETON");
	spawnMob(mS24, "SKELETON");
	spawnMob(mS25, "CAVESPIDER");
	spawnMob(mS26, "CREEPER");
	spawnMob(mS27, "ZOMBIE");
	spawnMob(mS28, "SKELETON");
	spawnMob(mS29, "WITCH");
	spawnMob(mS30, "CAVESPIDER");
	spawnMob(mS31, "CREEPER");
	spawnMob(mS32, "SKELETON");
	spawnMob(mS33, "IRONGOLEM");
	spawnMob(mS34, "WITCH");
	spawnMob(mS35, "SKELETON");
	spawnMob(mS36, "CREEPER");
	spawnMob(mS37, "SKELETON");
	spawnMob(mS38, "WITCH");
	spawnMob(mS39, "WITCH");
	spawnMob(mS40, "SKELETON");
	spawnMob(mS41, "CREEPER");
	spawnMob(mS42, "SKELETON");
	spawnMob(mS43, "ZOMBIE");
	spawnMob(mS44, "WITCH");

      else
         a_whisper_error(Message, "Round 4 Already Running!", player);

         end
      end
   end
end

function end_r4()
	if check_alive_stats() then
           mR4:cancel()
           mRoundRunning = false;
           mR4Done = true;
for playerName, value in pairs(arenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 4 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("INTERACT", "start_r4", 143, "mobarena", -3000, 108.0, 3003.0);  

-----------------------
---ROUND 5 (50 Mobs)---
-----------------------

--Has Zombies, Skellys, Spiders, Creeper, Witches, Endermen
--Added Giants

local mS1 = Location:new(myWorld, -2980.0, 106.0, 2980.0);
local mS2 = Location:new(myWorld, -2980.0, 106.0, 2991.0);
local mS3 = Location:new(myWorld, -2988.0, 106.0, 3004.0);
local mS4 = Location:new(myWorld, -2979.0, 106.0, 3015.0);
local mS5 = Location:new(myWorld, -2999.0, 106.0, 3018.0);
local mS6 = Location:new(myWorld, -2996.0, 106.0, 2982.0);
local mS7 = Location:new(myWorld, -2987.0, 106.0, 2998.0);
local mS8 = Location:new(myWorld, -2987.0, 106.0, 2983.0);
local mS9 = Location:new(myWorld, -3010.0, 106.0, 3001.0);
local mS10 = Location:new(myWorld, -3008.0, 106.0, 3007.0);
local mS11 = Location:new(myWorld, -2994.0, 106.0, 2988.0);
local mS12 = Location:new(myWorld, -2981.0, 106.0, 3009.0);
local mS13 = Location:new(myWorld, -3015.0, 106.0, 2995.0);
local mS14 = Location:new(myWorld, -3015.0, 106.0, 3005.0);
local mS15 = Location:new(myWorld, -3010.0, 106.0, 2983.0);
local mS16 = Location:new(myWorld, -3021.0, 106.0, 2981.0);
local mS17 = Location:new(myWorld, -3002.0, 106.0, 3011.0);
local mS18 = Location:new(myWorld, -3009.0, 106.0, 3021.0);
local mS19 = Location:new(myWorld, -3015.0, 106.0, 3023.0);
local mS20 = Location:new(myWorld, -3022.0, 106.0, 3017.0);
local mS21 = Location:new(myWorld, -2998.0, 106.0, 3025.0);
local mS22 = Location:new(myWorld, -2987.0, 113.0, 3001.0);
local mS23 = Location:new(myWorld, -2980.0, 113.0, 3000.0);
local mS24 = Location:new(myWorld, -3013.0, 113.0, 3001.0);
local mS25 = Location:new(myWorld, -3023.0, 113.0, 3001.0);
local mS26 = Location:new(myWorld, -3028.0, 106.0, 3019.0);
local mS27 = Location:new(myWorld, -3037.0, 106.0, 3019.0);
local mS28 = Location:new(myWorld, -2965.0, 106.0, 3018.0);
local mS29 = Location:new(myWorld, -2973.0, 106.0, 3018.0);
local mS30 = Location:new(myWorld, -2969.0, 106.0, 3018.0);
local mS31 = Location:new(myWorld, -2973.0, 106.0, 2984.0);
local mS32 = Location:new(myWorld, -2964.0, 106.0, 2985.0);
local mS33 = Location:new(myWorld, -2964.0, 106.0, 2996.0);
local mS34 = Location:new(myWorld, -2964.0, 106.0, 3012.0);
local mS35 = Location:new(myWorld, -3032.0, 106.0, 3019.0);
local mS36 = Location:new(myWorld, -3039.0, 106.0, 3013.0);
local mS37 = Location:new(myWorld, -3039.0, 106.0, 3009.0);
local mS38 = Location:new(myWorld, -3039.0, 106.0, 2996.0);
local mS39 = Location:new(myWorld, -3037.0, 106.0, 2989.0);
local mS40 = Location:new(myWorld, -3030.0, 106.0, 2985.0);
local mS41 = Location:new(myWorld, -3026.0, 106.0, 2987.0);
local mS42 = Location:new(myWorld, -3030.0, 113.0, 3000.0);
local mS43 = Location:new(myWorld, -2973.0, 113.0, 3001.0);
local mS44 = Location:new(myWorld, -2967.0, 113.0, 3003.0);
local mS45 = Location:new(myWorld, -3004.0, 106.0, 2991.0);


function start_r5(data)
        for playerName, value in pairs(arenaPlayers) do
         local player = Player:new(data.player);
      if mR1Done then
      if mR2Done then
      if mR3Done then	
      if mR4Done then	
      if not mR5Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR5:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 5 has started, kill all mobs to beat the arena!", player);
	spawnMob(mS1, "ZOMBIE");
	spawnMob(mS1, "CAVESPIDER");
	spawnMob(mS2, "WITCH");
	spawnMob(mS3, "SKELETON");
	spawnMob(mS4, "IRONGOLEM");
	spawnMob(mS5, "CAVESPIDER");
	spawnMob(mS6, "SKELETON");
	spawnMob(mS7, "SKELETON");
	spawnMob(mS7, "ZOMBIE");
	spawnMob(mS9, "CAVESPIDER");
	spawnMob(mS10, "IRONGOLEM");
	spawnMob(mS11, "CAVESPIDER");
	spawnMob(mS12, "SKELETON");
	spawnMob(mS13, "SLIME");
	spawnMob(mS14, "SKELETON");
	spawnMob(mS15, "CAVESPIDER");
	spawnMob(mS16, "SPIDER");
	spawnMob(mS17, "ZOMBIE");
	spawnMob(mS18, "CAVESPIDER");
	spawnMob(mS19, "SKELETON");
	spawnMob(mS20, "ZOMBIE");
	spawnMob(mS21, "CAVESPIDER");
	spawnMob(mS22, "CAVESPIDER");
	spawnMob(mS23, "SKELETON");
	spawnMob(mS24, "SKELETON");
	spawnMob(mS25, "CAVESPIDER");
	spawnMob(mS26, "CREEPER");
	spawnMob(mS27, "ZOMBIE");
	spawnMob(mS28, "SKELETON");
	spawnMob(mS29, "WITCH");
	spawnMob(mS30, "CAVESPIDER");
	spawnMob(mS31, "CREEPER");
	spawnMob(mS32, "SKELETON");
	spawnMob(mS33, "ZOMBIE");
	spawnMob(mS34, "WITCH");
	spawnMob(mS35, "SKELETON");
	spawnMob(mS36, "CREEPER");
	spawnMob(mS37, "SKELETON");
	spawnMob(mS38, "WITCH");
	spawnMob(mS39, "WITCH");
	spawnMob(mS40, "SKELETON");
	spawnMob(mS41, "CREEPER");
	spawnMob(mS42, "SKELETON");
	spawnMob(mS43, "ZOMBIE");
	spawnMob(mS44, "WITCH");
	spawnMob(mS45, "WITCH");
	spawnMob(mS11, "WITCH");
	spawnMob(mS17, "WITCH");
	spawnMob(mS23, "WITCH");
	spawnMob(mS24, "WITCH");

      else
         a_whisper_error(Message, "Round 5 Already Running!", player);
 
            end
         end
      end
   end
end

function reset_rounds()
	if check_alive_stats() then
           mR5:cancel()
           mRoundRunning = false;
           mR1Done = false;
           mR2Done = false;
           mR3Done = false;
           mR4Done = false;
           a_broadcast_npc(Overlord, "The &6Mine Arena &fhas been &adefeated&f!");
         for playerName, value in pairs(arenaPlayers) do
             local player = Player:new(playerName);
             player:teleport(mineround5);
             player:sendEvent("achievement.minechampion");
            local player = Player:new(data.player);
             arenaPlayers[player.name] = nil;
             playerCount = playerCount - 1;

      end
   end
end 

registerHook("INTERACT", "start_r5", 143, "mobarena", -3001, 108.0, 3003.0);  

------------------------------------------------------
--R1 Rewards----------
------------------------------------------------------

local world = World:new('mobarena');
local mR1Chest = Location:new(world, -2997.0, 121.0, 3017.0);
local mR1ChestOpen = Location:new(world, -2997.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr1_rewards(data)
     local player = Player:new(data.player);
	if not mRoundRunning then 
	if mR1Done then
	if not mR2Done then
	if not mR3Done then
        if not mR4Done then
        if not mR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		mR1Chest:cloneChestToPlayer(player.name);
                minesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 1 Rewards: you earned 4 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr1_rewards", "mobarena-pve2_reset");

------------------------------------------------------
--R2 Rewards----------
------------------------------------------------------


local world = World:new('mobarena');
local mR2Chest = Location:new(world, -2999.0, 121.0, 3017.0);
local mR2ChestOpen = Location:new(world, -2999.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr2_rewards(data)
     local player = Player:new(data.player);
	if not mRoundRunning then 	
	if mR1Done then
	if mR2Done then
	if not mR3Done then
        if not mR4Done then
        if not mR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		mR2Chest:cloneChestToPlayer(player.name);
                minesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 2 Rewards: you earned 5 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr2_rewards", "mobarena-pve2_reset");

------------------------------------------------------
--R3 Rewards----------
------------------------------------------------------


local world = World:new('mobarena');
local mR3Chest = Location:new(world, -3001.0, 121.0, 3017.0);
local mR3ChestOpen = Location:new(world, -3001.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr3_rewards(data)
     local player = Player:new(data.player);
	if not mRoundRunning then 	
	if mR1Done then
	if mR2Done then
	if mR3Done then
        if not mR4Done then
        if not mR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		mR3Chest:cloneChestToPlayer(player.name);
                minesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 3 Rewards: you earned 6 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr3_rewards", "mobarena-pve2_reset");

------------------------------------------------------
--R4 Rewards----------
------------------------------------------------------


local world = World:new('mobarena');
local mR4Chest = Location:new(world, -3003.0, 121.0, 3017.0);
local mR4ChestOpen = Location:new(world, -3003.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr4_rewards(data)
     local player = Player:new(data.player);
	if not mRoundRunning then 	
	if mR1Done then
	if mR2Done then
	if mR3Done then
        if mR4Done then
        if not mR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		mR4Chest:cloneChestToPlayer(player.name);
                minesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 4 Rewards: you earned 7 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr4_rewards", "mobarena-pve2_reset");

------------------------------------------------------
--R5 Rewards----------
------------------------------------------------------

local world = World:new('mobarena');
local mR5Chest = Location:new(world, -3005.0, 121.0, 3017.0);
local mR5ChestOpen = Location:new(world, -3005.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;
local mChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);

function mr5_rewards(data)
     local player = Player:new(data.player);
	if not mRoundRunning then 	
	if mR1Done then
	if mR2Done then
	if mR3Done then
        if mR4Done then
        if mR5Done then
		ChestPlayers[player.name] = true;
		player:closeInventory();
		mR5Chest:cloneChestToPlayer(player.name);
                minesound:playSound('HORSE_SADDLE', 1, 0);
                player:sendMessage("&dRound 5 Rewards: you earned 8 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr5_rewards", "mobarena-pve2_r5");
