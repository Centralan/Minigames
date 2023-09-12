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

local undergroundarenaenter = Location:new(myWorld, 41, 67, 1);
local undergroundarenaexit = Location:new(myWorld, 837, 97, 149);


function tp_to_arena(data)
       if playerCount < 4 then
        local player = Player:new(data.player);
          player:teleport(surfacearenaenter);
          arenaPlayers[player.name] = true;
          playerCount = playerCount + 1;
         a_broadcast_npc(Overlord, player.name .. " has &ajoined &fthe struggle in the &6Underground Arena&f!");
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
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Underground Arena&f!");
end

registerHook("REGION_ENTER", "tp_to_arena", "mobarena-portal_underground_multi");
registerHook("INTERACT", "button_out_arena", 77, "mobarena", 30, 65, -2);
