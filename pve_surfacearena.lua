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

--------------------------------
--Player Control--
--------------------------------

local arenaPlayers = {};
local playerCount = 0;

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
--Signs------
---------------------
--
--	{["Location"] = Location:new(myWorld.name, 815, 100, 168), ["Name"] = "Packed Ice", ["Item"] = "packedice", ["Amount"] = 64, ["Cost"] = 4}
--};
--
--

---------------------
--Teleports------
---------------------

local surfacesound = Location:new(myWorld, -3, 65, -1);
local surfacearenaexit = Location:new(myWorld, 837, 97, 149);
local surfacearenaenter = Location:new(myWorld, 41, 67, 1);


function arena_enter_message(data)
        local player = Player:new(data.player);
         a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cHead to the center of the arena to get started!", player);
end

function arena_leave_message(data)
        local player = Player:new(data.player);
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Surface Arena&f!");
end

function tp_to_arena(data)
       if playerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(surfacearenaenter);
          arenaPlayers[player.name] = true;
          playerCount = playerCount + 1;
        else
         local player = Player:new(data.player);
          a_whisper_npc(Message, "&cSorry this Arena is full, try joining when someone leaves!", player);
          player:teleport(surfacearenaexit);
   end
end

function button_out_arena(data)
        local player = Player:new(data.player);
          player:teleport(surfacearenaexit);
          arenaPlayers[player.name] = nil;
          playerCount = playerCount - 1;
end



registerHook("REGION_ENTER", "arena_enter_message", "mobarena-arena_surface");
registerHook("REGION_LEAVE", "arena_leave_message", "mobarena-arena_surface");
registerHook("REGION_ENTER", "tp_to_arena", "mobarena-portal_surfacearena");
registerHook("INTERACT", "button_out_arena", 77, "mobarena", 30, 65, -2);


--------------------------------
--Check Mob Life and Round end--
--------------------------------

local entityList = {};

local checkTimer1 = Timer:new("round1_end", 1);
local checkTimer2 = Timer:new("round2_end", 1);
local checkTimer3 = Timer:new("round3_end", 1);
local checkTimer4 = Timer:new("round4_end", 1);
local checkTimer5 = Timer:new("round5_end", 1);

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

function round1_end()
	if check_alive_stats() then
         sRoundRunning = false;
         sR1Done = true;
         checkTimer1:cancel()
         a_broadcast_npc(Overlord, "&aRound 1 &fin the &6Surface Arena &fhad ended!");
	end
end     

function round2_end()
	if check_alive_stats() then
         sRoundRunning = false;
         sR2Done = true;
         checkTimer2:cancel()
         a_broadcast_npc(Overlord, "&aRound 2 &fin the &6Surface Arena &fhad ended!");
	end
end

function round3_end()
	if check_alive_stats() then
         sRoundRunning = false;
         sR3Done = true;
         checkTimer3:cancel()
         a_broadcast_npc(Overlord, "&aRound 3 &fin the &6Surface Arena &fhad ended!");
	end
end
function round4_end()
	if check_alive_stats() then
         sRoundRunning = false;
         sR4Done = true;
         checkTimer4:cancel()
         a_broadcast_npc(Overlord, "&aRound 4 &fin the &6Surface Arena &fhad ended!");
	end
end
function round5_end()
	if check_alive_stats() then
         sRoundRunning = false;
         sR1Done = false;
         sR2Done = false;
         sR3Done = false;
         sR4Done = false;
         checkTimer5:cancel()
         a_broadcast_npc(Overlord, "&aRound 5 &fin the &6Surface Arena &fhad ended!");
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

--------------------------
--Respawning/Game Over----
--------------------------

local surfacerespawn = Location:new(myWorld, 41, 67, 1);
local respawngear = Location:new(myWorld, 48, 67, 1);

--When Player dies repsawn here.
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


----------------
--Mob Spawning--
----------------

--Round 1 (20 Mobs)--

local sR1spawn1 = Location:new(myWorld, 4.0, 65.0, 17.0);
local sR1spawn2 = Location:new(myWorld, -11.0, 65.0, 16.0);
local sR1spawn3 = Location:new(myWorld, -18.0, 65.0,-5.0);
local sR1spawn4 = Location:new(myWorld, 6.0, 65.0, -14.0);
local sR1spawn5 = Location:new(myWorld, 15.0, 65.0, 2.0);

function s_round1_spawn1(data)
      if not sR1Done then
	spawnMob(sR1spawn1, "ZOMBIE");
	spawnMob(sR1spawn1, "ZOMBIE");
	spawnMob(sR1spawn1, "SKELETON");
	spawnMob(sR1spawn1, "SKELETON");
    end
end

function s_round1_spawn2(data)
      if not sR1Done then
	spawnMob(sR1spawn2, "SKELETON");
	spawnMob(sR1spawn2, "SKELETON");
	spawnMob(sR1spawn2, "ZOMBIE");
	spawnMob(sR1spawn2, "ZOMBIE");
    end
end

function s_round1_spawn3(data)
      if not sR1Done then
	spawnMob(sR1spawn3, "ZOMBIE");
	spawnMob(sR1spawn3, "ZOMBIE");
	spawnMob(sR1spawn3, "SKELETON");
	spawnMob(sR1spawn3, "SKELETON");
     end
end

function s_round1_spawn4(data)
      if not sR1Done then
	spawnMob(sR1spawn4, "ZOMBIE");
	spawnMob(sR1spawn4, "ZOMBIE");
	spawnMob(sR1spawn4, "SKELETON");
	spawnMob(sR1spawn4, "SKELETON");
    end
end

function s_round1_spawn5(data)
	if not sR1Done then
		spawnMob(sR1spawn5, "ZOMBIE");
		spawnMob(sR1spawn5, "ZOMBIE");
		spawnMob(sR1spawn5, "SKELETON");
		spawnMob(sR1spawn5, "SKELETON");
	end
end

registerHook("INTERACT", "s_round1_spawn1", 69, "mobarena", -7.0, 66.0, 1.0);
registerHook("INTERACT", "s_round1_spawn2", 69, "mobarena", -7.0, 66.0, 1.0);
registerHook("INTERACT", "s_round1_spawn3", 69, "mobarena", -7.0, 66.0, 1.0);
registerHook("INTERACT", "s_round1_spawn4", 69, "mobarena", -7.0, 66.0, 1.0);
registerHook("INTERACT", "s_round1_spawn5", 69, "mobarena", -7.0, 66.0, 1.0);

--Round 2 (25 Mobs)--

local sR2spawn1 = Location:new(myWorld, 4.0, 65.0, 17.0);
local sR2spawn2 = Location:new(myWorld, -11.0, 65.0, 16.0);
local sR2spawn3 = Location:new(myWorld, -18.0, 65.0,-5.0);
local sR2spawn4 = Location:new(myWorld, 6.0, 65.0, -14.0);
local sR2spawn5 = Location:new(myWorld, 15.0, 65.0, 2.0);

function s_round2_spawn1(data)
        if sR1Done then
        if not sR2Done then
         spawnMob(sR2spawn1, "ZOMBIE");
         spawnMob(sR2spawn1,"ZOMBIE");
         spawnMob(sR2spawn1,"SKELETON");
         spawnMob(sR2spawn1,"SPIDER");
         spawnMob(sR2spawn1,"SKELETON");
end
end
end

function s_round2_spawn2(data)
        if sR1Done then
        if not sR2Done then
         spawnMob(sR2spawn2,"SKELETON");
         spawnMob(sR2spawn2,"SKELETON");
         spawnMob(sR2spawn2,"ZOMBIE");
         spawnMob(sR2spawn2,"SPIDER");
         spawnMob(sR2spawn2,"SPIDER");
end
end
end

function s_round2_spawn3(data)
        if sR1Done then
        if not sR2Done then
         spawnMob(sR2spawn3,"ZOMBIE");
         spawnMob(sR2spawn3,"SPIDER");
         spawnMob(sR2spawn3,"SKELETON");
         spawnMob(sR2spawn3,"SPIDER");
         spawnMob(sR2spawn3,"SPIDER");
end
end
end

function s_round2_spawn4(data)
        if sR1Done then
        if not sR2Done then
         spawnMob(sR2spawn4,"ZOMBIE");
         spawnMob(sR2spawn4,"SPIDER");
         spawnMob(sR2spawn4,"SKELETON");
         spawnMob(sR2spawn4,"SKELETON");
         spawnMob(sR2spawn4,"SPIDER");
end
end
end

function s_round2_spawn5(data)
        if sR1Done then
        if not sR2Done then
         spawnMob(sR2spawn5,"SKELETON");
         spawnMob(sR2spawn5,"SKELETON");
         spawnMob(sR2spawn5,"SKELETON");
         spawnMob(sR2spawn5,"ZOMBIE");
         spawnMob(sR2spawn5,"ZOMBIE");
end
end
end

registerHook("INTERACT", "s_round2_spawn1", 69, "mobarena", -7.0, 66.0, 0.0);
registerHook("INTERACT", "s_round2_spawn2", 69, "mobarena", -7.0, 66.0, 0.0);
registerHook("INTERACT", "s_round2_spawn3", 69, "mobarena", -7.0, 66.0, 0.0);
registerHook("INTERACT", "s_round2_spawn4", 69, "mobarena", -7.0, 66.0, 0.0);
registerHook("INTERACT", "s_round2_spawn5", 69, "mobarena", -7.0, 66.0, 0.0);

--Round 3 (30 Mobs)--

local sR3spawn1 = Location:new(myWorld, 4.0, 65.0, 17.0);
local sR3spawn2 = Location:new(myWorld, -11.0, 65.0, 16.0);
local sR3spawn3 = Location:new(myWorld, -18.0, 65.0,-5.0);
local sR3spawn4 = Location:new(myWorld, 6.0, 65.0, -14.0);
local sR3spawn5 = Location:new(myWorld, 15.0, 65.0, 2.0);


function s_round3_spawn1(data)
        if sR2Done then
        if not sR3Done then
         spawnMob(sR3spawn1,"ZOMBIE");
         spawnMob(sR3spawn1,"ZOMBIE");
         spawnMob(sR3spawn1,"CREEPER");
         spawnMob(sR3spawn1,"SPIDER");
         spawnMob(sR3spawn1,"SKELETON");
         spawnMob(sR3spawn1,"SPIDER");
end
end
end

function s_round3_spawn2(data)
        if sR2Done then
        if not sR3Done then
         spawnMob(sR3spawn2,"SKELETON");
         spawnMob(sR3spawn2,"SKELETON");
         spawnMob(sR3spawn2,"CREEPER");
         spawnMob(sR3spawn2,"SPIDER");
         spawnMob(sR3spawn2,"ZOMBIE");
         spawnMob(sR3spawn2,"ZOMBIE");
end
end
end

function s_round3_spawn3(data)
        if sR2Done then
        if not sR3Done then
         spawnMob(sR3spawn3,"ZOMBIE");
         spawnMob(sR3spawn3,"SPIDER");
         spawnMob(sR3spawn3,"CREEPER");
         spawnMob(sR3spawn3,"SPIDER");
         spawnMob(sR3spawn3,"WITCH");
         spawnMob(sR3spawn3,"CREEPER");
end
end
end

function s_round3_spawn4(data)
        if sR2Done then
        if not sR3Done then
         spawnMob(sR3spawn4,"ZOMBIE");
         spawnMob(sR3spawn4,"SPIDER");
         spawnMob(sR3spawn4,"CREEPER");
         spawnMob(sR3spawn4,"CREEPER");
         spawnMob(sR3spawn4,"SPIDER");
         spawnMob(sR3spawn4,"ZOMBIE");
end
end
end

function s_round3_spawn5(data)
        if sR2Done then
        if not sR3Done then
         spawnMob(sR3spawn5,"SKELETON");
         spawnMob(sR3spawn5,"SKELETON");
         spawnMob(sR3spawn5,"CREEPER");
         spawnMob(sR3spawn5,"CREEPER");
         spawnMob(sR3spawn5,"ZOMBIE");
         spawnMob(sR3spawn5,"SPIDER");
end
end
end

registerHook("INTERACT", "s_round3_spawn1", 69, "mobarena", -7.0, 66.0, -1.0);
registerHook("INTERACT", "s_round3_spawn2", 69, "mobarena", -7.0, 66.0, -1.0);
registerHook("INTERACT", "s_round3_spawn3", 69, "mobarena", -7.0, 66.0, -1.0);
registerHook("INTERACT", "s_round3_spawn4", 69, "mobarena", -7.0, 66.0, -1.0);
registerHook("INTERACT", "s_round3_spawn5", 69, "mobarena", -7.0, 66.0, -1.0);

--Round 4 (35 Mobs)--

local sR4spawn1 = Location:new(myWorld, 4.0, 65.0, 17.0);
local sR4spawn2 = Location:new(myWorld, -11.0, 65.0, 16.0);
local sR4spawn3 = Location:new(myWorld, -18.0, 65.0,-5.0);
local sR4spawn4 = Location:new(myWorld, 6.0, 65.0, -14.0);
local sR4spawn5 = Location:new(myWorld, 15.0, 65.0, 2.0);

function s_round4_spawn1(data)
        if sR3Done then
        if not sR4Done then
         spawnMob(sR4spawn1,"WITCH");
         spawnMob(sR4spawn1,"ZOMBIE");
         spawnMob(sR4spawn1,"CREEPER");
         spawnMob(sR4spawn1,"SPIDER");
         spawnMob(sR4spawn1,"SKELETON");
         spawnMob(sR4spawn1,"SPIDER");
         spawnMob(sR4spawn1,"SKELETON");
end
end
end

function s_round4_spawn2(data)
        if sR3Done then
        if not sR4Done then
         spawnMob(sR4spawn2,"SKELETON");
         spawnMob(sR4spawn2,"SKELETON");
         spawnMob(sR4spawn2,"CREEPER");
         spawnMob(sR4spawn2,"SPIDER");
         spawnMob(sR4spawn2,"ZOMBIE");
         spawnMob(sR4spawn2,"ZOMBIE");
         spawnMob(sR4spawn2,"SPIDER");
end
end
end

function s_round4_spawn3(data)
        if sR3Done then
        if not sR4Done then
         spawnMob(sR4spawn3,"ZOMBIE");
         spawnMob(sR4spawn3,"SPIDER");
         spawnMob(sR4spawn3,"CREEPER");
         spawnMob(sR4spawn3,"SPIDER");
         spawnMob(sR4spawn3,"SKELETON");
         spawnMob(sR4spawn3,"CREEPER");
         spawnMob(sR4spawn3,"WITCH");
end
end
end

function s_round4_spawn4(data)
        if sR3Done then
        if not sR4Done then
         spawnMob(sR4spawn4,"ZOMBIE");
         spawnMob(sR4spawn4,"SPIDER");
         spawnMob(sR4spawn4,"CREEPER");
         spawnMob(sR4spawn4,"CREEPER");
         spawnMob(sR4spawn4,"SPIDER");
         spawnMob(sR4spawn4,"ZOMBIE");
         spawnMob(sR4spawn4,"CREEPER");
end
end
end

function s_round4_spawn5(data)
        if sR3Done then
        if not sR4Done then
         spawnMob(sR4spawn5,"SKELETON");
         spawnMob(sR4spawn5,"SKELETON");
         spawnMob(sR4spawn5,"CREEPER");
         spawnMob(sR4spawn5,"CREEPER");
         spawnMob(sR4spawn5,"ZOMBIE");
         spawnMob(sR4spawn5,"SPIDER");
         spawnMob(sR4spawn5,"WITCH");
end
end
end

registerHook("INTERACT", "s_round4_spawn1", 69, "mobarena", -7.0, 66.0, -2.0);
registerHook("INTERACT", "s_round4_spawn2", 69, "mobarena", -7.0, 66.0, -2.0);
registerHook("INTERACT", "s_round4_spawn3", 69, "mobarena", -7.0, 66.0, -2.0);
registerHook("INTERACT", "s_round4_spawn4", 69, "mobarena", -7.0, 66.0, -2.0);
registerHook("INTERACT", "s_round4_spawn5", 69, "mobarena", -7.0, 66.0, -2.0);

--Round 5 (40 Mobs)--

local sR5spawn1 = Location:new(myWorld, 4.0, 65.0, 17.0);
local sR5spawn2 = Location:new(myWorld, -11.0, 65.0, 16.0);
local sR5spawn3 = Location:new(myWorld, -18.0, 65.0,-5.0);
local sR5spawn4 = Location:new(myWorld, 6.0, 65.0, -14.0);
local sR5spawn5 = Location:new(myWorld, 15.0, 65.0, 2.0);

function s_round5_spawn1(data)
        if sR4Done then
        if not sR5Done then
         spawnMob(sR5spawn1,"ZOMBIE");
         spawnMob(sR5spawn1,"ZOMBIE");
         spawnMob(sR5spawn1,"CREEPER");
         spawnMob(sR5spawn1,"SPIDER");
         spawnMob(sR5spawn1,"GIANT");
         spawnMob(sR5spawn1,"SPIDER");
         spawnMob(sR5spawn1,"SKELETON");
         spawnMob(sR5spawn1,"WITCH");
end
end
end

function s_round5_spawn2(data)
        if sR4Done then
        if not sR5Done then
         spawnMob(sR5spawn2,"SKELETON");
         spawnMob(sR5spawn2,"SKELETON");
         spawnMob(sR5spawn2,"CREEPER");
         spawnMob(sR5spawn2,"SPIDER");
         spawnMob(sR5spawn2,"ZOMBIE");
         spawnMob(sR5spawn2,"ZOMBIE");
         spawnMob(sR5spawn2,"SPIDER");
         spawnMob(sR5spawn2,"WITCH");
end
end
end

function s_round5_spawn3(data)
        if sR4Done then
        if not sR5Done then
         spawnMob(sR5spawn3,"ZOMBIE");
         spawnMob(sR5spawn3,"SPIDER");
         spawnMob(sR5spawn3,"CREEPER");
         spawnMob(sR5spawn3,"SPIDER");
         spawnMob(sR5spawn3,"SKELETON");
         spawnMob(sR5spawn3,"CREEPER");
         spawnMob(sR5spawn3,"WITCH");
         spawnMob(sR5spawn3,"CREEPER");
end
end
end

function s_round5_spawn4(data)
        if sR4Done then
        if not sR5Done then
         spawnMob(sR5spawn4,"ZOMBIE");
         spawnMob(sR5spawn4,"SPIDER");
         spawnMob(sR5spawn4,"CREEPER");
         spawnMob(sR5spawn4,"CREEPER");
         spawnMob(sR5spawn4,"SPIDER");
         spawnMob(sR5spawn4,"ZOMBIE");
         spawnMob(sR5spawn4,"CREEPER");
         spawnMob(sR5spawn4,"WITCH");
end
end
end

function s_round5_spawn5(data)
        if sR4Done then
        if not sR5Done then
         spawnMob(sR5spawn5,"SKELETON");
         spawnMob(sR5spawn5,"GIANT");
         spawnMob(sR5spawn5,"CREEPER");
         spawnMob(sR5spawn5,"CREEPER");
         spawnMob(sR5spawn5,"ZOMBIE");
         spawnMob(sR5spawn5,"SPIDER");
         spawnMob(sR5spawn5,"WITCH");
         spawnMob(sR5spawn5,"WITCH");
end
end
end

registerHook("INTERACT", "s_round5_spawn1", 69, "mobarena", -7.0, 66.0, -3.0);
registerHook("INTERACT", "s_round5_spawn2", 69, "mobarena", -7.0, 66.0, -3.0);
registerHook("INTERACT", "s_round5_spawn3", 69, "mobarena", -7.0, 66.0, -3.0);
registerHook("INTERACT", "s_round5_spawn4", 69, "mobarena", -7.0, 66.0, -3.0);
registerHook("INTERACT", "s_round5_spawn5", 69, "mobarena", -7.0, 66.0, -3.0);

---------------
--Round Start--
---------------

function s_round1_start(data)
         local player = Player:new(data.player);
      if not sR1Done then
       if not sRoundRunning then  
         sRoundRunning = true;
         checkTimer1:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 1 &fin the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cRound One has started, kill all mobs to move into round 2.", player);
      else
         a_whisper_npc(Message, "&cFinish current round before starting Round 1.", player);

      end
   end
end

function s_round2_start(data)
         local player = Player:new(data.player);
      if sR1Done then 
      if not sR2Done then
       if not sRoundRunning then 
         sRoundRunning = true;
         checkTimer2:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 2 &fin the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cRound Two has started, kill all mobs to move into round 3.", player);
      else
         a_whisper_npc(Message, "&cFinish Round 1 before starting Round 2.", player);
   end
end
end
end

function s_round3_start(data)
         local player = Player:new(data.player);
      if sR2Done then 
      if not sR3Done then
       if not sRoundRunning then 
         sRoundRunning = true;
         checkTimer3:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 3 &fin the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cRound Three has started, kill all mobs to move into round 4.", player);
      else
         a_whisper_npc(Message, "&cFinish Round 2 before starting Round 3.", player);
   end
end
end
end

function s_round4_start(data)
         local player = Player:new(data.player);
      if sR3Done then
      if not sR4Done then
       if not sRoundRunning then  
         sRoundRunning = true;
         checkTimer4:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 4 &fin the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cRound Four has started, kill all mobs to move into round 5.", player);
      else
         a_whisper_npc(Message, "&cFinish Round 3 before starting Round 4.", player);
   end
end
end
end

function s_round5_start(data)
         local player = Player:new(data.player);
      if sR4Done then
      if not sR5Done then
       if not sRoundRunning then  
         sRoundRunning = true;
         checkTimer5:startRepeating()
         surfacesound:playSound('PORTAL_TRIGGER', 1, 2);
         a_broadcast_npc(Overlord, player.name .. " has started &aRound 5 &fin the &6Surface Arena&f!");
         a_whisper_npc(Message, "&cRound Five has started, kill all mobs to finish the arena!", player);
      else
         a_whisper_npc(Message, "&cFinish Round 4 before starting Round 5.", player);
   end
end
end
end

registerHook("INTERACT", "s_round1_start", 69, "mobarena", -7.0, 66.0, 1.0);
registerHook("INTERACT", "s_round2_start", 69, "mobarena", -7.0, 66.0, 0.0);
registerHook("INTERACT", "s_round3_start", 69, "mobarena", -7.0, 66.0, -1.0);
registerHook("INTERACT", "s_round4_start", 69, "mobarena", -7.0, 66.0, -2.0);
registerHook("INTERACT", "s_round5_start", 69, "mobarena", -7.0, 66.0, -3.0);

------------------------------------------------------
--Local shop----------
------------------------------------------------------

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(myWorld, -32.0, 66.0, 2.0),
	Location:new(myWorld, -32.0, 66.0, 1.0),
	Location:new(myWorld, -32.0, 66.0, 0.0),
	Location:new(myWorld, -32.0, 67.0, 2.0),
	Location:new(myWorld, -32.0, 67.0, 1.0),
	Location:new(myWorld, -32.0, 67.0, 0.0),
	Location:new(myWorld, -32.0, 68.0, 2.0),
	Location:new(myWorld, -32.0, 68.0, 1.0),
	Location:new(myWorld, -32.0, 68.0, 0.0),
};

function s_placefence(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	s_pl_fence();
end

function s_pl_fence()
       if sRoundRunning then
	for index, key in ipairs(blocks) do
		key:setBlock(85, current);
      end
   end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(myWorld, -32.0, 66.0, 2.0),
	Location:new(myWorld, -32.0, 66.0, 1.0),
	Location:new(myWorld, -32.0, 66.0, 0.0),
	Location:new(myWorld, -32.0, 67.0, 2.0),
	Location:new(myWorld, -32.0, 67.0, 1.0),
	Location:new(myWorld, -32.0, 67.0, 0.0),
	Location:new(myWorld, -32.0, 68.0, 2.0),
	Location:new(myWorld, -32.0, 68.0, 1.0),
	Location:new(myWorld, -32.0, 68.0, 0.0),
};

function s_removefence(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	s_re_fence();
end

function s_re_fence()
       if not sRoundRunning then
	for index, key in ipairs(blocks) do
		key:setBlock(367, current);
      end
   end
end

registerHook("BLOCK_GAINS_CURRENT", "s_re_fence", "mobarena", -49.0, 114.0, 9.0);
registerHook("BLOCK_GAINS_CURRENT", "s_pl_fence", "mobarena", -49.0, 114.0, 9.0);

------------------------------------------------------
--Remove levers----------
------------------------------------------------------

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(myWorld, -7.0, 66.0, 1.0),
	Location:new(myWorld, -7.0, 66.0, 0.0),
	Location:new(myWorld, -7.0, 66.0, -1.0),
	Location:new(myWorld, -7.0, 66.0, -2.0),
	Location:new(myWorld, -7.0, 66.0, -3.0),
};

function s_removelevers(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	s_re_lever();
end

function s_re_lever()
       if sRoundRunning then
	for index, key in ipairs(blocks) do
		key:setBlock(50, current);
      end
   end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(myWorld, -7.0, 66.0, 1.0),
	Location:new(myWorld, -7.0, 66.0, 0.0),
	Location:new(myWorld, -7.0, 66.0, -1.0),
	Location:new(myWorld, -7.0, 66.0, -2.0),
	Location:new(myWorld, -7.0, 66.0, -3.0),
};

function s_placelevers(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	s_pl_lever();
end

function s_pl_lever()
       if not sRoundRunning then
	for index, key in ipairs(blocks) do
		key:setBlock(69, current);
      end
   end
end

registerHook("BLOCK_GAINS_CURRENT", "s_re_lever", "mobarena", -49.0, 114.0, 9.0);
registerHook("BLOCK_GAINS_CURRENT", "s_pl_lever", "mobarena", -49.0, 114.0, 9.0);
