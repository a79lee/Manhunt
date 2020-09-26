-- Services
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local matchManager = require(moduleScripts:WaitForChild("MatchManager"))
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))

while true do
	-- wait for there to be enough players
	repeat
		print ("starting intermission")
		print (#Players:GetPlayers())
		wait(gameSettings.intermissionDuration)
	until #Players:GetPlayers() >= gameSettings.minimumPlayers 

	print ("intermission done")
	wait (gameSettings.transitionStart)
	
	-- setup phase
	--matchManager.preparePlayers()
	matchManager.prepareGame()
end

-- https://education.roblox.com/en-us/resources/battle-royale/managing-players