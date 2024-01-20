local world = World:new('pvparena');
local pvpcompass = Location:new(world, -1030.0, 22.0, 446.0);

function respawn_wipe(data)
       local player = Player:new(data.player);
             player:clearInventory();
             pvpcompass:cloneChestToPlayer(player.name);
end

registerHook("REGION_LEAVE", "respawn_wipe", "pvparena-pvp_wipe")
