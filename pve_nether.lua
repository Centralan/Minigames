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

----------------
--Arena Catch --
----------------

function nether_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(nethercatch);
end

registerHook("REGION_ENTER", "nether_catch", "mobarena_nether-pve_nether_catch");
