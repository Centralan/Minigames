local world = World:new('creative');
local world2 = World:new('survival3');

local pkr_remove = Location:new(world2, 19549.456, 72.0, -20790.600);
pkr_remove:setYaw(90.6);
pkr_remove:setPitch(-8.6);


-----------------------------------
------------Lobby----------------------
-------------------------------------

function pkr_mode(data)
        local player = Player:new(data.player);
        if player:hasPermission("runsafe.toybox.mode") then
        else
           local player = Player:new(data.player);
                player:setMode("ADVENTURE");
                player:clearInventory();
end
end

function pkr_ban(data)
        local player = Player:new(data.player);
        if player:hasPermission("runsafe.pkr.blacklist") then
           player:sendMessage("&cSorry you've been blacklisted from playing Parkour");
           player:teleport(pkr_remove);
           player:playSound('ENTITY_VILLAGER_NO', 1, 1);
end
end

	
registerHook("REGION_ENTER", "pkr_mode", "creative-parkour");
registerHook("REGION_ENTER", "pkr_mode", "creative-p1");
registerHook("REGION_ENTER", "pkr_mode", "creative-p2");
registerHook("REGION_ENTER", "pkr_mode", "creative-p3");
registerHook("REGION_ENTER", "pkr_mode", "creative-p4");
registerHook("REGION_ENTER", "pkr_mode", "creative-p5");
registerHook("REGION_ENTER", "pkr_mode", "creative-p6");
registerHook("REGION_ENTER", "pkr_mode", "creative-p7");
registerHook("REGION_ENTER", "pkr_mode", "creative-p8");
registerHook("REGION_ENTER", "pkr_mode", "creative-p9");
registerHook("REGION_ENTER", "pkr_mode", "creative-p10");
registerHook("REGION_ENTER", "pkr_ban", "creative-parkour");
registerHook("REGION_ENTER", "pkr_ban", "creative-p1");
registerHook("REGION_ENTER", "pkr_ban", "creative-p2");
registerHook("REGION_ENTER", "pkr_ban", "creative-p3");
registerHook("REGION_ENTER", "pkr_ban", "creative-p4");
registerHook("REGION_ENTER", "pkr_ban", "creative-p5");
registerHook("REGION_ENTER", "pkr_ban", "creative-p6");
registerHook("REGION_ENTER", "pkr_ban", "creative-p7");
registerHook("REGION_ENTER", "pkr_ban", "creative-p8");
registerHook("REGION_ENTER", "pkr_ban", "creative-p9");
registerHook("REGION_ENTER", "pkr_ban", "creative-p10");


-----------------------------------
----------pkr_desert-----------------
-------------------------------------

local pkr_d = Location:new(world, -1393.531, 71.0, 5653.0);
pkr_d:setYaw(-90.4);
pkr_d:setPitch(6.6);

function pkr_d_respawn(data)
	local player = Player:new(data["player"]);
	player:teleport(pkr_d);
end

function pkr_d_complete(data)
	local player = Player:new(data["player"]);
	player:sendEvent("achievement.parkourcompetent");
end

registerHook("REGION_ENTER", "pkr_d_respawn", "creative-pkr_d_1");
registerHook("REGION_ENTER", "pkr_d_respawn", "creative-pkr_d_2");
registerHook("REGION_ENTER", "pkr_d_complete", "creative-pkr_d_cheeve");

-----------------------------------
----------pkr_plains--------
-------------------------------------

local pkr_p = Location:new(world, -1407.279, 71.0, 5666.0);
pkr_p:setYaw(1.2);
pkr_p:setPitch(3.6);

function pkr_p_respawn(data)
	local player = Player:new(data["player"]);
	player:teleport(pkr_p);
end

function pkr_p_complete(data)
	local player = Player:new(data["player"]);
	player:sendEvent("achievement.parkournovice");
end

registerHook("REGION_ENTER", "pkr_p_respawn", "creative-pkr_p_1");
registerHook("REGION_ENTER", "pkr_p_respawn", "creative-pkr_p_2");
registerHook("REGION_ENTER", "pkr_p_respawn", "creative-pkr_p_3");
registerHook("REGION_ENTER", "pkr_p_respawn", "creative-pkr_p_4");
registerHook("REGION_ENTER", "pkr_p_complete", "creative-pkr_p_cheeve");

-----------------------------------
----------pkr_water--------
-------------------------------------

local pkr_o = Location:new(world, -1407.449, 71.0, 5638.509);
pkr_o:setYaw(179.3);
pkr_o:setPitch(6.7);

function pkr_o_respawn(data)
	local player = Player:new(data["player"]);
	player:teleport(pkr_o);
end

function pkr_o_complete(data)
	local player = Player:new(data["player"]);
	player:sendEvent("achievement.parkourmaster");
end

function pkr_o_finish(data)
	local player = Player:new(data["player"]);
	player:teleport(pkr_o);
end

registerHook("REGION_ENTER", "pkr_o_respawn", "creative-parkour_blue_fall1");
registerHook("REGION_ENTER", "pkr_o_complete", "creative-pkr_o_cheeve");
registerHook("REGION_ENTER", "pkr_o_finish", "creative-pkr_o_warp");
