-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))
local GameState = require(ModuleScripts:WaitForChild("GameState"))

local LobbyState = {}
function LobbyState:update()
	wait(GameSettings.intermissionDuration)
	if #self.players < GameSettings.minimumPlayers then
		print ("waiting for min players")
		return self
	else
		print ("starting new game")
		return GameState:new(self.players)
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
	for player in players do
		player.Neutral = true
		player.Team = nil
	end
	self.players = players
end
function LobbyState:new(copy)
	print ("New lobby")
	copy = copy or {}
	setmetatable(copy, self)
	self.__index = self
	self:init(Players:GetPlayers())
	return copy
end
return LobbyState