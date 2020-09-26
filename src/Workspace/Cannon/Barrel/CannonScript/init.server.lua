local Configurations = script.Parent.Parent.Configurations

if not game.StarterPack:FindFirstChild("ROBLOXPirateCannonScript") then
	script.ROBLOXPirateCannonScript.Parent = game.StarterPack
end

local cannon = script.Parent
local direction = cannon.CFrame:vectorToWorldSpace(Vector3.new(0,0,-1))	

local cannonAnchored = cannon.Anchored
if not cannonAnchored then
	cannon.Anchored = true
end
local baseAnchored = cannon.Parent.Base.Anchored
if not baseAnchored then
	cannon.Parent.Base.Anchored = true
end

local weld2 = Instance.new("Weld", cannon)
weld2.Part0 = cannon
weld2.Part1 = cannon.Parent.Base
weld2.C0 = cannon.CFrame:inverse() * cannon.Parent.Base.CFrame

local muzzle = Instance.new("Part", cannon.Parent)
muzzle.CanCollide = false
muzzle.Anchored = true
muzzle.CFrame = cannon.CFrame * CFrame.Angles(-math.pi/2,0,0)
muzzle.Size = Vector3.new(1,1,1)
muzzle.Position = cannon.Position + (cannon.Size.Z/2 - 1) * direction
muzzle.Transparency = 1

local weld = Instance.new("Weld", cannon)
weld.Part0 = cannon
weld.Part1 = muzzle
weld.C0 = cannon.CFrame:inverse() * muzzle.CFrame

cannon.Parent.Base:MakeJoints()

if not cannonAnchored then
	cannon.Anchored = false
end
if not baseAnchored then
	cannon.Parent.Base.Anchored = false
end
muzzle.Anchored = false

local canFire = true
script.Parent.PirateCannonEvent.OnServerEvent:connect(function()
	if canFire then
		canFire = false

		direction = cannon.CFrame:vectorToWorldSpace(Vector3.new(0,0,-1))			
		
		local fire = Instance.new("Fire", muzzle)
		fire.Heat = 20
		fire.Size = 2	
		game.Debris:AddItem(fire,.5)
			
		local smoke = Instance.new("Smoke", muzzle)
		smoke.RiseVelocity = 10
		smoke.Size = .5
		smoke.Opacity = .25
		game.Debris:AddItem(smoke, 3)	
		
		wait(.25)		
		
		local cannonball = Instance.new("Part", game.Workspace)
		cannonball.FormFactor = Enum.FormFactor.Custom
		cannonball.Material = Enum.Material.Slate
		cannonball.BrickColor = BrickColor.new("Really black")
		cannonball.Shape = Enum.PartType.Ball
		cannonball.Size = Vector3.new(1.9, 1.9, 1.9)
		cannonball.Position = script.Parent.Position + ((2 + script.Parent.Size.Z/2) * direction)
		cannonball.Velocity = direction * Configurations.CannonballSpeed.Value
		
		local cannonballScript = script.CannonballScript:Clone()
		for _, config in pairs(Configurations:GetChildren()) do
			config:Clone().Parent = cannonballScript
		end
		cannonballScript.Parent = cannonball
		cannonballScript.Disabled = false
		
		wait(Configurations.FireCooldown.Value)
		canFire = true
	end
end)