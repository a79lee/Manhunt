-- Services
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

-- Module Scripts
local ModuleScripts = ServerStorage:WaitForChild("ModuleScripts")
local LobbyState = require(ModuleScripts:WaitForChild("LobbyState"))

local state = LobbyState:new()

-- Pass through events to state
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("HumanoidRootPart").Touched:Connect(function(part)
			local otherPlayer = Players:GetPlayerFromCharacter(part.Parent)
			if otherPlayer and otherPlayer ~= player then
				state:onTouch(player, otherPlayer)
			end
		end)
	end)
	state:onPlayerAdded(player)
end)
Players.PlayerRemoving:Connect(function(player)
	state:onPlayerRemoved(player)
end)

-- Main loop: update state on interval
while state do
	state = state:update()
end
