-- Xylene – Minimal Working Version for Delta
-- Only essential features, fully functional.

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Library = Rayfield

-- Anti AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Sea Detection
local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea = game.PlaceId == 7449423635
if not First_Sea and not Second_Sea and not Third_Sea then game:Shutdown() end

local plr = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
_G.AutoLevel = false
_G.AutoNear = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.9

-- ==================== FUNCTIONS ====================

-- Auto Haki
local hakiCooldown = 0
local function AutoHaki()
    if tick() - hakiCooldown < 1.5 then return end
    if plr.Character and not plr.Character:FindFirstChild("HasBuso") then
        pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("Buso") end)
        hakiCooldown = tick()
    end
end

-- Equip Weapon
local function EquipTool(weaponType)
    if not plr.Character then return end
    for _, tool in pairs(plr.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == weaponType then
            plr.Character.Humanoid:EquipTool(tool)
            break
        end
    end
end

-- Attack
local function Attack()
    pcall(function()
        -- Simulate click
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
    end)
end

-- Tween
local function Tween(target)
    if not plr.Character then return end
    local distance = (target.Position - plr.Character.HumanoidRootPart.Position).Magnitude
    if distance < 5 then return end
    local tween = game:GetService("TweenService"):Create(
        plr.Character.HumanoidRootPart,
        TweenInfo.new(distance / 320, Enum.EasingStyle.Linear),
        {CFrame = target}
    )
    tween:Play()
    return tween
end

local function toTarget(target)
    local t = Tween(target)
    if t then t.Completed:Wait() end
end

-- Check Level (simplified)
local function CheckLevel()
    local Lv = plr.Data.Level.Value
    if First_Sea then
        if Lv <= 9 then return "Bandit", "BanditQuest1", 1, CFrame.new(1060,16,1547) end
        if Lv <= 14 then return "Monkey", "JungleQuest", 1, CFrame.new(-1601,36,153) end
        if Lv <= 29 then return "Gorilla", "JungleQuest", 2, CFrame.new(-1601,36,153) end
        if Lv <= 39 then return "Pirate", "BuggyQuest1", 1, CFrame.new(-1140,4,3827) end
        if Lv <= 59 then return "Brute", "BuggyQuest1", 2, CFrame.new(-1140,4,3827) end
        if Lv <= 74 then return "Desert Bandit", "DesertQuest", 1, CFrame.new(896,6,4390) end
        if Lv <= 89 then return "Desert Officer", "DesertQuest", 2, CFrame.new(896,6,4390) end
        if Lv <= 99 then return "Snow Bandit", "SnowQuest", 1, CFrame.new(1386,87,-1298) end
        if Lv <= 119 then return "Snowman", "SnowQuest", 2, CFrame.new(1386,87,-1298) end
        if Lv <= 149 then return "Chief Petty Officer", "MarineQuest2", 1, CFrame.new(-5035,28,4324) end
        if Lv <= 174 then return "Sky Bandit", "SkyQuest", 1, CFrame.new(-4842,717,-2623) end
        if Lv <= 189 then return "Dark Master", "SkyQuest", 2, CFrame.new(-4842,717,-2623) end
        if Lv <= 209 then return "Prisoner", "PrisonerQuest", 1, CFrame.new(5310,0,474) end
        if Lv <= 249 then return "Dangerous Prisoner", "PrisonerQuest", 2, CFrame.new(5310,0,474) end
        if Lv <= 274 then return "Toga Warrior", "ColosseumQuest", 1, CFrame.new(-1577,7,-2984) end
        if Lv <= 299 then return "Gladiator", "ColosseumQuest", 2, CFrame.new(-1577,7,-2984) end
        if Lv <= 324 then return "Military Soldier", "MagmaQuest", 1, CFrame.new(-5316,12,8517) end
        if Lv <= 374 then return "Military Spy", "MagmaQuest", 2, CFrame.new(-5316,12,8517) end
        if Lv <= 399 then return "Fishman Warrior", "FishmanQuest", 1, CFrame.new(61122,18,1569) end
        if Lv <= 449 then return "Fishman Commando", "FishmanQuest", 2, CFrame.new(61122,18,1569) end
        if Lv <= 474 then return "God's Guard", "SkyExp1Quest", 1, CFrame.new(-4721,845,-1953) end
        if Lv <= 524 then return "Shanda", "SkyExp1Quest", 2, CFrame.new(-7863,5545,-378) end
        if Lv <= 549 then return "Royal Squad", "SkyExp2Quest", 1, CFrame.new(-7903,5635,-1410) end
        if Lv <= 624 then return "Royal Soldier", "SkyExp2Quest", 2, CFrame.new(-7903,5635,-1410) end
        if Lv <= 649 then return "Galley Pirate", "FountainQuest", 1, CFrame.new(5258,38,4050) end
        return "Galley Captain", "FountainQuest", 2, CFrame.new(5258,38,4050)
    elseif Second_Sea then
        if Lv <= 724 then return "Raider", "Area1Quest", 1, CFrame.new(-427,72,1835) end
        if Lv <= 774 then return "Mercenary", "Area1Quest", 2, CFrame.new(-427,72,1835) end
        if Lv <= 799 then return "Swan Pirate", "Area2Quest", 1, CFrame.new(635,73,917) end
        if Lv <= 874 then return "Factory Staff", "Area2Quest", 2, CFrame.new(635,73,917) end
        if Lv <= 899 then return "Marine Lieutenant", "MarineQuest3", 1, CFrame.new(-2440,73,-3217) end
        if Lv <= 949 then return "Marine Captain", "MarineQuest3", 2, CFrame.new(-2440,73,-3217) end
        if Lv <= 974 then return "Zombie", "ZombieQuest", 1, CFrame.new(-5494,48,-794) end
        if Lv <= 999 then return "Vampire", "ZombieQuest", 2, CFrame.new(-5494,48,-794) end
        if Lv <= 1049 then return "Snow Trooper", "SnowMountainQuest", 1, CFrame.new(607,401,-5370) end
        if Lv <= 1099 then return "Winter Warrior", "SnowMountainQuest", 2, CFrame.new(607,401,-5370) end
        if Lv <= 1124 then return "Lab Subordinate", "IceSideQuest", 1, CFrame.new(-6061,15,-4902) end
        if Lv <= 1174 then return "Horned Warrior", "IceSideQuest", 2, CFrame.new(-6061,15,-4902) end
        if Lv <= 1199 then return "Magma Ninja", "FireSideQuest", 1, CFrame.new(-5429,15,-5297) end
        if Lv <= 1249 then return "Lava Pirate", "FireSideQuest", 2, CFrame.new(-5429,15,-5297) end
        if Lv <= 1274 then return "Ship Deckhand", "ShipQuest1", 1, CFrame.new(1040,125,32911) end
        if Lv <= 1299 then return "Ship Engineer", "ShipQuest1", 2, CFrame.new(1040,125,32911) end
        if Lv <= 1324 then return "Ship Steward", "ShipQuest2", 1, CFrame.new(971,125,33245) end
        if Lv <= 1349 then return "Ship Officer", "ShipQuest2", 2, CFrame.new(971,125,33245) end
        if Lv <= 1374 then return "Arctic Warrior", "FrostQuest", 1, CFrame.new(5668,28,-6484) end
        if Lv <= 1424 then return "Snow Lurker", "FrostQuest", 2, CFrame.new(5668,28,-6484) end
        if Lv <= 1449 then return "Sea Soldier", "ForgottenQuest", 1, CFrame.new(-3054,236,-10147) end
        return "Water Fighter", "ForgottenQuest", 2, CFrame.new(-3054,236,-10147)
    else
        if Lv <= 1524 then return "Pirate Millionaire", "PiratePortQuest", 1, CFrame.new(-289,43,5580) end
        if Lv <= 1574 then return "Pistol Billionaire", "PiratePortQuest", 2, CFrame.new(-289,43,5580) end
        if Lv <= 1599 then return "Dragon Crew Warrior", "AmazonQuest", 1, CFrame.new(5833,51,-1103) end
        if Lv <= 1624 then return "Dragon Crew Archer", "AmazonQuest", 2, CFrame.new(5833,51,-1103) end
        if Lv <= 1649 then return "Female Islander", "AmazonQuest2", 1, CFrame.new(5446,601,749) end
        if Lv <= 1699 then return "Giant Islander", "AmazonQuest2", 2, CFrame.new(5446,601,749) end
        if Lv <= 1724 then return "Marine Commodore", "MarineTreeIsland", 1, CFrame.new(2179,28,-6740) end
        if Lv <= 1774 then return "Marine Rear Admiral", "MarineTreeIsland", 2, CFrame.new(2179,28,-6740) end
        if Lv <= 1799 then return "Fishman Raider", "DeepForestIsland3", 1, CFrame.new(-10582,331,-8757) end
        if Lv <= 1824 then return "Fishman Captain", "DeepForestIsland3", 2, CFrame.new(-10582,331,-8757) end
        if Lv <= 1849 then return "Forest Pirate", "DeepForestIsland", 1, CFrame.new(-13232,332,-7626) end
        if Lv <= 1899 then return "Mythological Pirate", "DeepForestIsland", 2, CFrame.new(-13232,332,-7626) end
        if Lv <= 1924 then return "Jungle Pirate", "DeepForestIsland2", 1, CFrame.new(-12682,390,-9902) end
        if Lv <= 1974 then return "Musketeer Pirate", "DeepForestIsland2", 2, CFrame.new(-12682,390,-9902) end
        if Lv <= 1999 then return "Reborn Skeleton", "HauntedQuest1", 1, CFrame.new(-9480,142,5566) end
        if Lv <= 2024 then return "Living Zombie", "HauntedQuest1", 2, CFrame.new(-9480,142,5566) end
        if Lv <= 2049 then return "Demonic Soul", "HauntedQuest2", 1, CFrame.new(-9516,178,6078) end
        if Lv <= 2074 then return "Posessed Mummy", "HauntedQuest2", 2, CFrame.new(-9516,178,6078) end
        if Lv <= 2099 then return "Peanut Scout", "NutsIslandQuest", 1, CFrame.new(-2105,37,-10195) end
        if Lv <= 2124 then return "Peanut President", "NutsIslandQuest", 2, CFrame.new(-2105,37,-10195) end
        if Lv <= 2149 then return "Ice Cream Chef", "IceCreamIslandQuest", 1, CFrame.new(-819,64,-10967) end
        if Lv <= 2199 then return "Ice Cream Commander", "IceCreamIslandQuest", 2, CFrame.new(-819,64,-10967) end
        if Lv <= 2224 then return "Cookie Crafter", "CakeQuest1", 1, CFrame.new(-2022,36,-12030) end
        if Lv <= 2249 then return "Cake Guard", "CakeQuest1", 2, CFrame.new(-2022,36,-12030) end
        if Lv <= 2274 then return "Baking Staff", "CakeQuest2", 1, CFrame.new(-1928,37,-12840) end
        if Lv <= 2299 then return "Head Baker", "CakeQuest2", 2, CFrame.new(-1928,37,-12840) end
        if Lv <= 2324 then return "Cocoa Warrior", "ChocQuest1", 1, CFrame.new(231,23,-12200) end
        if Lv <= 2349 then return "Chocolate Bar Battler", "ChocQuest1", 2, CFrame.new(231,23,-12200) end
        if Lv <= 2374 then return "Sweet Thief", "ChocQuest2", 1, CFrame.new(151,23,-12774) end
        if Lv <= 2400 then return "Candy Rebel", "ChocQuest2", 2, CFrame.new(151,23,-12774) end
        if Lv <= 2424 then return "Candy Pirate", "CandyQuest1", 1, CFrame.new(-1149,13,-14445) end
        if Lv <= 2449 then return "Snow Demon", "CandyQuest1", 2, CFrame.new(-1149,13,-14445) end
        if Lv <= 2474 then return "Isle Outlaw", "TikiQuest1", 1, CFrame.new(-16549,55,-179) end
        if Lv <= 2524 then return "Island Boy", "TikiQuest1", 2, CFrame.new(-16549,55,-179) end
        return "Isle Champion", "TikiQuest2", 2, CFrame.new(-16542,55,1044)
    end
end

-- ==================== UI ====================

local Window = Library:CreateWindow({
    Name = "Xylene",
    LoadingTitle = "Xylene",
    LoadingSubtitle = "Blox Fruits Script",
    ConfigurationSaving = { Enabled = true, FolderName = "Xylene", FileName = "Settings" },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main")

MainTab:CreateSection("Farming")

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(v) _G.AutoLevel = v end
})

MainTab:CreateToggle({
    Name = "Auto Kill Near Mobs",
    CurrentValue = false,
    Callback = function(v) _G.AutoNear = v end
})

MainTab:CreateDropdown({
    Name = "Weapon Type",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = "Melee",
    Callback = function(v) _G.SelectWeapon = v end
})

MainTab:CreateDropdown({
    Name = "Attack Speed",
    Options = {"Normal", "Fast", "Very Fast"},
    CurrentOption = "Normal",
    Callback = function(v)
        if v == "Normal" then _G.Fast_Delay = 0.9
        elseif v == "Fast" then _G.Fast_Delay = 0.5
        else _G.Fast_Delay = 0.2 end
    end
})

MainTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, plr)
    end
})

Rayfield:Notify({
    Title = "Xylene",
    Content = "Loaded! Turn on Auto Farm Level.",
    Duration = 3
})

-- ==================== LOOPS ====================

-- Auto Farm Level Loop
spawn(function()
    while wait() do
        if _G.AutoLevel then
            pcall(function()
                local Ms, NameQuest, QuestLv, CFrameQ = CheckLevel()
                if not Ms then return end

                -- Get quest if needed
                if not plr.PlayerGui.Main.Quest.Visible or not string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text or "", Ms) then
                    replicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    toTarget(CFrameQ)
                    if (CFrameQ.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        replicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                else
                    -- Kill mobs
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == Ms then
                            repeat
                                wait(_G.Fast_Delay or 0.9)
                                AutoHaki()
                                EquipTool(_G.SelectWeapon or "Melee")
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CanCollide = false
                                Attack()
                            until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Quest.Visible
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Near Mobs
spawn(function()
    while wait() do
        if _G.AutoNear then
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 5000 then
                            repeat
                                wait(_G.Fast_Delay or 0.9)
                                AutoHaki()
                                EquipTool(_G.SelectWeapon or "Melee")
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                Attack()
                            until not _G.AutoNear or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

print("Xylene loaded successfully!")
