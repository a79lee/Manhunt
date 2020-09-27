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
		return self
	else
		return GameState:new(self.players)
	end
end
function LobbyState:onPlayerAdded(player)
	table.insert(self.players, player)
end
function LobbyState:onPlayerRemoving(player)
	table.remove(self.players, player)
end
function LobbyState:onTouch(player, part)
    print(player:GetFullName() .. " was touched by " .. part:GetFullName())
end
function LobbyState:init(players)
	for player in players do
		player.Neutral = true
		player.Team = nil
	end
	self.players = players
end
function LobbyState:new(copy)
	copy = copy or {}
	setmetatable(copy, self)
	self.__index = self
	self:init(Players:GetPlayers())
	return copy
end
return LobbyState