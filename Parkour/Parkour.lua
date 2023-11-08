local world = World:new('creative');

-----------------------------------
----------pkr----------------------
-----------------------------------

function pkr_mode(data)
        local p = Player:new(data["player"]);
        p:setMode("ADVENTURE");
	p:clearInventory();
end

registerHook("REGION_ENTER", "pkr_mode", "creative-centralan_7");

-----------------------------------
--------pkr_desert-----------------
-----------------------------------

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
--------pkr_plains--------
-----------------------------------

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
--------pkr_water--------
-----------------------------------

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
registerHook("REGION_ENTER", "pkr_0_complete", "creative-pkr_o_cheeve");
registerHook("REGION_ENTER", "pkr_0_finish", "creative-pkr_o_warp");

