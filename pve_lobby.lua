local myWorld = World:new('mobarena');

--ToDo's
--Plug-in Shops
--Secret Room Stuff
--Fix Testing Lanes


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

--Location of Orange Mob Spawn
local OrangeLocation = Location:new(myWorld, 832, 101, 132);
local OrangeLane = Entity:new(OrangeLocation);

-- The boundaries of Orange Lane.
local orangelanearea = {
	minX = 831,
	minY = 103,
	minX = 142,
	maxX = 833,
	maxY = 101,
	maxZ = 130
};

--Location of Blue Mob Spawn
local BlueLocation = Location:new(myWorld, 835, 101, 132);
local BlueLane = Entity:new(BlueLocation);

-- The boundaries of Blue Lane.
local bluelanearea = {
	minX = 834,
	minY = 103,
	minX = 142,
	maxX = 836,
	maxY = 101,
	maxZ = 130
};

--Location of Green Mob Spawn
local GreenLocation = Location:new(myWorld, 838, 101, 132);
local GreenLane = Entity:new(GreenLocation);

-- The boundaries of Green Lane.
local greenlanearea = {
	minX = 837,
	minY = 103,
	minX = 142,
	maxX = 839,
	maxY = 101,
	maxZ = 130
};

--Location of Yellow Mob Spawn
local YellowLocation = Location:new(myWorld, 841, 101, 132);
local YellowLane = Entity:new(YellowLocation);

-- The boundaries of Yellow Lane.
local yellowlanearea = {
	minX = 840,
	minY = 103,
	minX = 142,
	maxX = 842,
	maxY = 101,
	maxZ = 130
};



function orange_test_spawn(data)
         OrangeLane:spawn("CREEPER");
end

function orange_test_despawn(data)
         OrangeLane:despawn();
end

function blue_test_spawn(data)
         BlueLane:spawn("ZOMBIE");
end

function blue_test_despawn(data)
         BlueLane:despawn();
end

function green_test_spawn(data)
         GreenLane:spawn("SKELETON");
end

function green_test_despawn(data)
         GreenLane:despawn();
end

function yellow_test_spawn(data)
         YellowLane:spawn("WITCH");
end

function yellow_test_despawn(data)
         YellowLane:despawn();
end

registerHook("INTERACT", "orange_test_spawn", 77, "mobarena", 831, 101, 143);
registerHook("INTERACT", "orange_test_despawn", 77, "mobarena", 832, 101, 143);
registerHook("INTERACT", "blue_test_spawn", 77, "mobarena", 834, 101, 143);
registerHook("INTERACT", "blue_test_despawn", 77, "mobarena", 835, 101, 143);
registerHook("INTERACT", "green_test_spawn", 77, "mobarena", 837, 101, 143);
registerHook("INTERACT", "green_test_despawn", 77, "mobarena", 838, 101, 143);
registerHook("INTERACT", "yellow_test_spawn", 77, "mobarena", 840, 101, 143);
registerHook("INTERACT", "yellow_test_despawn", 77, "mobarena", 841, 101, 143);

--------------
--Teleports---
--------------

local surfacearenaenter = Location:new(myWorld, 41, 67, 1);
local lobbyeasterdoor = Location:new(myWorld, 824, 101, 143);
local lobbydoor = Location:new(myWorld, 837, 97, 149);

function to_surface_arena(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(surfacearenaenter);
end

function to_easter_door(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(lobbyeasterdoor);
end

function to_lobby_door(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(lobbydoor);
end

registerHook("REGION_ENTER", "to_surface_arena", "mobarena-portal_surfacearena");
registerHook("REGION_ENTER", "to_easter_door", "mobarena-lobby_secret_door");
registerHook("REGION_ENTER", "to_lobby_door", "mobarena-lobby_tolobby");

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
registerHook("REGION_ENTER", "lobby_easter_room", "mobarena-lobby_secret_door");
