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

-- Local Functions
local function onPlayerJoin(player)
	player.RespawnLocation = lobbySpawn
end

local function preparePlayer(player, whichSpawn)
	player.RespawnLocation = whichSpawn
	player:LoadCharacter()
end
-- Module Functions
function PlayerManager.pickIt()
	-- For now this is just random, but we should probably
	-- make the first person caught be 'it' the next time
	local n = table.getn(activePlayers)
	local k = math.random(1, n)
	for player in activePlayers do
		player.Team = Teams.Prey
	end
	activePlayers[k].Team = Teams.Predator
end
function PlayerManager.sendPlayersToMatch()
	print("Sending players to match")

	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		table.insert(activePlayers, whichPlayer)
		preparePlayer(whichPlayer, workspace.SpawnLocation)
	end
	pickIt()
end

-- Events
Players.PlayerAdded:Connect(onPlayerJoin)

return PlayerManager