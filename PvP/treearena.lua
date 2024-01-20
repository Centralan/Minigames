local world = World:new('pvparena');

function respawn_wipe(data)
       local player = Player:new(data.player);
             player:clearInventory();
             pvpcompasschest:cloneChestToPlayer(player.name);
end

registerHook("REGION_LEAVE", "respawn_wipe", "pvparena-pvp_wipe")

