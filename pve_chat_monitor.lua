local myWorld = World:new('mobarena'); 
local myWorld5 = World:new('mobarena_nether');

function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan"
		local player = Player:new(data.player);
		local message = data.message;

		if hasPrefix(message, "#ResetNether") then
			local playerName = splitPlayerName(message, 16);
			addPlayerToGreenTeam(playerName);
			player:sendMessage("Reseting &6Nether &fArena.");

		if hasPrefix(message, "#ResetMine") then
			local playerName = splitPlayerName(message, 16);
			addPlayerToGreenTeam(playerName);
			player:sendMessage("Reseting &6Mine &fArena.");


		if hasPrefix(message, "#ResetSurface") then
			local playerName = splitPlayerName(message, 16);
			addPlayerToGreenTeam(playerName);
			player:sendMessage("Reseting &6Surface &fArena.");


				end
			end
		end

	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena");
	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena_nether");

