local myWorld = World:new('mobarena_nether');
local oldWorld = World:new('mobarena');
local nethersound = Location:new(myWorld, 0.0, 86.0, 0.0);

----------------
--Arena Catch --
----------------

local myWorld = World:new('Code4');
local nethercatch = Location:new(myWorld, 0, 86.0, 0.0);

function nether_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "nether_catch", "mobarena_nether-pve_nether_catch");
