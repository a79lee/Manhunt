-- Services
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local Lobby = require(ModuleScripts:WaitForChild("Lobby"))

local state = Lobby.new()

-- Pass through events to state
Players.PlayerAdded:Connect(function(player) state.onPlayerAdded(player) end)
Players.PlayerRemoved:Connect(function(player) state.onPlayerRemoved(player) end)

-- Main loop: update state on interval
while state do
	state = state.update()
end
