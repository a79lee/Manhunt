-- Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local GameSettings = require(ModuleScripts:WaitForChild("GameSettings"))

local GameState = {}
GameState.__index = GameState
function GameState.log(text)
	print("GameState: " .. text)
end
function GameState:update()
    wait(GameSettings.updateInterval)
    if self.predatorCount == 0 or self.preyCount == 0 then
        GameState.log("game has ended, returning to lobby")
        local LobbyState = require(ModuleScripts:WaitForChild("LobbyState"))
        return LobbyState.new()
    else
        return self
    end
end
function GameState:onPlayerAdded(player)
    -- If a player joins in the middle of the game they do not get assigned
    -- a side and remain neutral until the next Lobby state.
    GameState.log(player:GetFullName() .. " joined and will be added next game")
    player.Neutral = true
    player.Team = nil
end
function GameState:onPlayerRemoving(player)
    -- If a player leaves in the middle of the game it may end the game, we
    -- must be careful to adjust the counts accordingly so that this can
    -- happen on the next update.
    if player.Team == Teams.Hunter then
        self.predatorCount -= 1
        GameState.log(player:GetFullName() .. " (predator) the game")
    elseif player.Team == Teams.Prey then
        self.preyCount -= 1
        GameState.log(player:GetFullName() .. " (prey) the game")
    else
        GameState.log(player:GetFullName() .. " (neutral) the game")
    end
	table.remove(self.players, player)
end
function GameState:onTouch(player, other)
    -- If a predator touches a prey then the prey switches teams.
    if player.Team == Teams.Hunter and
       other.Team == Teams.Prey then
        GameState.log(player:GetFullName() .. " was caught by " .. other:GetFullName())
        other.Team = Teams.Hunter
        self.preyCount -= 1
        self.predatorCount += 1
    end
end
function GameState:init(players)
    -- Choose a predator and assign teams
    local k = math.random(1, #players)
    for i, player in pairs(players) do
        player.Team = (i == k) and Teams.Hunter or Teams.Prey
        player.Neutral = false
    end
    self.players = players
    self.preyCount = #players - 1
    self.predatorCount = 1
    GameState.log(players[k]:GetFullName() .. " was chosen as predator")
end
function GameState.new(players)
	local self = setmetatable({}, GameState)
	self:init(players)
	return self
end
return GameState