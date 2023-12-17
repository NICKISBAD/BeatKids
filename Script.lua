local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

_G.Debug = false

if not _G.Debug then
    _G.Window = OrionLib:MakeWindow({Name = "Beat your meat", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
elseif _G.Debug then
	_G.Window = OrionLib:MakeWindow({Name = "DebugMode", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
end


local Tab = _G.Window:MakeTab({
	Name = "Tab 1",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local function AntiRange(Gun)
	local a = require(game:GetService("ReplicatedStorage").Modules.Tools.Gun.Settings[Gun])
	
	a.NPCProjectileSpeed = 1
end

local function GunMod(GunName)
	local Obj = require(game:GetService("ReplicatedStorage").Modules.Tools.Gun.Settings[GunName])
	
	Obj.AmmoPerMag = 1000
	Obj.Automatic = true
	Obj.ReloadTime = 0
	Obj.Spread = 0
	Obj.FireRate = 0.1
    Obj.Range = 250
    Obj.Knockback = 0
    Obj.ProjectileSpeed = 500
    Obj.MaxPierce = 999
end


_G.MilitantFarm = false
_G.DarkAges = false

local function CannonDamage(NPC)
	local args = {
        [1] = game.Players.LocalPlayer.Backpack:WaitForChild("Hand Cannon"),
        [2] = NPC
    }

    game:GetService("ReplicatedStorage").Remotes.GunHit:FireServer(unpack(args))
end

local function SimulateAttack()
	
	local args = {
    [1] = game:GetService("Players").LocalPlayer.Character.Sword,
    [2] = 1
}

game:GetService("ReplicatedStorage").Remotes.MeleeAttacked:FireServer(unpack(args))
end

_G.AutoParry = false

Tab:AddToggle({
	Name = "AutoParry (face target, hold sword)",
	Callback = function(v)
		_G.AutoParry = v
	end
})

spawn(function()
	while wait() do
		if _G.AutoParry then
			SimulateAttack()
		end
	end
end)

Tab:AddToggle({
	Name = "Auto Militant",
	Default = false,
	Callback = function(v)
		_G.MilitantFarm = v
	end
})

spawn(function()
	while wait() do
		if _G.MilitantFarm then
			for i,v in pairs(game.Workspace:GetChildren()) do
				if table.find({"Meleer Militant", "Gunner Militant", "Grenader Militant", "Medic Militant", "Combatant Militant", "Brute Militant", "Viper", "Juggernaut"}, v.Name) then
					CannonDamage(v:WaitForChild("HumanoidRootPart").Position) wait(1)
			  end
	       end
		end
	end
end)

Tab:AddToggle({
	Name = "Auto Dark Ages",
	Default = false,
	Callback = function(v)
		_G.DarkAges = v
	end
})

 
Tab:AddToggle({
	Name = "Auto Desert",
	Default = false,
	Callback = function(v)
		_G.Desert = v
	end
})

Tab:AddToggle({
	Name = "Auto Park",
	Default = false,
	Callback = function(v)
		_G.Park = v
	end
})

Tab:AddButton({
	Name = "WIP Button",
	Callback = function()
		game.StarterGui:SetCore("SendNotification",{
			Title = "This Button does nothing yet",
			Text = "Error?"
		})
	    CannonDamageToEntireWorkspace()
	end
})

local EnemyTargets = {}

Tab:AddDropdown({
	Name = "Enemy Targets",
	Default = "Enemy",
	Options = {"Robloxian", "Angry Robloxian", "Tiny Robloxian", "Gunner Robloxian", "Giant Robloxian", "Rich Robloxian", "Tiny Angry Robloxian", "Raging Robloxian", "Rox The Destroyer",  "Crazy Robloxian",  "Mummy", "Tiny Mummy", "Fast Mummy", "Strong Mummy", "Sandstone", "Carium", "Camel", "Goblin", "Orc", "Buster Goblin", "Skeleton", "Red Fungus", "Blue Fungus", "Yellow Fungus", "Green Fungus", "Gavin The Wizard", "Adalwolf", "Meleer Militant", "Gunner Militant", "Grenader Militant", "Medic Militant", "Combatant Militant", "Brute Militant", "Viper", "Juggernaut"},
	Callback = function(v)
		table.insert(EnemyTargets, v)
	end
})

_G.KillTargets = false

Tab:AddToggle({
	Name = "AutoKill Targets",
	Default = false,
	Callback = function(v)
		_G.KillTargets = v
	end
})

Tab:AddButton({
	Name = "Clear EnemyTargets",
	Callback = function()
		EnemyTargets = {}
	end
})

spawn(function()
	while wait() do
		if _G.KillTargets then
			for i,v in pairs(game.Workspace:GetChildren()) do
				if table.find(EnemyTargets, v.Name) then
		            CannonDamage(v.Torso.Position) wait(1)
				end
			end
		end
	end
end)

local cooldownCounter = 0
local cooldownDuration = 1 -- Adjusted for 0.5-second break every 300 loops

-- Loop for Desert
spawn(function()
    while wait() do
        if _G.Desert then
            for i, v in pairs(game.Workspace:GetChildren()) do
                if table.find({"Mummy", "Fast Mummy", "Strong Mummy", "Sandstone", "Camel", "Carium"}, v.Name) then
                    if cooldownCounter == 0 then
                        CannonDamage(v.Torso.Position) wait(1)
                        cooldownCounter = cooldownDuration
                    else
                        cooldownCounter = cooldownCounter - 1
                    end
                end
            end
        end
    end
end)

-- Loop for Park
spawn(function()
    while wait() do
        if _G.Park then
            for i, v in pairs(game.Workspace:GetChildren()) do
                if v.Name:match("Robloxian") or v.Name:match("Rox") then
                    if cooldownCounter == 0 then
                        CannonDamage(v.Torso.Position) wait(1)
                        cooldownCounter = cooldownDuration
                    else
                        cooldownCounter = cooldownCounter - 1
                    end
                end
            end
        end
    end
end)

-- Loop for DarkAges
spawn(function()
    while wait() do
        if _G.DarkAges then
            for i, v in pairs(game.Workspace:GetChildren()) do
                if table.find({"Goblin","Orc","Buster Goblin","Skeleton","Adalwolf","Gavin The Wizard", "Red Fungus", "Blue Fungus", "Green Fungus", "Yellow Fungus"}, v.Name) then
                    if cooldownCounter == 0 then
                        CannonDamage(v.Torso.Position) wait(1)
                        cooldownCounter = cooldownDuration
                    else
                        cooldownCounter = cooldownCounter - 1
                    end
                end
            end
        end
    end
end)

local Tab2 = _G.Window:MakeTab({
	Name = "Gun Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local function B2(GunName)
	Tab2:AddButton({
		Name = GunName .. " Mod",
		Callback = function()
			GunMod(GunName)
		end
	})
end

B2("Pistol")
B2("Assault Rifle")
B2("Shotgun")
B2("Sniper Rifle")
B2("Blunder Buss")
B2("Battle Rifle")
B2("Revolver")
B2("Flamethrower")
B2("Auto Shotgun")
B2("Hand Cannon")
B2("Hunting Rifle")

Tab2:AddButton({
	Name = "Minigun Mod",
	Callback = function()
		local a = require(game.ReplicatedStorage.Modules.Tools.Gun.Settings.Minigun)
		a.WindUp = 0
		a.AmmoPerMag = 9999
		a.ReloadTime = 0.1
		a.HeadshotDamageMultiplier = 5
		a.MaxPierce = 50
	end
})


Tab2:AddLabel("NPC mods (coming soon)")
