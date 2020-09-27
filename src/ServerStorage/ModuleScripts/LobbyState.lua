-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))

local LobbyState = {}
function LobbyState:update()
	wait(GameSettings.intermissionDuration)
	if #self.players < GameSettings.minimumPlayers then
		print ("waiting for min players")
		return self
	else
		print ("starting new game")
		local GameState = require(ModuleScripts:WaitForChild("GameState"))
		return GameState.new(self.players)
	end
end
function LobbyState:onPlayerAdded(player)
	print ("Player added to lobby")
	table.insert(self.players, player)
end
function LobbyState:onPlayerRemoving(player)
	print ("Player removed from lobby")
	table.remove(self.players, player)
end
function LobbyState:onTouch(player, part)
    print(player:GetFullName() .. " was touched by " .. part:GetFullName())
end
function LobbyState:init(players)
	print ("Lobby Init")
	for i, player in pairs(players) do
		player.Neutral = true
		player.Team = nil
	end
	self.players = players
end
function LobbyState.new()
	self = setmetatable({}, LobbyState)
	self:init(Players:GetPlayers())
	return copy
end
return LobbyState