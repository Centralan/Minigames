function t_copy (t)
 if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    setmetatable(target, meta)
    return target
end
 
local world = World:new('lms');
 
function s_angled_loc(x, y, z, yaw, pitch)
	local loc = Location:new(world, x, y, z);
	loc:setYaw(yaw);
	loc:setPitch(pitch);
	return loc;
end
 
local matchRunning = false;
local preMatchRunning = false;
local matchCheckTimer = Timer:new('s_match_check', 20 * 60);
local matchTimer = Timer:new('s_match_stale', 18000);
local lobbyLoc = s_angled_loc(-659, 197, 970, -179.80754, -0.30817112);
local matchTick = Timer:new('s_match_tick', 20 * 5);
local sign = Location:new(world, -660, 198, 967);
local playing = {};
 
local startLocations = {
	s_angled_loc(-668.5, 211.5, 963.5, 271.32587, -0.9963301),
	s_angled_loc(-668.5, 211.5, 969,5, 252.7451, 6.042929),
	s_angled_loc(-665.5, 211.5, 963.5, 238.29349, -2.673935),
	s_angled_loc(-662.5, 211.5, 977.5, 222.2362, 0.9963103),
	s_angled_loc(-658.5, 211.5, 980.5, 202.04984, 2.6020784),
	s_angled_loc(-649.5, 211.5, 981.5, 175.89928, -0.83881724),
	s_angled_loc(-644.5, 211.5, 980.5, 155.94223, -3.8208926),
	s_angled_loc(-640.5, 211.5, 978.5, 142.40816, -6.573562),
	s_angled_loc(-637.5, 211.5, 975.5, 133.00313, 3.978399),
	s_angled_loc(-634.5, 211.5, 972.5, 118.5515, 1.9139013),
	s_angled_loc(-633.5, 211.5, 969.5, 107.77013, 1.4551196),
	s_angled_loc(-632.5, 211.5, 965.5, 92.85971, 5.8135376),
	s_angled_loc(-631.5, 211.5, 961.5, 80.93137, -1.0681864),
	s_angled_loc(-632.5, 211.5, 957.5, 61.891926, 4.4371967),
	s_angled_loc(-635.5, 211.5, 953.5, 54.09263, 0.53757595),
	s_angled_loc(-639.5, 211.5, 949.5, 41.47613, 9.254396),
	s_angled_loc(-644.5, 211.5, 947.5, 5.46175, 4.666582),
	s_angled_loc(-648.5, 211.5, 947.5, 10.278968, -5.197223),
	s_angled_loc(-653.5, 211.5, 946.5, 347.48364, 6.9604983),
	s_angled_loc(-657.5, 211.5, 947.5, 334.1789, -1.2975707),
	s_angled_loc(-661.5, 211.5, 950.5, 320.64484, 3.7490246),
	s_angled_loc(-664.5, 211.5, 953.5, 308.71664, 0.07876854),
	s_angled_loc(-667.5, 211.5, 958.5, 286.007, 2.1432884),
};
 
local lootChests = {};
local lootChestStart = Location:new(world, -101, 62, 0);
local lootChestCount = 50;
 
local currentChest = 0;
 
while currentChest < lootChestCount do
	table.insert(lootChests, Location:new(world, lootChestStart.x + (currentChest * 2), lootChestStart.y, lootChestStart.z));
	currentChest = currentChest + 1;
end
 
local staticChestLocations = {
	Location:new(world, -655, 214, 963),
	Location:new(world, -655, 214, 965),
	Location:new(world, -654, 214, 966),
	Location:new(world, -653, 214, 967),
	Location:new(world, -651, 214, 968),
	Location:new(world, -649, 214, 968),
	Location:new(world, -647, 214, 966),
	Location:new(world, -647, 214, 964),
	Location:new(world, -648, 214, 962),
	Location:new(world, -649, 214, 961),
	Location:new(world, -650, 214, 960),
	Location:new(world, -652, 214, 960),
	Location:new(world, -654, 214, 961),
 
	
};
 
local randomChestLocations = {
	Location:new(world, -625, 222, 928),
	Location:new(world, -620, 212, 944),
	Location:new(world, -585, 227, 973),
	Location:new(world, -589, 323, 957),
	Location:new(world, -584, 239, 993),
	Location:new(world, -584, 254, 980),
	Location:new(world, -609, 237, 1007),
	Location:new(world, -612, 241, 1018),
	Location:new(world, -619, 237, 1026),
	Location:new(world, -650, 227, 1017),
	Location:new(world, -665, 231, 1023),
	Location:new(world, -663, 232, 1009),
	Location:new(world, -664, 219, 1012),
	Location:new(world, -708, 236, 1018),
	Location:new(world, -707, 236, 1015),
	Location:new(world, -722, 236, 1005),
	Location:new(world, -714, 231, 1000),
	Location:new(world, -734, 229, 948),
	Location:new(world, -729, 251, 951),
	Location:new(world, -710, 227, 938),
	Location:new(world, -698, 212, 962),
	Location:new(world, -677, 211, 983),
	Location:new(world, -655, 210, 1000),
	Location:new(world, -635, 216, 979),
	Location:new(world, -683, 212, 953),
	Location:new(world, -661, 212, 937),
 
};
 
function s_broadcast(msg)
	world:broadcast("&d[LMS] &3" .. msg);
end
 
function s_message(player, msg)
	player:sendMessage("&d[LMS] &3" .. msg);
end
 
function s_within_bounds(player, lX, lY, lZ, hX, hY, hZ)
	local world, x, y, z = player:getLocation();
	return x >= lX and y >= lY and z >= lZ and x <= hX and y <= hY and z <= hZ;
end
 
function s_get_players_in_lobby()
	local lobbyPlayers = {};
	local players = {world:getPlayers()};
 
	for index, playerName in pairs(players) do
		local player = Player:new(playerName);
		if s_within_bounds(player, -682, 207, 960, -608, 190, 996) then
			table.insert(lobbyPlayers, player);
		end
	end
	return lobbyPlayers;
end
 
function s_get_players_in_match()
	local matchPlayers = {};
	local players = {world:getPlayers()};
 
	for index, playerName in pairs(players) do
		local player = Player:new(playerName);
		if s_within_bounds(player, -682, 207, 960, -608, 190, 996) and not s_within_bounds(player, -54, 84, 28, -16, 111, 61) then
			table.insert(matchPlayers, player);
		end
	end
	return matchPlayers;
end
 
function s_match_start()
	matchRunning = true;
	
	local availableLocations = t_copy(startLocations);
	for index, player in pairs(s_get_players_in_lobby()) do
		if #availableLocations > 0 then
			local randomLocIndex = math.random(1, #availableLocations);
			player:clearInventory();
			player:teleport(availableLocations[randomLocIndex]);
			playing[player.name] = true;
			table.remove(availableLocations, randomLocIndex);
			s_message(player, "Last Man Standing has begun, good luck players!");
		else
			s_message(player, "Sorry, there are no more available spaces in this match!");
		end
	end
	
	for index, chestLocation in pairs(staticChestLocations) do
		chestLocation:setBlock(54, 0);
	end
	
	for index, chestLocation in pairs(randomChestLocations) do
		chestLocation:setBlock(54, 0);
	end
	
	matchTimer:start();
	matchTick:start();
end
 
function s_match_tick()
	local matchPlayers = s_get_players_in_match();
	local playerCount = #matchPlayers;
if playerCount < 2 then
		if playerCount == 1 then
			s_match_winner(matchPlayers[1]);
		elseif playerCount == 0 then
			s_broadcast('The match ended with no winner!');
		end
		s_match_end();
	else
		matchTick:start();
	end
end
 
function s_match_winner(winner)
	s_message(winner, "You have won this round of Last Man Standing!");
	sign:setSign('', 'Last Winner:', winner.name, '');
	local winner = Player:new(winner);
	winner:kill();
end
function s_match_stale()
	s_broadcast('Time up! The match concludes with no winner.');
	s_match_end();
end
 
function s_match_end()
	matchTick:cancel();
	matchTimer:cancel();
	matchRunning = false;
	playing = {};
	
	for index, chestLocation in pairs(staticChestLocations) do
		chestLocation:setBlock(0, 0);
	end
	
	for index, chestLocation in pairs(randomChestLocations) do
		chestLocation:setBlock(0, 0);
	end
	
	for index, player in pairs(s_get_players_in_match()) do
		player:clearInventory();
		s_teleport_player_to_lobby(player);
	end
	
	s_match_check();
	world:removeItems();
end
 
function s_teleport_player_to_lobby(player)
	player:teleport(lobbyLoc);
	player:clearInventory();
end
 
function s_match_check()
	if not matchRunning then
		if preMatchRunning then
			preMatchRunning = false;
			if #s_get_players_in_lobby() > 1 then
				s_match_start();
			else
				s_broadcast('Not enough players for a match!');
				matchCheckTimer:start();
			end
		else
			if #s_get_players_in_lobby() > 1 then
				preMatchRunning = true;
				s_broadcast('New match starting in 60 seconds! Prepare yourselves!');
			end
			matchCheckTimer:start();
		end
	end
end
s_match_check();
 
function s_chest_click(data)
	local player = Player:new(data.player);
	player:closeInventory();
	Location:new(world, data.x, data.y, data.z):setBlock(0, 0);
	local chest = lootChests[math.random(1, #lootChests)];
	chest:cloneChestToPlayer(player.name);
end
 
registerHook("INTERACT", "s_chest_click", 54, world.name);
