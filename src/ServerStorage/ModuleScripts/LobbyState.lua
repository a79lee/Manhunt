-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))

local LobbyState = {}
LobbyState.__index = LobbyState
function LobbyState.log(text)
	print("LobbyState: " .. text)
end
function LobbyState:update()
	wait(GameSettings.intermissionDuration)
	if #self.players < GameSettings.minimumPlayers then
		LobbyState.log("waiting for more players")
		return self
	else
		LobbyState.log("starting new game")
		local GameState = require(ModuleScripts:WaitForChild("GameState"))
		return GameState.new(self.players)
	end
end
function LobbyState:onPlayerAdded(player)
	LobbyState.log(player:GetFullName() .. " joined the lobby")
	table.insert(self.players, player)
end
function LobbyState:onPlayerRemoving(player)
	LobbyState.log(player:GetFullName() .. " left the lobby")
	table.remove(self.players, player)
end
function LobbyState:onTouch(player, part)
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
	local self = setmetatable({}, LobbyState)
	self:init(Players:GetPlayers())
	return self
end
return LobbyState