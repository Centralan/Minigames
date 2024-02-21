local world = World:new('pkr');
local world2 = World:new('survival3');

local pkr_remove = Location:new(world2, 19549.456, 72.0, -20790.600);
pkr_remove:setYaw(90.6);
pkr_remove:setPitch(-8.6);

local pkr_reset = Location:new(world, 0.0, 65.0, 0.0);
pkr_reset:setYaw(0.0);
pkr_reset:setPitch(0.9);


-----------------------------------
------------Lobby----------------------
-------------------------------------

function pkr_ban(data)
        local player = Player:new(data.player);
        if player:hasPermission("runsafe.pkr.blacklist") then
           player:sendMessage("&cSorry you've been blacklisted from playing Parkour");
           player:teleport(pkr_remove);
           player:playSound('ENTITY_VILLAGER_NO', 1, 1);
end
end

function pkr_red_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
             player:sendTitle("&c&lRed Course", "&l# Jumps");
end
end

function pkr_yellow_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
             player:sendTitle("&e&lYellow Course", "&l32 Jumps");
end
end

function pkr_green_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
             player:sendTitle("&a&lGreen Course", "&l31 Jumps");
end
end

function pkr_blue_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
             player:sendTitle("&9&lBlue Course", "&l31 Jumps");
end
end

registerHook("REGION_ENTER", "pkr_ban", "pkr-pkr_purple");
registerHook("REGION_ENTER", "pkr_ban", "pkr-pkr_red");
registerHook("REGION_ENTER", "pkr_ban", "pkr-pkr_yellow");
registerHook("REGION_ENTER", "pkr_ban", "pkr-pkr_green");
registerHook("REGION_ENTER", "pkr_ban", "pkr-pkr_blue");
registerHook("REGION_ENTER", "pkr_red_enter", "pkr-pkr_red");
registerHook("REGION_ENTER", "pkr_yellow_enter", "pkr-pkr_yellow");
registerHook("REGION_ENTER", "pkr_green_enter", "pkr-pkr_green");
registerHook("REGION_ENTER", "pkr_blue_enter", "pkr-pkr_blue");

-----------------------------------
--------pkr_yellow-----------------
-----------------------------------

local pkr_y = Location:new(world, 26.500, 65.0, -6.500);
pkr_y:setYaw(-178.7);
pkr_y:setPitch(-0.2);

local yellowsign = Location:new(world, 34.0, 67.0, -1.0);

function pkr_y_respawn(data)
	local player = Player:new(data.player);
	player:teleport(pkr_y);
	player:playSound('ENTITY_GENERIC_BIG_FALL', 1, 0.1);
end

function pkr_y_cheeve(data)
	local player = Player:new(data.player);
	player:sendEvent("achievement.parkourcompetent");
end

function pkr_y_complete(data)
	local player = Player:new(data.player);
	player:teleport(pkr_reset);
	yellowsign:setSign('Last Completion:', player.name, '', '');
end

registerHook("REGION_ENTER", "pkr_y_respawn", "pkr-pkr_y_1");
registerHook("REGION_ENTER", "pkr_y_respawn", "pkr-pkr_y_2");
registerHook("REGION_ENTER", "pkr_y_cheeve", "pkr-pkr_y_cheeve");
registerHook("REGION_ENTER", "pkr_y_complete", "pkr-pkr_y_complete");

-----------------------------------
--------pkr_green--------
-----------------------------------

local pkr_g = Location:new(world, 0.500, 65.0, 16.500);
pkr_g:setYaw(1.2);
pkr_g:setPitch(3.6);

local greensign = Location:new(world, 34.0, 67.0, -2.0);

function pkr_g_respawn(data)
	local player = Player:new(data.player);
	player:teleport(pkr_g);
end

function pkr_g_complete(data)
	local player = Player:new(data.player);
	player:sendEvent("achievement.parkournovice");
	player:playSound('ENTITY_GENERIC_BIG_FALL', 1, 0.1);
end

function pkr_g_finish(data)
	local player = Player:new(data.player);
	player:teleport(pkr_reset);
	greensign:setSign('Last Completion:', player.name, '', '');
end

registerHook("REGION_ENTER", "pkr_g_respawn", "pkr-pkr_g_1");
registerHook("REGION_ENTER", "pkr_g_respawn", "pkr-pkr_g_2");
registerHook("REGION_ENTER", "pkr_g_respawn", "pkr-pkr_g_3");
registerHook("REGION_ENTER", "pkr_g_respawn", "pkr-pkr_g_4");
registerHook("REGION_ENTER", "pkr_g_complete", "pkr-pkr_g_cheeve");
registerHook("REGION_ENTER", "pkr_g_finish", "pkr-pkr_g_finish");

-----------------------------------
--------pkr_blue--------
-----------------------------------

local pkr_b = Location:new(world, 0.500, 65.0, -14.500);
pkr_b:setYaw(179.9);
pkr_b:setPitch(-1.9);

local bluesign = Location:new(world, 34.0, 67.0, 1.0);

function pkr_b_respawn(data)
	local player = Player:new(data.player);
	player:teleport(pkr_b);
end

function pkr_b_complete(data)
	local player = Player:new(data.player);
	player:sendEvent("achievement.parkourmaster");
	player:playSound('ENTITY_GENERIC_BIG_FALL', 1, 0.1);
end

function pkr_b_finish(data)
	local player = Player:new(data.player);
	player:teleport(pkr_reset);
	bluesign:setSign('Last Completion:', player.name, '', '');
end

registerHook("REGION_ENTER", "pkr_b_respawn", "pkr-pkr_blue_fall");
registerHook("REGION_ENTER", "pkr_b_complete", "pkr-pkr_b_cheeve");
registerHook("REGION_ENTER", "pkr_b_finish", "pkr-pkr_b_complete");

