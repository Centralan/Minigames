function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" or data.player == "iliketoeatpenuts" or data.player == "Kruithne" then
		local player = Player:new(data.player);
		local message = data.message;
