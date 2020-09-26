local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.Button1Down:connect(function()
	local part = mouse.Target
	if part and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local event = part:FindFirstChild("PirateCannonEvent")
		if event then
			local distance = (part.Position - player.Character.HumanoidRootPart.Position).magnitude
			local Configurations = part.Parent:FindFirstChild("Configurations")
			local maxDistance = 32
			if Configurations and Configurations:FindFirstChild("MaxClickDistance") then
				maxDistance = Configurations.MaxClickDistance.Value
			end
			if distance <= maxDistance then
				event:FireServer()
			end
		end
	end
end)