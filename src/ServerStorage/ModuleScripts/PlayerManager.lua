local PlayerManager = {}

-- Services
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Teams = game:GetService("Teams")

-- Map Variables
local lobbySpawn = workspace.Lobby.StartSpawn
--local arenaMap = workspace.Arena
--local spawnLocations = arenaMap.SpawnLocations

-- Player Variables
local activePlayers = {}

-- Module Functions
function PlayerManager.sendPlayersToMatch()
	print("Sending players to match")

	local players = Players:GetPlayers()
	local n = table.getn(players)
	local k = math.random(1, n)

	for i, player in pairs(players) do
		table.insert(activePlayers, player)
		player.Team = {Teams.Prey, Teams.Predator}[i == k]
		player.RespawnLocation = workspace.SpawnLocation
		player:LoadCharacter()
	end
end

-- Events
Players.PlayerAdded:Connect(function(player)
	player.RespawnLocation = lobbySpawn

end)

return PlayerManager