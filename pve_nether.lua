---------------
--local Worlds--
---------------

local myWorld = World:new('mobarena_nether');
local oldWorld = World:new('mobarena');
local nethersound = Location:new(myWorld, 0.0, 86.0, 0.0);

-------------
--local tps--
-------------

local nethercatch = Location:new(myWorld, 0, 62.0, 4.0);
local netherenter = Location:new(myWorld, 0, 62.0, 4.0);
local netherexit = Location:new(oldWorld, 837.0, 97, 149.0);

----------------
--local chests--
----------------

local NGearChest = Location:new(myWorld, 834.0, 133.0, 164.0);

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
         a_broadcast2(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast3(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nether Arena&f!");
         a_broadcast4(Overlord2, player.name .." has &ajoined &fthe struggle in the &6Nther Arena&f!");
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
         a_broadcast_npc(Overlord, player.name .. " has &cabandoned &fthe struggle in the &6Nether Arena&f!");
end
