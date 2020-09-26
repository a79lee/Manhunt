local cannonball = script.Parent

-- Returns the ancestor that contains a Humanoid, if it exists
local function FindCharacterAncestor(subject)
	if subject and subject ~= game.Workspace then
		local humanoid = subject:FindFirstChild('Humanoid')
		if humanoid then
			return subject, humanoid
		else
			return FindCharacterAncestor(subject.Parent)
		end
	end
	return nil
end

local function OnExplosionHit(hitPart, hitDistance, blastCenter)
	local character, humanoid = FindCharacterAncestor(hitPart.Parent)
	if hitPart.Name == "CenterPart" then return false end
	if humanoid and humanoid.Health > 0 then
		if hitPart.Name == 'HumanoidRootPart' then
			humanoid:TakeDamage(script:FindFirstChild('Damage').Value)
		end
	else
		hitPart:BreakJoints()
		local blastForce = Instance.new('BodyForce', hitPart)
		blastForce.force = (hitPart.Position - blastCenter).unit * script:FindFirstChild('BlastForce').Value * hitPart:GetMass()
		game.Debris:AddItem(blastForce, 0.1)
	end
end


cannonball.Touched:connect(function(other)
	local explosion = Instance.new("Explosion")
	explosion.BlastPressure = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.BlastRadius = script:FindFirstChild('BlastRadius').Value
	explosion.Position = cannonball.Position	
	explosion.Parent = cannonball
	
	local connection = explosion.Hit:connect(function(hitPart, hitDistance) OnExplosionHit(hitPart, hitDistance, explosion.Position) end)
	wait(.1)
	cannonball:Destroy()
end)