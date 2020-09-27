-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))


local Lobby = {}
function Lobby:update()
	wait(GameSettings.intermissionDuration)
	if #self.players < GameSettings.minimumPlayers then
		return self
	else
		return self --Game.new() TODO
	end
end
function Lobby:onPlayerAdded(player)
	table.insert(self.players, player)
end
function Lobby:onPlayerRemoving(player)
	table.remove(self.players, player)
end
function Lobby:onTouch(player, part)
    print(player:GetFullName() .. " was touched by " .. part:GetFullName())
end
function Lobby:new(copy)
	copy = copy or {}
	setmetatable(copy, self)
	self.__index = self
	self.players = Players:GetPlayers()
	return copy
end
return Lobby