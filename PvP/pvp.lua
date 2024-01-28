local world = World:new('pvparena');


-------------------------------
----------  Lobby  ------------
-------------------------------

function respawn_wipe(data)
       local player = Player:new(data.player);
             player:clearInventory();
end


registerHook("REGION_LEAVE", "respawn_wipe", "pvparena-pvp_wipe")
registerHook("REGION_LEAVE", "respawn_wipe", "pvparena-pvp_wipe2")

-------------------------------
----------  1v1 #1  ------------
-------------------------------

local arena1 = Location:new(world, -1258.500, 7.0, 450.500);
arena1:setYaw(-89.6);
arena1:setPitch(0.5);

local arena1Players = {};
local player1Count = 0;

function tp1(data)
    if player1Count < 2 then
       local player = Player:new(data.player);
             player:teleport(arena1);
             arena1Players[player.name] = true;
             player1Count = player1Count + 1;
             player:sendMessage("&4>> &cJoining 1v1 Combat! &4<<");
end
end
       
function tp1_e(data)
    if player1Count > 2 then
       local player = Player:new(data.player);
              player:sendMessage("&cSorry this Arena is full, try joining when someone leaves!");
end
end

function one_out_arena(data)
        local player = Player:new(data.player);
          arena1Players[player.name] = nil;
          player1Count = player1Count - 1;
          player:sendMessage("&4>> &cLeaving 1v1 Combat! &4<<");
end


registerHook("REGION_ENTER", "tp1", "pvparena-1v1_1")
registerHook("REGION_ENTER", "tp1_e", "pvparena-1v1_1")
registerHook("REGION_LEAVE", "one_out_arena", "pvparena-one")

-------------------------------
----------  1v1 #2  ------------
-------------------------------

local arena2 = Location:new(world, -1322.684, 7.0, 368.820);
arena2:setYaw(136.2);
arena2:setPitch(1.7);

local arena2Players = {};
local player2Count = 0;

function tp2(data)
    if player2Count < 2 then
       local player = Player:new(data.player);
             player:teleport(arena2);
             arena2Players[player.name] = true;
             player2Count = player2Count + 1;
             player:sendMessage("&4>> &cJoining 1v1 Combat! &4<<");
end
end

function tp2_e(data)
    if player2Count > 2 then
       local player = Player:new(data.player);
              player:sendMessage("&cSorry this Arena is full, try joining when someone leaves!");
end
end

function two_out_arena(data)
        local player = Player:new(data.player);
          arena2Players[player.name] = nil;
          player2Count = player2Count - 1;
          player:sendMessage("&4>> &cLeaving 1v1 Combat! &4<<");
end


registerHook("REGION_ENTER", "tp2", "pvparena-1v1_2")
registerHook("REGION_ENTER", "tp2_e", "pvparena-1v1_2")
registerHook("REGION_LEAVE", "two_out_arena", "pvparena-two")
