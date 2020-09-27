-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))


local Lobby = {}
function Lobby.new()
	local self = setmetatable({}, Lobby)
	self.players = Players.GetPlayers()
	return self
end
function Lobby.update(self)
	wait(GameSettings.intermissionDuration)
	if #self.players < GameSettings.minimumPlayers then
		return self
	else
		return nil --Game.new() TODO
	end
end
function Lobby.onPlayerAdded(self, player)
	table.insert(self.players, player)
end
function Lobby.onPlayerRemoved(self, player)
	table.remove(self.players, player)
end
