local myWorld = World:new('mobarena'); 
local myWorld2 = World:new('spawn2');
local myWorld3 = World:new('survival3');
local myWorld4 = World:new('creative');
local myWorld5 = World:new('mobarena_nether');
local minesound = Location:new(myWorld, -2999.0, 111.0, 3001.0);

--------
-----AI---
----------

local Overlord = 'PvE'
local Overlord2 = '&d[PvE] &fA Player has &ajoined &6Mine Arena&f.'
local Overlord3 = '&d[PvE] &fA Player has &adefeated &6Mine Arena&f.'
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

local MarenaPlayers = {};
local MplayerCount = 0;

--------------------------------
----Mob Control--
----------------------------------\

local entityList = {};

local function mspawnMob(position, mobType)
	local entity = Entity:new(position);
	entity:spawn(mobType);
	table.insert(entityList, entity);
end

local function purgeEntityListM()
	for index, value in pairs(entityList) do
		entityList[index] = nil;
	end
end

function check_alive_statsM()
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

local mR1Done = false;
local mR2Done = false;
local mR3Done = false;
local mR4Done = false;
local mRoundRunning = false;

---------------------
----Timers------
-----------------------

local mR1 = Timer:new("m_end_r1", 1);
local mR2 = Timer:new("m_end_r2", 1);
local mR3 = Timer:new("m_end_r3", 1);
local mR4 = Timer:new("m_end_r4", 1);

---------------------
----Teleports------
-----------------------


local minearenaenter = Location:new(myWorld, -2999.0, 110.0, 2975.0);
local minearenaexit = Location:new(myWorld, 837.0, 97, 149.0);
local pve2reset = Location:new(myWorld, -2999.0, 117, 2974.0);
local mineround5 = Location:new(myWorld, 836.0, 119.0, 153.0);
local world = World:new('mobarena');
local GearChest = Location:new(world, 834.0, 133.0, 164.0);
local ChestPlayers = {};
local ChestTimerRunning = false;
local ChestTimer = Timer:new("local world = World:new('mobarena');_reset_chest", 1 * 2 * 5);


function tp_to_arena2(data)
       if MplayerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(minearenaenter);
	  GearChest:cloneChestToPlayer(player.name);
	  minesound:playSound('HORSE_SADDLE', 1, 0);
	  player:sendMessage("&dYou have been granted with free gear.");
          MarenaPlayers[player.name] = true;
          MplayerCount = MplayerCount + 1;
         a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Mine Arena&f!");
         a_broadcast2(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
         a_broadcast3(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
         a_broadcast4(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
	 a_broadcast5(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Mine Arena&f!");
        else
         local player = Player:new(data.player);
          a_whisper_error(Message, "Sorry this Arena is full, try joining when someone leaves!", player);
          player:teleport(minearenaexit);
  end
end

function button_out_arena2(data)
        local player = Player:new(data.player);
          player:teleport(minearenaexit);
          MarenaPlayers[player.name] = nil;
          MplayerCount = MplayerCount - 1;
end

function command_out_arena2(data)
        local player = Player:new(data.player);
          player:teleport(minearenaexit);
          MarenaPlayers[player.name] = nil;
          MplayerCount = MplayerCount - 1;
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Mine Arena&f!");
end

function arena_reset_m(data)
	  if MplayerCount = 0 then
	  if mRoundRunning then
	    mR1Done = false;
            mR2Done = false;
            mR3Done = false;
            mR4Done = false;
	    mRoundRunning = false;
	  a_broadcast_npc(Overlord," &fAll Players have &cabandoned the &6Mine Arena&f, arena is resetting.");
end
	end
end

registerHook("REGION_ENTER", "tp_to_arena2", "mobarena-mine_arena_e");
registerHook("INTERACT", "button_out_arena2", 143, "mobarena", -3001.0, 110.0, 2975.0);
registerHook("REGION_EXIT", "command_out_arena2", "mobarena-pve_mine_main");

--------------------------
----Respawning/Game Over----
----------------------------

local minerespawn = Location:new(myWorld, -2999.0, 110.0, 2975.0);
local respawngear = Location:new(myWorld, 48, 67, 1);

function respawn2(data)
       if mRoundRunning then
         for playerName, value in pairs(MarenaPlayers) do
             local player = Player:new(data.player);
             player:setHealth(20);
             player:teleport(minerespawn);

      end
   end
end

registerHook("PLAYER_DEATH", "respawn2", "mobarena");

-----------------------
-----ROUND 1 (30 Mobs)---
-------------------------


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

function m_start_r1(data)
        for playerName, value in pairs(MarenaPlayers) do
         local player = Player:new(data.player);
      if not mR1Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR1:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 1 has started, kill all mobs to move to Round 2.", player);
	 a_whisper_good(Message, "&eLook out &630 &eMobs spawning in!", player);
	mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS2, "SKELETON");
	mspawnMob(mS3, "SKELETON");
	mspawnMob(mS4, "ZOMBIE");
	mspawnMob(mS5, "ZOMBIE");
	mspawnMob(mS6, "SKELETON");
	mspawnMob(mS7, "SKELETON");
	mspawnMob(mS7, "ZOMBIE");
	mspawnMob(mS9, "SPIDER");
	mspawnMob(mS10, "ZOMBIE");
	mspawnMob(mS11, "CAVESPIDER");
	mspawnMob(mS12, "ZOMBIE");
	mspawnMob(mS13, "ZOMBIE");
	mspawnMob(mS14, "SKELETON");
	mspawnMob(mS15, "SKELETON");
	mspawnMob(mS16, "SPIDER");
	mspawnMob(mS17, "ZOMBIE");
	mspawnMob(mS18, "SKELETON");
	mspawnMob(mS19, "SKELETON");
	mspawnMob(mS20, "ZOMBIE");
	mspawnMob(mS21, "CAVESPIDER");
	mspawnMob(mS22, "ZOMBIE");
	mspawnMob(mS23, "ZOMBIE");
	mspawnMob(mS24, "SKELETON");
	mspawnMob(mS25, "SKELETON");
	mspawnMob(mS26, "ZOMBIE");
	mspawnMob(mS27, "ZOMBIE");
	mspawnMob(mS28, "SKELETON");
	mspawnMob(mS29, "SKELETON");

      else
         a_whisper_error(Message, "Joining the fight for Round 1.", player);

         end
      end
   end
end

function m_end_r1()
	if check_alive_statsM() then
           mR1:cancel()
           mRoundRunning = false;
           mR1Done = true;
for playerName, value in pairs(MarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("REGION_ENTER", "m_start_r1", "mobarena-mine_startr");

------------------------------------------------------
----R1 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local mR1Chest = Location:new(world, -2997.0, 121.0, 3017.0);
local mR1ChestOpen = Location:new(world, -2997.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;

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
                player:sendMessage("&dRound 1 Rewards: you earned 5 Mob Bones!");
							end 
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr1_rewards", "mobarena-pve2_reset");

-----------------------
-----ROUND 2 (35 Mobs)---
-------------------------

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

function m_start_r2(data)
        for playerName, value in pairs(MarenaPlayers) do
         local player = Player:new(data.player);
      if mR1Done then
      if not mR2Done then
      if not mRoundRunning then  
         mRoundRunning = true;
         mR2:startRepeating()
         minesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 2 &fin the &6Mine Arena&f!");
         a_whisper_good(Message, "&cRound 2 has started, kill all mobs to move to Round 3.", player);
	 a_whisper_good(Message, "&eLook out &640 &eMobs spawning in!", player);
	mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS2, "WITCH");
	mspawnMob(mS3, "SKELETON");
	mspawnMob(mS4, "ZOMBIE");
	mspawnMob(mS5, "CAVESPIDER");
	mspawnMob(mS6, "SKELETON");
	mspawnMob(mS7, "SKELETON");
	mspawnMob(mS7, "ZOMBIE");
	mspawnMob(mS9, "SPIDER");
	mspawnMob(mS10, "ZOMBIE");
	mspawnMob(mS11, "CAVESPIDER");
	mspawnMob(mS12, "ZOMBIE");
	mspawnMob(mS13, "ZOMBIE");
	mspawnMob(mS14, "SKELETON");
	mspawnMob(mS15, "SKELETON");
	mspawnMob(mS16, "SPIDER");
	mspawnMob(mS17, "ZOMBIE");
	mspawnMob(mS18, "SKELETON");
	mspawnMob(mS19, "SKELETON");
	mspawnMob(mS20, "ZOMBIE");
	mspawnMob(mS21, "CAVESPIDER");
	mspawnMob(mS22, "CAVESPIDER");
	mspawnMob(mS23, "ZOMBIE");
	mspawnMob(mS24, "SKELETON");
	mspawnMob(mS25, "SKELETON");
	mspawnMob(mS26, "CREEPER");
	mspawnMob(mS27, "ZOMBIE");
	mspawnMob(mS28, "SKELETON");
	mspawnMob(mS29, "WITCH");
	mspawnMob(mS30, "SKELETON");
	mspawnMob(mS31, "CREEPER");
	mspawnMob(mS32, "SKELETON");
	mspawnMob(mS33, "SKELETON");
	mspawnMob(mS34, "WITCH");
        mspawnMob(mS30, "SKELETON");
        mspawnMob(mS1, "CREEPER");
        mspawnMob(mS22, "SKELETON");
        mspawnMob(mS33, "SKELETON");
        mspawnMob(mS4, "WITCH");

      else
         a_whisper_error(Message, "Joining the fight for Round 2.", player);

         end
      end
   end
end
end

function m_end_r2()
	if check_alive_statsM() then
           mR2:cancel()
           mRoundRunning = false;
           mR2Done = true;
for playerName, value in pairs(MarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("REGION_ENTER", "m_start_r2", "mobarena-mine_startr"); 

------------------------------------------------------
----R2 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local mR2Chest = Location:new(world, -2999.0, 121.0, 3017.0);
local mR2ChestOpen = Location:new(world, -2999.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;

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
                player:sendMessage("&dRound 2 Rewards: you earned 6 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr2_rewards", "mobarena-pve2_reset");

-----------------------
-----ROUND 3 (40 Mobs)---
-------------------------

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

function m_start_r3(data)
        for playerName, value in pairs(MarenaPlayers) do
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
	 a_whisper_good(Message, "&eLook out &650 &eMobs spawning in!", player);
	mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS1, "CAVESPIDER");
	mspawnMob(mS2, "WITCH");
	mspawnMob(mS3, "SKELETON");
	mspawnMob(mS4, "ZOMBIE");
	mspawnMob(mS5, "CAVESPIDER");
	mspawnMob(mS6, "SKELETON");
	mspawnMob(mS7, "SKELETON");
	mspawnMob(mS7, "ZOMBIE");
	mspawnMob(mS9, "SPIDER");
	mspawnMob(mS10, "ZOMBIE");
	mspawnMob(mS11, "CAVESPIDER");
	mspawnMob(mS12, "ZOMBIE");
	mspawnMob(mS13, "SLIME");
	mspawnMob(mS14, "SKELETON");
	mspawnMob(mS15, "SKELETON");
	mspawnMob(mS16, "SPIDER");
	mspawnMob(mS17, "ZOMBIE");
	mspawnMob(mS18, "CAVESPIDER");
	mspawnMob(mS19, "SKELETON");
	mspawnMob(mS20, "ZOMBIE");
	mspawnMob(mS21, "CAVESPIDER");
	mspawnMob(mS22, "CAVESPIDER");
	mspawnMob(mS23, "ZOMBIE");
	mspawnMob(mS24, "SKELETON");
	mspawnMob(mS25, "SKELETON");
	mspawnMob(mS26, "CREEPER");
	mspawnMob(mS27, "ZOMBIE");
	mspawnMob(mS28, "SKELETON");
	mspawnMob(mS29, "WITCH");
	mspawnMob(mS30, "SKELETON");
	mspawnMob(mS31, "CREEPER");
	mspawnMob(mS32, "SKELETON");
	mspawnMob(mS33, "SLIME");
	mspawnMob(mS34, "WITCH");
	mspawnMob(mS35, "SKELETON");
	mspawnMob(mS36, "CREEPER");
	mspawnMob(mS37, "SKELETON");
	mspawnMob(mS38, "ZOMBIE");
	mspawnMob(mS39, "WITCH");
        mspawnMob(mS20, "ZOMBIE");
        mspawnMob(mS11, "CAVESPIDER");
        mspawnMob(mS12, "CAVESPIDER");
        mspawnMob(mS13, "ZOMBIE");
        mspawnMob(mS4, "SKELETON");
        mspawnMob(mS17, "SKELETON");
        mspawnMob(mS13, "CREEPER");
        mspawnMob(mS27, "ZOMBIE");
        mspawnMob(mS28, "SKELETON");
        mspawnMob(mS29, "WITCH");


      else
         a_whisper_error(Message, "Joining the fight for Round 3.", player);
end
end
         end
      end
   end
end

function m_end_r3()
	if check_alive_statsM() then
           mR3:cancel()
           mRoundRunning = false;
           mR3Done = true;
for playerName, value in pairs(MarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(pve2reset);
           a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Mine Arena &fhas ended!")
	end
	end
end 


registerHook("REGION_ENTER", "m_start_r3", "mobarena-mine_startr"); 

------------------------------------------------------
----R3 Rewards----------
--------------------------------------------------------

local world = World:new('mobarena');
local mR3Chest = Location:new(world, -3001.0, 121.0, 3017.0);
local mR3ChestOpen = Location:new(world, -3001.0, 121.0, 3017.0);
local mChestPlayers = {};
local mChestTimerRunning = false;

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
                player:sendMessage("&dRound 3 Rewards: you earned 7 Mob Bones!");
								end
						end
					end
				end
			end
		end
	end
	

registerHook("REGION_ENTER", "mr3_rewards", "mobarena-pve2_reset");

-----------------------
-----ROUND 4 (45 Mobs)---
-------------------------


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

local world = World:new('mobarena');

function m_start_r4(data)
        for playerName, value in pairs(MarenaPlayers) do
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
	 a_whisper_good(Message, "&cRound 4 has started, kill all mobs to defeat the &6Mine Arena&f!.", player);
         a_whisper_good(Message, "&eLook out &655 &eMobs spawning in!", player);
        mspawnMob(mS1, "ZOMBIE");
	mspawnMob(mS1, "CAVESPIDER");
	mspawnMob(mS2, "WITCH");
	mspawnMob(mS3, "SKELETON");
	mspawnMob(mS4, "SKELETON");
	mspawnMob(mS5, "CAVESPIDER");
	mspawnMob(mS6, "SKELETON");
	mspawnMob(mS7, "SKELETON");
	mspawnMob(mS7, "ZOMBIE");
	mspawnMob(mS9, "CAVESPIDER");
	mspawnMob(mS10, "SKELETON");
	mspawnMob(mS11, "CAVESPIDER");
	mspawnMob(mS12, "SKELETON");
	mspawnMob(mS13, "SLIME");
	mspawnMob(mS14, "SKELETON");
	mspawnMob(mS15, "CAVESPIDER");
	mspawnMob(mS16, "SPIDER");
	mspawnMob(mS17, "ZOMBIE");
	mspawnMob(mS18, "CAVESPIDER");
	mspawnMob(mS19, "SKELETON");
	mspawnMob(mS20, "SKELETON");
	mspawnMob(mS21, "CAVESPIDER");
	mspawnMob(mS22, "CAVESPIDER");
	mspawnMob(mS23, "SKELETON");
	mspawnMob(mS24, "IRONGOLEM");
	mspawnMob(mS25, "CAVESPIDER");
	mspawnMob(mS26, "CREEPER");
	mspawnMob(mS27, "ZOMBIE");
	mspawnMob(mS28, "SKELETON");
	mspawnMob(mS29, "WITCH");
	mspawnMob(mS30, "CAVESPIDER");
	mspawnMob(mS2, "CREEPER");
	mspawnMob(mS4, "SKELETON");
	mspawnMob(mS6, "ZOMBIE");
	mspawnMob(mS8, "WITCH");
	mspawnMob(mS10, "SKELETON");
	mspawnMob(mS12, "CREEPER");
	mspawnMob(mS14, "SKELETON");
	mspawnMob(mS16, "WITCH");
	mspawnMob(mS18, "WITCH");
	mspawnMob(mS20, "SKELETON");
	mspawnMob(mS22, "CREEPER");
	mspawnMob(mS24, "SKELETON");
	mspawnMob(mS26, "ZOMBIE");
	mspawnMob(mS28, "WITCH");
        mspawnMob(mS19, "WITCH");
        mspawnMob(mS1, "WITCH");
        mspawnMob(mS20, "SKELETON");
        mspawnMob(mS23, "IRONGOLEM");
        mspawnMob(mS13, "SKELETON");
        mspawnMob(mS7, "ZOMBIE");
        mspawnMob(mS11, "WITCH");

      else
         a_whisper_error(Message, "Joining the fight for Round 4.", player);
						end
					end
				end
         end
      end
   end
end


function m_end_r4()
	if check_alive_statsM() then
           mR4:cancel()
           mRoundRunning = false;
           mR4Done = true;
for playerName, value in pairs(MarenaPlayers) do
local player = Player:new(playerName);
	   player:teleport(mineround5);
           a_broadcast_npc(Overlord, "&fThe &6Mine Arena &fhas been defeated!")
           a_broadcast2(Overlord3, player.name .." has &adefeated &fthe &6Mine Arena&f!");
           a_broadcast3(Overlord3, player.name .." has &adefeated &fthe &6Mine Arena&f!");
           a_broadcast4(Overlord3, player.name .." has &adefeated &fthe &6Mine Arena&f!");
	   a_broadcast5(Overlord3, player.name .." has &adefeated &fthe &6Mine Arena&f!");
           player:sendEvent("achievement.minechampion"); 
           mR1Done = false;
           mR2Done = false;
           mR3Done = false;
           mR4Done = false;
	   MarenaPlayers[player.name] = nil;
           MplayerCount = MplayerCount - 1;

	end
	end
end 


registerHook("REGION_ENTER", "m_start_r4", "mobarena-mine_startr");   

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
			player:sendMessage("&5Server:&6Nether &fArena has been reset.");
		end
	end
end
		
registerHook("CHAT_MESSAGE", "chatMonitor_nether", "mobarena_nether");
