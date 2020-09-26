local Players = game:GetService("Players")
local Teams = game:GetService("Teams"):GetTeams()

--IGNORE THIS SCRIPT
Players.PlayerAdded:Connect(function(player)
	--print (player.name .. "JOINED THE GAME")
	-- player.Team = Teams[1]
	-- print (player.Team)
	
	-- if game is going on, spectate, otherwise put in lobby 
	-- randomly assign one person to be the hunter
	-- everyone else is prey
end)

-- next step is to look into part detection and then having that switch teams for you