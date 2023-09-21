local myWorld = World:new('mobarena'); 
local myWorld5 = World:new('mobarena_nether');

local function hasPrefix(subject, prefix)
	return string.sub(subject, 1, string.len(prefix)) == prefix;
end

local function splitPlayerName(message, len)
	return string.sub(message, len, string.len(message));
end

function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		local player = Player:new(data.player);
		local message = data.message;

		if hasPrefix(message, "#ResetNether") then
			local playerName = splitPlayerName(message, 16);)
		        nRoundRunning = false;
			nR1Done = false;
                        nR2Done = false;
                        nR3Done = false;
                        nR4Done = false;
			nR5Done = false;
			player:sendMessage("&5Server:&6Nether &fArena has been reset.");

		if hasPrefix(message, "#ResetMine") then
			local playerName = splitPlayerName(message, 16);
			mRoundRunning = false;
			mR1Done = false;
                        mR2Done = false;
                        mR3Done = false;
                        mR4Done = false;
			player:sendMessage("&5Server:&6Mine &fArena has been reset.");


		if hasPrefix(message, "#ResetSurface") then
			local playerName = splitPlayerName(message, 16);
			sRoundRunning = false;
			sR1Done = false;
                        sR2Done = false;
                        sR3Done = false;
                        sR4Done = false;
			sR5Done = false;
			player:sendMessage("&5Server:&6Surface &fArena has been reset.");


				end
			end
		end
	end
end
	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena");
	registerHook("CHAT_MESSAGE", "chatMonitor", "mobarena_nether");

