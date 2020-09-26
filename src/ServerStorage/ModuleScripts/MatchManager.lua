local MatchManager = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))


function MatchManager.preparePlayers()
	-- Randomly assign one (or two but lets try one first for testing) to be it
	
	print("Game starting!")
end

-- Module Functions
function MatchManager.prepareGame()
	playerManager.sendPlayersToMatch()
end
return MatchManager