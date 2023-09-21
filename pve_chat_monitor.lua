local myWorld = World:new('mobarena'); 
local myWorld5 = World:new('mobarena_nether');

function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		local player = Player:new(data.player);
		local message = data.message;

		if hasPrefix(message, "#ResetNether") then
			local playerName = splitPlayerName(message, 16);
			nR1Done = false;
                        nR2Done = false;
                        nR3Done = false;
                        nR4Done = false;
			nR5Done = false;
	                nRoundRunning = false;
			player:sendMessage("Reseting &6Nether &fArena.");

		if hasPrefix(message, "#ResetMine") then
			local playerName = splitPlayerName(message, 16);
			mR1Done = false;
                        mR2Done = false;
                        mR3Done = false;
                        mR4Done = false;
			mR5Done = false;
	                mRoundRunning = false;
			player:sendMessage("Reseting &6Mine &fArena.");


		if hasPrefix(message, "#ResetSurface") then
			local playerName = splitPlayerName(message, 16);
			sR1Done = false;
                        sR2Done = false;
                        sR3Done = false;
                        sR4Done = false;
			sR5Done = false;
	                sRoundRunning = false;
			player:sendMessage("Reseting &6Surface &fArena.");


				end
			end
		end
	end
end
	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena");
	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena_nether");

