local PlayerManager = {}

-- Services
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

-- Map Variables
local lobbySpawn = workspace.Lobby.StartSpawn
--local arenaMap = workspace.Arena
--local spawnLocations = arenaMap.SpawnLocations

-- Player Variables
local activePlayers = {}


-- Local Functions
local function onPlayerJoin(player)
	player.RespawnLocation = lobbySpawn
end

local function preparePlayer(player, whichSpawn)
	player.RespawnLocation = whichSpawn
	player:LoadCharacter()
end
-- Module Functions
function PlayerManager.sendPlayersToMatch()
	print("Sending players to match")

	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		table.insert(activePlayers, whichPlayer)
		preparePlayer(whichPlayer, workspace.SpawnLocation)
	end

end

-- Events
Players.PlayerAdded:Connect(onPlayerJoin)

return PlayerManager