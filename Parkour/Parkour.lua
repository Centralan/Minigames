local world = World:new('pkr');
local world2 = World:new('survival3');

local pkr_remove = Location:new(world2, 19549.456, 72.0, -20790.600);
pkr_remove:setYaw(90.6);
pkr_remove:setPitch(-8.6);

local pkr_reset = Location:new(world, 0.0, 65.0, 0.0);
pkr_reset:setYaw(0.0);
pkr_reset:setPitch(0.9);

local pkr_dropperenter = Location:new(world, -124.5, 67.0, -0.5);
pkr_dropperenter:setYaw(90.0);
pkr_dropperenter:setPitch(0.3);

function p_broadcast(msg)
	world:broadcast("&e[PKR] &f" .. msg);
end

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

function pkr_dropper_enter(data)
        local player = Player:new(data.player);
        if not player:hasPermission("runsafe.pkr.blacklist") then
           player:teleport(pkr_dropperenter);
end
end

function pkr_dropper_exit(data)
        local player = Player:new(data.player);
        if not player:hasPermission("runsafe.pkr.blacklist") then
           player:teleport(pkr_reset);
end
end

function pkr_yellow_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
	  if not player:hasPermission("runsafe.pkr.yellow") then
             player:sendTitle("&e&lYellow Course", "&l32 Jumps");
	     player:addPermission("runsafe.pkr.yellow");
					end
				end
			end

function pkr_green_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
	  if not player:hasPermission("runsafe.pkr.green") then
             player:sendTitle("&a&lGreen Course", "&l31 Jumps");
	     player:addPermission("runsafe.pkr.green");
					end
				end
			end

function pkr_blue_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
	  if not player:hasPermission("runsafe.pkr.blue") then
             player:sendTitle("&9&lBlue Course", "&l49 Jumps");
	     player:addPermission("runsafe.pkr.blue");
					end
				end
			end

function pkr_red_enter(data)
        local player = Player:new(data.player);
          if not player:hasPermission("runsafe.pkr.blacklist") then
	  if not player:hasPermission("runsafe.pkr.red") then
             player:sendTitle("&c&lRed Course", "&l1&k07 &r&l Jumps");
	     player:addPermission("runsafe.pkr.red");
					end
				end
			end


function pkr_perm_wipe(data)
        local player = Player:new(data.player);
          player:removePermission("runsafe.pkr.red");
	  player:removePermission("runsafe.pkr.yellow");
	  player:removePermission("runsafe.pkr.green");
	  player:removePermission("runsafe.pkr.blue");
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
registerHook("REGION_LEAVE", "pkr_perm_wipe", "pkr-pkr");
registerHook("REGION_ENTER", "pkr_dropper_enter", "pkr-dropper_enter");
registerHook("REGION_ENTER", "pkr_dropper_exit", "pkr-dropper_exit");

-----------------------------------
--------pkr_yellow-----------------
-----------------------------------

local pkr_y = Location:new(world, 26.500, 65.0, -6.500);
pkr_y:setYaw(-178.7);
pkr_y:setPitch(-0.2);

local yellowsign = Location:new(world, 34.0, 67.0, -1.0);
local yellowsound = Location:new(world, 26.0, 64.0, -7.0);

function pkr_y_respawn(data)
	local player = Player:new(data.player);
	player:teleport(pkr_y);
end

function pkr_y_cheeve(data)
	local player = Player:new(data.player);
	player:sendEvent("achievement.parkourcompetent");
end

function pkr_y_complete(data)
	local player = Player:new(data.player);
	player:teleport(pkr_reset);
	yellowsign:setSign('', 'Last Completion:', player.name, '');
end

registerHook("REGION_ENTER", "pkr_y_respawn", "pkr-pkr_y_1");
registerHook("REGION_ENTER", "pkr_y_respawn", "pkr-pkr_y_2");
registerHook("REGION_ENTER", "pkr_y_cheeve", "pkr-pkr_y_cheeve");
registerHook("REGION_ENTER", "pkr_y_complete", "pkr-pkr_y_complete");

-----------------------------------
--------pkr_green--------
-----------------------------------

local pkr_g = Location:new(world, 0.500, 65.0, 15.500);
pkr_g:setYaw(0.0);
pkr_g:setPitch(-1.1);

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
	greensign:setSign('', 'Last Completion:', player.name, '');
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
pkr_b:setPitch(-2.1);

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
	bluesign:setSign('', 'Last Completion:', player.name, '');
end

registerHook("REGION_ENTER", "pkr_b_respawn", "pkr-pkr_blue_fall");
registerHook("REGION_ENTER", "pkr_b_complete", "pkr-pkr_b_cheeve");
registerHook("REGION_ENTER", "pkr_b_finish", "pkr-pkr_b_complete");

-----------------------------------
--------pkr_red--------
-----------------------------------

local pkr_r = Location:new(world, 26.500, 65.0, 7.500);
pkr_r:setYaw(-0.3);
pkr_r:setPitch(6.9);

local redsign = Location:new(world, 34.0, 67.0, 2.0);

function pkr_r_respawn(data)
	local player = Player:new(data.player);
	player:teleport(pkr_r);
end

function pkr_r_complete(data)
	local player = Player:new(data.player);
	--player:sendEvent("achievement.pkrred");
	player:playSound('ENTITY_GENERIC_BIG_FALL', 1, 0.1);
end

function pkr_r_finish(data)
	local player = Player:new(data.player);
	player:teleport(pkr_reset);
	redsign:setSign('', 'Last Completion:', player.name, '');
end


registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_1");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_2");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_3");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_4");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_5");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_6");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_7");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_8");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_9");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_10");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_11");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_12");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_13");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_14");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_15");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_16");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_17");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_18");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_19");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_20");
registerHook("REGION_ENTER", "pkr_r_respawn", "pkr-pkr_red_21");
registerHook("REGION_ENTER", "pkr_r_complete", "pkr-pkr_red_portal");
registerHook("REGION_ENTER", "pkr_r_finish", "pkr-pkr_red_portal");

----------------------------------------------------------------
--------DROPPER 1-----------------------------------------------
----------------------------------------------------------------


local dropper1 = Location:new(world, -251.5, 219.0, 30.5);
dropper1:setYaw(-90.0);
dropper1:setPitch(4.3);

local d1 = Location:new(world, -126.0, 71.0, 8.0);

function dropper1_enter2(data)
	local player = Player:new(data.player);
	player:teleport(dropper1);
	player:sendTitle("&a&lDropper 1", "&lEasy");
end

function dropper1_enter(data)
	local player = Player:new(data.player);
	player:teleport(dropper1);
end


function respawn_dropper1(data)
             local player = Player:new(data.player);
                   player:teleport(pkr_dropperenter);
                   d1:setSign('', 'Last Completion:', player.name, '');
end

registerHook("REGION_ENTER", "dropper1_enter2", "pkr-dropper1_e")
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_1");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_2");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_3");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_4");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_5");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_6");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_7");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_8");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_9");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_10");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_11");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_12");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_13");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_14");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_15");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_16");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_17");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_18");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_19");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_20");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_21");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_22");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_23");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_24");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_25");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_26");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_27");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_28");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_29");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_30");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_31");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_32");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_33");
registerHook("REGION_ENTER", "dropper1_enter", "pkr-d1_34");
registerHook("INTERACT", "respawn_dropper1", 77, "pkr", -215.0, 22.0, 30.0);
