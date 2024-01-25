local world = World:new('pvparena');

function respawn_wipe(data)
       local player = Player:new(data.player);
             player:clearInventory();
             pvpcompasschest:cloneChestToPlayer(player.name);
end

function pvp_add(data)
       local player = Player:new(data.player);
             pvpPlayers[data.player] = true;
end

function pvp_remove(data)
       local player = Player:new(data.player);
             pvpPlayers[data.player] = nil;
end
function compass_tracking(data)
       local pvpPlayers = {};
       local playerLocation = player:getLocation()
       local nearestPlayer = playerLocation:getClosestPlayer()
       for playerName, value in pairs(pvpPlayers) do
          local player = Player:new(data.player);

         if nearestPlayer ~= nil then
            player:setCompassTarget(nearestPlayer:getLocation())
       end
end
end

registerHook("REGION_LEAVE", "respawn_wipe", "pvparena-pvp_wipe")
registerHook("REGION_ENTER", "pvp_add", "pvparena-pvpbalcony")
registerHook("REGION_LEAVE", "pvp_remove", "pvparena-pvparena")
registerHook("BLOCK_GAINS_CURRENT", "compass_tracking", "pvparena", -1033.0, 22.0, 444.0);

