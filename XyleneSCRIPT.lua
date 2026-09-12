-- Xylene v1.3 – Ultimate Blox Fruits Hub
-- Merged from Quốc Khánh Hub v3.5 + Xylene PvP features
-- Features: SafeTween, Bring Mob AOE, Kitsune, Race V4, Leviathan, Webhook

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea = game.PlaceId == 7449423635
local InBloxFruits = First_Sea or Second_Sea or Third_Sea

-- ═══════════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════════

local Settings = {
    AimbotEnabled = false, AimbotMode = "Always On", AimbotTeamCheck = true,
    FOV = 100, ShowFOV = true, Smoothing = 5,
    ESPEnabled = false, ESPBox = true, ESPName = true, ESPHealth = true,
    ESPDistance = true, ESPTeamCheck = false
}

_G.AutoLevel = false
_G.AutoNear = false
_G.AutoBoss = false
_G.AutoHaki = false
_G.FruitSniper = false
_G.AutoGacha = false
_G.AutoMagnet = false
_G.AutoBuyInstinct = false
_G.AutoChest = false
_G.AutoStats = false
_G.AutoSkillZ = false
_G.AutoSkillX = false
_G.AutoSkillC = false
_G.AutoSkillV = false
_G.AutoCollectEmbers = false
_G.AutoPrayStatue = false
_G.AutoAwakenV4 = false
_G.AutoUseRaceSkill = false
_G.AutoMirageGear = false
_G.AutoLeviathan = false
_G.AutoSeaBeast = false
_G.AutoShipRaid = false
_G.InfiniteJump = false
_G.Noclip = false
_G.BringMob = true
_G.FastAttack = true
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.9
_G.SelectedBoss = "Bandit"
_G.SelectedMob = "Bandit"
_G.FruitRange = 5000
_G.BringMobDistance = 350
_G.TweenSpeed = 280
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.EnableWebhook = false
_G.WebhookURL = ""
_G.ChestsCollected = 0
_G.GachaCooldown = 60
_G.MagnetItemName = "MagnetToken"

-- Chest counter label reference (assigned later)
local ChestCountLabel = nil
local InfoLabels = {}

-- ═══════════════════════════════════════════════════════════
-- UTILITIES
-- ═══════════════════════════════════════════════════════════

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title, Text = text, Duration = duration or 3
        })
    end)
end

local function SendDiscordWebhook(title, description, color, fields)
    if not _G.EnableWebhook or _G.WebhookURL == "" or #_G.WebhookURL < 15 then return end
    task.spawn(function()
        pcall(function()
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if not req then return end
            local embed = {
                title = "Xylene | " .. title,
                description = description,
                color = color or 65535,
                fields = fields or {},
                footer = { text = "Xylene Hub • " .. os.date("%d/%m/%Y %H:%M:%S") }
            }
            req({
                Url = _G.WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    username = "Xylene Hub",
                    embeds = {embed}
                })
            })
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════
-- SAFE TWEEN SYSTEM (from QuocKhanh)
-- ═══════════════════════════════════════════════════════════

local currentTween = nil
local tweenDestination = nil

local function SetFlyAnchor(enable)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local existing = hrp:FindFirstChild("Xylene_FlyVelocity")
    if enable then
        if not existing then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "Xylene_FlyVelocity"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.zero
            bv.Parent = hrp
        else
            existing.Velocity = Vector3.zero
        end
    else
        if existing then existing:Destroy() end
    end
end

local function StopTween()
    if currentTween then
        pcall(function() currentTween:Cancel() end)
        currentTween = nil
        tweenDestination = nil
    end
    SetFlyAnchor(false)
end

local function SafeTween(targetCFrame, speedOverride)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local speed = speedOverride or _G.TweenSpeed
    local distance = (hrp.Position - targetCFrame.Position).Magnitude

    if distance <= 15 then
        hrp.CFrame = targetCFrame
        if currentTween then StopTween() end
        return
    end

    if tweenDestination and (tweenDestination.Position - targetCFrame.Position).Magnitude < 10 and currentTween then
        return currentTween
    end

    if currentTween then pcall(function() currentTween:Cancel() end) end

    tweenDestination = targetCFrame
    local duration = distance / speed
    currentTween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    currentTween:Play()
    currentTween.Completed:Connect(function()
        tweenDestination = nil
        currentTween = nil
    end)
    return currentTween
end

-- ═══════════════════════════════════════════════════════════
-- COMBAT HELPERS
-- ═══════════════════════════════════════════════════════════

local lastBuso = 0
local function AutoHaki()
    if tick() - lastBuso < 3 then return end
    lastBuso = tick()
    if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("HasBuso") then
        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso") end)
    end
end

local function EquipTool(weaponType)
    if not LocalPlayer.Character then return end
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == weaponType or tool:GetAttribute("WeaponType") == weaponType) then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            return tool
        end
    end
    -- Fallback: equip any tool
    local any = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if any then
        LocalPlayer.Character.Humanoid:EquipTool(any)
        return any
    end
end

local function Attack()
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
    end)
    if _G.FastAttack then
        pcall(function()
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
            if ReplicatedStorage.Modules and ReplicatedStorage.Modules:FindFirstChild("Net") then
                local regAttack = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")
                if regAttack then regAttack:FireServer(0) end
            end
        end)
    end
end

-- BRING MOB AOE (from QuocKhanh)
local function BringMobs(mobName, centerCFrame)
    if not _G.BringMob then return end
    pcall(function()
        local enemies = workspace:FindFirstChild("Enemies")
        if not enemies then return end
        for _, mob in ipairs(enemies:GetChildren()) do
            if (mob.Name == mobName or string.find(mob.Name, mobName)) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local hrp = mob.HumanoidRootPart
                if (hrp.Position - centerCFrame.Position).Magnitude <= _G.BringMobDistance then
                    hrp.Size = Vector3.new(60, 60, 60)
                    hrp.Transparency = 0.85
                    hrp.CanCollide = false
                    hrp.CFrame = centerCFrame
                    hrp.Velocity = Vector3.zero
                    mob.Humanoid.WalkSpeed = 0
                    mob.Humanoid.JumpPower = 0
                    if mob:FindFirstChild("Head") then mob.Head.CanCollide = false end
                end
            end
        end
    end)
end

-- SKILL SPAM
local function TriggerSkills()
    pcall(function()
        if _G.AutoSkillZ then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        end
        if _G.AutoSkillX then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        end
        if _G.AutoSkillC then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        end
        if _G.AutoSkillV then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════
-- QUEST DATA (3 SEAS)
-- ═══════════════════════════════════════════════════════════

local function CheckLevel()
    local Lv = LocalPlayer.Data.Level.Value
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

-- ═══════════════════════════════════════════════════════════
-- UI CREATION
-- ═══════════════════════════════════════════════════════════

local Window = Rayfield:CreateWindow({
    Name = "Xylene",
    LoadingTitle = "Xylene v1.3 Ultimate",
    LoadingSubtitle = "Blox Fruits + PvP",
    ConfigurationSaving = { Enabled = true, FolderName = "Xylene", FileName = "Config" },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main")
local BossTab = Window:CreateTab("Boss & Mob")
local EventsTab = Window:CreateTab("Events")
local SeaTab = Window:CreateTab("Sea & Race")
local PvPTab = Window:CreateTab("PvP")
local ESPTab = Window:CreateTab("ESP")
local TeleportTab = Window:CreateTab("Teleport")
local PerfTab = Window:CreateTab("Performance")
local InfoTab = Window:CreateTab("Info & Settings")

-- ═══════════════════════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════════════════════

MainTab:CreateSection("Farming")

if InBloxFruits then
    MainTab:CreateDropdown({ Name = "Weapon Type", Options = {"Melee", "Sword", "Blox Fruit", "Gun"},
        CurrentOption = "Melee", Callback = function(v) _G.SelectWeapon = v end })

    MainTab:CreateDropdown({ Name = "Attack Speed", Options = {"Normal", "Fast", "Very Fast"},
        CurrentOption = "Normal", Callback = function(v)
            if v == "Normal" then _G.Fast_Delay = 0.9
            elseif v == "Fast" then _G.Fast_Delay = 0.5
            else _G.Fast_Delay = 0.2 end
        end })

    MainTab:CreateToggle({ Name = "Auto Farm Level", CurrentValue = false,
        Callback = function(v) _G.AutoLevel = v; if not v then StopTween() end end })

    MainTab:CreateToggle({ Name = "Auto Kill Near Mobs", CurrentValue = false,
        Callback = function(v) _G.AutoNear = v; if not v then StopTween() end end })

    MainTab:CreateToggle({ Name = "Auto Haki (Buso)", CurrentValue = false,
        Callback = function(v) _G.AutoHaki = v end })

    MainTab:CreateToggle({ Name = "Fast Attack v4", CurrentValue = true,
        Callback = function(v) _G.FastAttack = v end })

    MainTab:CreateToggle({ Name = "Bring Mob AOE (350 studs)", CurrentValue = true,
        Callback = function(v) _G.BringMob = v end })

    MainTab:CreateSlider({ Name = "Bring Mob Radius", Range = {100, 500}, Increment = 25,
        CurrentValue = 350, Callback = function(v) _G.BringMobDistance = v end })

    MainTab:CreateSection("Auto Stats")

    MainTab:CreateToggle({ Name = "Auto Stats", CurrentValue = false,
        Callback = function(v) _G.AutoStats = v end })

    MainTab:CreateSlider({ Name = "Points per Cycle", Range = {1, 10}, Increment = 1,
        CurrentValue = 3, Callback = function(v) _G.StatPointsChunk = v end })
end

-- ═══════════════════════════════════════════════════════════
-- BOSS & MOB TAB
-- ═══════════════════════════════════════════════════════════

if InBloxFruits then
    local mobList = {"Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Snow Bandit","Snowman","Chief Petty Officer","Military Soldier","Military Spy","Fishman Warrior","God's Guard","Raider","Mercenary","Swan Pirate"}

    BossTab:CreateSection("Selected Mob Farming")

    BossTab:CreateDropdown({ Name = "Select Mob", Options = mobList, CurrentOption = mobList[1],
        Callback = function(v) _G.SelectedMob = v end })

    BossTab:CreateToggle({ Name = "Auto Farm Selected Mob", CurrentValue = false,
        Callback = function(v) _G.AutoFarmSelectedMob = v; if not v then StopTween() end end })

    BossTab:CreateSection("Boss Farming")

    local bossList = {}
    if First_Sea then
        bossList = {"The Gorilla King","Bobby","Yeti","Mob Leader","Saber Expert","Vice Admiral","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg"}
    elseif Second_Sea then
        bossList = {"Diamond","Jeremy","Fajita","Don Swan","Cursed Captain","Darkbeard","Order","Smoke Admiral","Awakened Ice Admiral","Tide Keeper"}
    elseif Third_Sea then
        bossList = {"Stone","Island Empress","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","rip_indra True Form","Longma","Soul Reaper"}
    end

    BossTab:CreateDropdown({ Name = "Select Boss", Options = bossList, CurrentOption = bossList[1],
        Callback = function(v) _G.SelectedBoss = v end })

    BossTab:CreateToggle({ Name = "Auto Kill Boss", CurrentValue = false,
        Callback = function(v) _G.AutoBoss = v; if not v then StopTween() end end })
end

-- ═══════════════════════════════════════════════════════════
-- EVENTS TAB (Kitsune, Gacha, Magnet)
-- ═══════════════════════════════════════════════════════════

EventsTab:CreateSection("Fruit & Gacha")

if InBloxFruits then
    EventsTab:CreateToggle({ Name = "Fruit Sniper (Auto Collect)", CurrentValue = false,
        Callback = function(v) _G.FruitSniper = v end })

    EventsTab:CreateSlider({ Name = "Fruit Range", Range = {100, 10000}, Increment = 100,
        CurrentValue = 5000, Callback = function(v) _G.FruitRange = v end })

    EventsTab:CreateToggle({ Name = "Auto Store Fruit", CurrentValue = false,
        Callback = function(v) _G.AutoStoreFruit = v end })

    EventsTab:CreateToggle({ Name = "Auto Gacha (Random Fruit)", CurrentValue = false,
        Callback = function(v) _G.AutoGacha = v end })

    EventsTab:CreateSlider({ Name = "Gacha Cooldown (sec)", Range = {30, 600}, Increment = 10,
        CurrentValue = 60, Callback = function(v) _G.GachaCooldown = v end })

    EventsTab:CreateSection("Magnet Event")

    EventsTab:CreateInput({ Name = "Magnet Item Name", PlaceholderText = "MagnetToken",
        CurrentValue = "MagnetToken", RemoveTextAfterFocusLost = false,
        Callback = function(v) _G.MagnetItemName = v end })

    EventsTab:CreateToggle({ Name = "Auto Farm Magnet Event", CurrentValue = false,
        Callback = function(v) _G.AutoMagnet = v end })

    EventsTab:CreateSection("Kitsune Island Event")

    EventsTab:CreateToggle({ Name = "Auto Collect Blue Embers", CurrentValue = false,
        Callback = function(v) _G.AutoCollectEmbers = v end })

    EventsTab:CreateToggle({ Name = "Auto Pray Kitsune Statue", CurrentValue = false,
        Callback = function(v) _G.AutoPrayStatue = v end })

    EventsTab:CreateButton({ Name = "Touch Kitsune Statue", Callback = function()
        pcall(function()
            local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
            local touch = Net and Net:FindFirstChild("RE/TouchKitsuneStatue")
            if touch then touch:FireServer() Notify("Xylene", "Touched Kitsune Statue") end
        end)
    end })

    EventsTab:CreateSection("Chests")

    ChestCountLabel = EventsTab:CreateLabel("Chests Collected: 0")

    EventsTab:CreateToggle({ Name = "Auto Chest", CurrentValue = false,
        Callback = function(v) _G.AutoChest = v; if not v then StopTween() end end })

    EventsTab:CreateSlider({ Name = "Chest Tween Speed", Range = {150, 400}, Increment = 10,
        CurrentValue = 280, Callback = function(v) _G.TweenSpeed = v end })
end

-- ═══════════════════════════════════════════════════════════
-- SEA & RACE TAB
-- ═══════════════════════════════════════════════════════════

if InBloxFruits then
    SeaTab:CreateSection("Race V4")

    SeaTab:CreateToggle({ Name = "Auto Awaken Race V4", CurrentValue = false,
        Callback = function(v) _G.AutoAwakenV4 = v end })

    SeaTab:CreateToggle({ Name = "Auto Use Race Skill", CurrentValue = false,
        Callback = function(v) _G.AutoUseRaceSkill = v end })

    SeaTab:CreateToggle({ Name = "Auto Find Mirage Blue Gear", CurrentValue = false,
        Callback = function(v) _G.AutoMirageGear = v end })

    SeaTab:CreateButton({ Name = "Pull Temple Lever", Callback = function()
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local temple = remotes and remotes:FindFirstChild("Temple")
            if temple then temple:FireServer("PullLever") Notify("Xylene", "Lever pulled") end
        end)
    end })

    SeaTab:CreateSection("Sea Events")

    SeaTab:CreateToggle({ Name = "Auto Leviathan", CurrentValue = false,
        Callback = function(v) _G.AutoLeviathan = v end })

    SeaTab:CreateToggle({ Name = "Auto Sea Beast", CurrentValue = false,
        Callback = function(v) _G.AutoSeaBeast = v end })

    SeaTab:CreateToggle({ Name = "Auto Ship Raid", CurrentValue = false,
        Callback = function(v) _G.AutoShipRaid = v end })

    SeaTab:CreateSection("Auto Buy Instinct")

    SeaTab:CreateToggle({ Name = "Auto Buy Instinct (First Sea)", CurrentValue = false,
        Callback = function(v) _G.AutoBuyInstinct = v end })
end

-- ═══════════════════════════════════════════════════════════
-- PVP TAB
-- ═══════════════════════════════════════════════════════════

PvPTab:CreateSection("Aimbot")

PvPTab:CreateToggle({ Name = "Enable Aimbot", CurrentValue = false,
    Callback = function(v) Settings.AimbotEnabled = v end })

PvPTab:CreateDropdown({ Name = "Activation", Options = {"Always On", "Right Click (MB2)"},
    CurrentOption = "Always On", Callback = function(v) Settings.AimbotMode = v end })

PvPTab:CreateToggle({ Name = "Team Check", CurrentValue = true,
    Callback = function(v) Settings.AimbotTeamCheck = v end })

PvPTab:CreateSlider({ Name = "FOV Size", Range = {20, 500}, Increment = 5,
    CurrentValue = 100, Callback = function(v) Settings.FOV = v end })

PvPTab:CreateToggle({ Name = "Show FOV Circle", CurrentValue = true,
    Callback = function(v) Settings.ShowFOV = v end })

PvPTab:CreateSlider({ Name = "Smoothing", Range = {2, 20}, Increment = 1,
    CurrentValue = 5, Callback = function(v) Settings.Smoothing = v end })

-- ═══════════════════════════════════════════════════════════
-- ESP TAB
-- ═══════════════════════════════════════════════════════════

ESPTab:CreateSection("ESP Settings")

ESPTab:CreateToggle({ Name = "Enable ESP", CurrentValue = false,
    Callback = function(v) Settings.ESPEnabled = v end })

ESPTab:CreateToggle({ Name = "ESP Box", CurrentValue = true,
    Callback = function(v) Settings.ESPBox = v end })

ESPTab:CreateToggle({ Name = "ESP Name", CurrentValue = true,
    Callback = function(v) Settings.ESPName = v end })

ESPTab:CreateToggle({ Name = "ESP Health Bar", CurrentValue = true,
    Callback = function(v) Settings.ESPHealth = v end })

ESPTab:CreateToggle({ Name = "ESP Distance", CurrentValue = true,
    Callback = function(v) Settings.ESPDistance = v end })

ESPTab:CreateToggle({ Name = "ESP Team Check", CurrentValue = false,
    Callback = function(v) Settings.ESPTeamCheck = v end })

-- ═══════════════════════════════════════════════════════════
-- TELEPORT TAB
-- ═══════════════════════════════════════════════════════════

local islandCoords = {}
if First_Sea then
    islandCoords = {
        ["Windmill"] = CFrame.new(979, 16, 1429),
        ["Marine"] = CFrame.new(-2566, 6, 2045),
        ["Middle Town"] = CFrame.new(-690, 15, 1582),
        ["Jungle"] = CFrame.new(-1612, 36, 149),
        ["Pirate Village"] = CFrame.new(-1181, 4, 3803),
        ["Desert"] = CFrame.new(944, 20, 4373),
        ["Snow Island"] = CFrame.new(1347, 104, -1319),
        ["Marineford"] = CFrame.new(-4914, 50, 4281),
        ["Colosseum"] = CFrame.new(-1427, 7, -2792),
        ["Prison"] = CFrame.new(4875, 5, 734),
        ["Magma Village"] = CFrame.new(-5247, 12, 8504),
        ["Fountain City"] = CFrame.new(5127, 59, 4105),
        ["Temple of Time"] = CFrame.new(28282, 14896, 102),
        ["Kitsune Island"] = CFrame.new(-22123, 22, -12345)
    }
elseif Second_Sea then
    islandCoords = {
        ["Cafe"] = CFrame.new(-380, 77, 255),
        ["First Spot"] = CFrame.new(-11, 29, 2771),
        ["Dark Area"] = CFrame.new(3780, 22, -3498),
        ["Green Zone"] = CFrame.new(-2448, 73, -3210),
        ["Factory"] = CFrame.new(424, 211, -427),
        ["Zombie Island"] = CFrame.new(-5622, 492, -781),
        ["Punk Hazard"] = CFrame.new(-6127, 15, -5040),
        ["Cursed Ship"] = CFrame.new(923, 125, 32885),
        ["Ice Castle"] = CFrame.new(6148, 294, -6741),
        ["Forgotten Island"] = CFrame.new(-3032, 317, -10075)
    }
elseif Third_Sea then
    islandCoords = {
        ["Mansion"] = CFrame.new(-12468, 375, -7554),
        ["Port Town"] = CFrame.new(-290, 6, 5343),
        ["Great Tree"] = CFrame.new(2681, 1682, -7190),
        ["Castle on the Sea"] = CFrame.new(-5075, 314, -3150),
        ["Hydra Island"] = CFrame.new(5753, 610, -282),
        ["Floating Turtle"] = CFrame.new(-13274, 531, -7579),
        ["Haunted Castle"] = CFrame.new(-9515, 164, 5786),
        ["Ice Cream Island"] = CFrame.new(-902, 79, -10988),
        ["Cake Island"] = CFrame.new(-1884, 19, -11666),
        ["Cocoa Island"] = CFrame.new(87, 73, -12319),
        ["Tiki Outpost"] = CFrame.new(-16542, 55, 1044)
    }
end

if InBloxFruits then
    local islandList = {}
    for name, _ in pairs(islandCoords) do table.insert(islandList, name) end

    TeleportTab:CreateSection("Island Teleports")
    TeleportTab:CreateDropdown({ Name = "Select Island", Options = islandList, CurrentOption = islandList[1],
        Callback = function(v) _G.SelectIsland = v end })

    TeleportTab:CreateButton({ Name = "Teleport (Instant)", Callback = function()
        local target = islandCoords[_G.SelectIsland]
        if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target
            Notify("Xylene", "Teleported to " .. tostring(_G.SelectIsland))
        end
    end })

    TeleportTab:CreateButton({ Name = "Teleport (SafeTween)", Callback = function()
        local target = islandCoords[_G.SelectIsland]
        if target then SafeTween(target) end
    end })

    TeleportTab:CreateButton({ Name = "Stop Tween", Callback = function()
        StopTween() Notify("Xylene", "Tween stopped")
    end })
end

-- ═══════════════════════════════════════════════════════════
-- PERFORMANCE TAB
-- ═══════════════════════════════════════════════════════════

PerfTab:CreateSection("Graphics")

PerfTab:CreateButton({ Name = "Enable FPS Boost", Callback = function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 2
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
    end
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.SmoothPlastic
            part.Reflectance = 0
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        elseif part:IsA("ParticleEmitter") or part:IsA("Fire") or part:IsA("Smoke") then
            part.Enabled = false
        end
    end
    Notify("Xylene", "FPS Boost activated!")
end })

PerfTab:CreateSection("Movement")

PerfTab:CreateToggle({ Name = "Noclip", CurrentValue = false,
    Callback = function(v) _G.Noclip = v end })

PerfTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false,
    Callback = function(v) _G.InfiniteJump = v end })

PerfTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 200}, Increment = 1,
    CurrentValue = 16, Callback = function(v)
        _G.WalkSpeed = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end })

PerfTab:CreateSlider({ Name = "JumpPower", Range = {50, 300}, Increment = 5,
    CurrentValue = 50, Callback = function(v)
        _G.JumpPower = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v
        end
    end })

-- ═══════════════════════════════════════════════════════════
-- INFO & SETTINGS TAB
-- ═══════════════════════════════════════════════════════════

InfoTab:CreateSection("Player Info")

local executorName = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Unknown"
local seaName = First_Sea and "First Sea" or Second_Sea and "Second Sea" or Third_Sea and "Third Sea" or "Not in Blox Fruits"

InfoLabels.executor = InfoTab:CreateLabel("Executor: " .. tostring(executorName))
InfoLabels.sea = InfoTab:CreateLabel("Sea: " .. seaName)
InfoLabels.player = InfoTab:CreateLabel("Player: " .. LocalPlayer.Name)
InfoLabels.level = InfoTab:CreateLabel("Level: ?")
InfoLabels.beli = InfoTab:CreateLabel("Beli: ?")
InfoLabels.fragments = InfoTab:CreateLabel("Fragments: ?")

InfoTab:CreateSection("Discord Webhook")

InfoTab:CreateInput({ Name = "Webhook URL", PlaceholderText = "Paste Discord webhook...",
    CurrentValue = "", RemoveTextAfterFocusLost = false,
    Callback = function(v)
        _G.WebhookURL = string.gsub(v, "%s+", "")
        if #_G.WebhookURL > 15 then
            _G.EnableWebhook = true
            Notify("Xylene", "Webhook saved!")
        end
    end })

InfoTab:CreateToggle({ Name = "Enable Webhook Notifications", CurrentValue = false,
    Callback = function(v) _G.EnableWebhook = v end })

InfoTab:CreateButton({ Name = "Test Webhook", Callback = function()
    if _G.WebhookURL == "" then Notify("Xylene", "No webhook set!") return end
    SendDiscordWebhook("Test", "Xylene webhook connected!", 65535, {
        {name = "Player", value = LocalPlayer.Name, inline = true},
        {name = "Sea", value = seaName, inline = true}
    })
    Notify("Xylene", "Test webhook sent!")
end })

InfoTab:CreateSection("Utility")

InfoTab:CreateButton({ Name = "Rejoin Server", Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end })

InfoTab:CreateButton({ Name = "Server Hop", Callback = function()
    pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local data = HttpService:JSONDecode(game:HttpGet(url))
        for _, s in ipairs(data.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                break
            end
        end
    end)
end })

InfoTab:CreateButton({ Name = "Reset Character", Callback = function()
    if LocalPlayer.Character then LocalPlayer.Character:BreakJoints() end
end })

InfoTab:CreateButton({ Name = "Redeem All Codes", Callback = function()
    local codes = {"SUB2GAMERROBOT","FUDD10","BIGNEWS","STAWWK","GAMERROBOT1","Sub2CaptainMaui","Sub2UncleKizaru","Sub2Daigrock","Axiore","bluxxy","TantaiGaming","Magicbus","JCWK","RokCandy","UPD14","KITTGAMING","Sub2Fer999","Enyu_is_Pro","GAMERROBOT_YT","HAPPY","sryforthat","Dragons","DEVSCOOKING","fudd10_v2","SUPER","NOOB2PRO","GGloves","MAGIC","Tantai","Enyu","BloxFruits"}
    for _, c in pairs(codes) do
        pcall(function() ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end)
        task.wait(0.2)
    end
    Notify("Xylene", "Redeemed " .. #codes .. " codes")
end })

-- ═══════════════════════════════════════════════════════════
-- FOV CIRCLE + WALLCHECK + AIMBOT + ESP
-- ═══════════════════════════════════════════════════════════

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 60
FOVCircle.Radius = Settings.FOV
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Visible = false

RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    FOVCircle.Position = mousePos
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Visible = Settings.ShowFOV and Settings.AimbotEnabled
end)

local function IsVisible(targetPart)
    if not targetPart then return false end
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    local char = LocalPlayer.Character
    rayParams.FilterDescendantsInstances = char and {char, Camera} or {Camera}
    rayParams.IgnoreWater = true
    local result = workspace:Raycast(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position), rayParams)
    if result then return result.Instance:IsDescendantOf(targetPart.Parent) end
    return true
end

local function GetClosestInFOV()
    local closest, shortest = nil, Settings.FOV
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local passTeam = true
                if Settings.AimbotTeamCheck and player.Team and LocalPlayer.Team then
                    passTeam = (player.Team ~= LocalPlayer.Team)
                end
                if passTeam then
                    local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local dist = (mousePos - Vector2.new(pos.X, pos.Y)).Magnitude
                        if dist < shortest then shortest = dist; closest = player end
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Settings.AimbotEnabled then
        local shouldAim = (Settings.AimbotMode == "Always On") or
            (Settings.AimbotMode == "Right Click (MB2)" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))
        if shouldAim then
            local target = GetClosestInFOV()
            if target and target.Character and target.Character:FindFirstChild("Head") then
                local screenPos = Camera:WorldToViewportPoint(target.Character.Head.Position)
                local mousePos = UserInputService:GetMouseLocation()
                pcall(function()
                    mousemoverel((screenPos.X - mousePos.X) / Settings.Smoothing, (screenPos.Y - mousePos.Y) / Settings.Smoothing)
                end)
            end
        end
    end
end)

-- ESP
local espCache = {}
local function CreateESP(player)
    espCache[player] = {
        Box = Drawing.new("Square"),
        HealthBarBg = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        DistanceText = Drawing.new("Text")
    }
    for _, d in pairs(espCache[player]) do d.Visible = false end
    espCache[player].Box.Thickness = 1
    espCache[player].Box.Filled = false
    espCache[player].HealthBarBg.Filled = true
    espCache[player].HealthBarBg.Color = Color3.fromRGB(0, 0, 0)
    espCache[player].HealthBar.Filled = true
    espCache[player].Name.Size = 14
    espCache[player].Name.Center = true
    espCache[player].Name.Outline = true
    espCache[player].Name.Color = Color3.fromRGB(255, 255, 255)
    espCache[player].DistanceText.Size = 13
    espCache[player].DistanceText.Center = true
    espCache[player].DistanceText.Outline = true
    espCache[player].DistanceText.Color = Color3.fromRGB(200, 200, 200)

    player.AncestryChanged:Connect(function(_, parent)
        if not parent then
            for _, d in pairs(espCache[player]) do d:Remove() end
            espCache[player] = nil
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreateESP(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then CreateESP(p) end end)

RunService.RenderStepped:Connect(function()
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for player, d in pairs(espCache) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local head = char and char:FindFirstChild("Head")
        if Settings.ESPEnabled and char and root and hum and head and hum.Health > 0 then
            local show = true
            if Settings.ESPTeamCheck and player.Team and LocalPlayer.Team then
                show = (player.Team == LocalPlayer.Team)
            end
            if show then
                local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local visible = IsVisible(head)
                    local color = visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                    local size = Vector2.new(2000 / pos.Z, 3000 / pos.Z)
                    local boxPos = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y / 2)

                    if Settings.ESPBox then
                        d.Box.Size = size d.Box.Position = boxPos d.Box.Color = color d.Box.Visible = true
                    else d.Box.Visible = false end

                    if Settings.ESPHealth then
                        local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        local barH = size.Y * hp
                        d.HealthBarBg.Size = Vector2.new(3, size.Y)
                        d.HealthBarBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
                        d.HealthBarBg.Visible = true
                        d.HealthBar.Size = Vector2.new(1, barH)
                        d.HealthBar.Position = Vector2.new(boxPos.X - 5, boxPos.Y + (size.Y - barH))
                        d.HealthBar.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
                        d.HealthBar.Visible = true
                    else
                        d.HealthBarBg.Visible = false d.HealthBar.Visible = false
                    end

                    if Settings.ESPName then
                        d.Name.Text = player.Name
                        d.Name.Position = Vector2.new(pos.X, boxPos.Y - 18)
                        d.Name.Visible = true
                    else d.Name.Visible = false end

                    if Settings.ESPDistance and localRoot then
                        local dist = math.floor((root.Position - localRoot.Position).Magnitude)
                        d.DistanceText.Text = "[" .. dist .. " studs]"
                        d.DistanceText.Position = Vector2.new(pos.X, boxPos.Y + size.Y + 2)
                        d.DistanceText.Visible = true
                    else d.DistanceText.Visible = false end
                else
                    for _, x in pairs(d) do x.Visible = false end
                end
            else
                for _, x in pairs(d) do x.Visible = false end
            end
        else
            for _, x in pairs(d) do x.Visible = false end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- FARMING LOOPS
-- ═══════════════════════════════════════════════════════════

if InBloxFruits then
    -- Auto Farm Level
    task.spawn(function()
        while wait(0.05) do
            if _G.AutoLevel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local Ms, NameQuest, QuestLv, CFrameQ = CheckLevel()
                    if not Ms then return end
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()

                    local hasQuest = LocalPlayer.PlayerGui.Main.Quest.Visible and
                        string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text or "", Ms)

                    if not hasQuest then
                        SetFlyAnchor(false)
                        local dist = (hrp.Position - CFrameQ.Position).Magnitude
                        if dist > 25 then SafeTween(CFrameQ) else
                            StopTween()
                            hrp.CFrame = CFrameQ
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                            task.wait(0.4)
                        end
                    else
                        local enemies = workspace:FindFirstChild("Enemies")
                        local target = nil
                        if enemies then
                            for _, v in ipairs(enemies:GetChildren()) do
                                if (v.Name == Ms or string.find(v.Name, Ms)) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    target = v break
                                end
                            end
                        end
                        if target then
                            local mobHrp = target.HumanoidRootPart
                            local dist = (hrp.Position - mobHrp.Position).Magnitude
                            local targetPos = CFrame.new(mobHrp.Position + Vector3.new(0, 30, 0), mobHrp.Position)
                            if dist > 40 then
                                SetFlyAnchor(false)
                                SafeTween(targetPos)
                            else
                                StopTween()
                                SetFlyAnchor(true)
                                hrp.CFrame = targetPos
                                hrp.Velocity = Vector3.zero
                                BringMobs(Ms, mobHrp.CFrame)
                                EquipTool(_G.SelectWeapon or "Melee")
                                Attack()
                                TriggerSkills()
                            end
                        else
                            SetFlyAnchor(false)
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Near
    task.spawn(function()
        while wait(0.05) do
            if _G.AutoNear and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            if dist <= 5000 then
                                local targetPos = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 30, 0), v.HumanoidRootPart.Position)
                                if dist > 40 then SetFlyAnchor(false) SafeTween(targetPos) else
                                    StopTween()
                                    SetFlyAnchor(true)
                                    hrp.CFrame = targetPos
                                    BringMobs(v.Name, v.HumanoidRootPart.CFrame)
                                    EquipTool(_G.SelectWeapon or "Melee")
                                    Attack()
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Boss
    task.spawn(function()
        while wait(0.1) do
            if _G.AutoBoss and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == _G.SelectedBoss and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            local targetPos = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 25, 0), v.HumanoidRootPart.Position)
                            if dist > 40 then SetFlyAnchor(false) SafeTween(targetPos) else
                                StopTween()
                                SetFlyAnchor(true)
                                hrp.CFrame = targetPos
                                v.HumanoidRootPart.CanCollide = false
                                EquipTool(_G.SelectWeapon or "Melee")
                                Attack()
                                TriggerSkills()
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Farm Selected Mob
    task.spawn(function()
        while wait(0.1) do
            if _G.AutoFarmSelectedMob and not _G.AutoLevel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if string.find(v.Name, _G.SelectedMob) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            local targetPos = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 30, 0), v.HumanoidRootPart.Position)
                            if dist > 40 then SetFlyAnchor(false) SafeTween(targetPos) else
                                StopTween()
                                SetFlyAnchor(true)
                                hrp.CFrame = targetPos
                                BringMobs(_G.SelectedMob, v.HumanoidRootPart.CFrame)
                                EquipTool(_G.SelectWeapon or "Melee")
                                Attack()
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Chest
    task.spawn(function()
        while wait(0.4) do
            if _G.AutoChest and not _G.AutoLevel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local nearest, shortest = nil, math.huge
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and string.find(obj.Name, "Chest") and obj:FindFirstChild("TouchInterest") then
                            local d = (hrp.Position - obj.Position).Magnitude
                            if d < shortest then shortest = d; nearest = obj end
                        end
                    end
                    if nearest then
                        SafeTween(nearest.CFrame * CFrame.new(0, 2, 0))
                        if (hrp.Position - nearest.Position).Magnitude <= 12 then
                            firetouchinterest(hrp, nearest, 0)
                            firetouchinterest(hrp, nearest, 1)
                            _G.ChestsCollected = _G.ChestsCollected + 1
                            if ChestCountLabel then
                                ChestCountLabel:Set("Chests Collected: " .. _G.ChestsCollected)
                            end
                            task.wait(0.25)
                        end
                    end
                end)
            end
        end
    end)

    -- Fruit Sniper + Auto Store
    task.spawn(function()
        while wait(1) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    if _G.FruitSniper then
                        for _, obj in ipairs(workspace:GetChildren()) do
                            if string.find(obj.Name, "Fruit") then
                                local handle = obj:FindFirstChild("Handle") or (obj:IsA("BasePart") and obj)
                                if handle then
                                    SafeTween(handle.CFrame * CFrame.new(0, 2, 0), 350)
                                    if (hrp.Position - handle.Position).Magnitude <= 10 then
                                        firetouchinterest(hrp, handle, 0)
                                        firetouchinterest(hrp, handle, 1)
                                        Notify("Xylene", "Collected: " .. obj.Name)
                                        SendDiscordWebhook("Fruit Collected", obj.Name, 16753920, {
                                            {name = "Fruit", value = obj.Name, inline = true}
                                        })
                                        task.wait(0.3)
                                    end
                                end
                            end
                        end
                    end
                    if _G.AutoStoreFruit then
                        for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                            if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool)
                                Notify("Xylene", "Stored: " .. tool.Name)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Gacha
    task.spawn(function()
        while wait(5) do
            if _G.AutoGacha then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "BuyFruit") end)
                wait(_G.GachaCooldown or 60)
            end
        end
    end)

    -- Magnet Event
    task.spawn(function()
        while wait(0.5) do
            if _G.AutoMagnet and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local itemName = _G.MagnetItemName or "MagnetToken"
                    for _, item in ipairs(workspace:GetChildren()) do
                        if item.Name:match(itemName) or item.Name:match("MagnetToken") or item.Name:match("EventItem") then
                            local part = item:IsA("BasePart") and item or item:FindFirstChild("Handle")
                            if part then SafeTween(part.CFrame) task.wait(0.3) end
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Buy Instinct
    task.spawn(function()
        while wait(5) do
            if _G.AutoBuyInstinct then
                pcall(function()
                    local data = LocalPlayer:FindFirstChild("Data")
                    local level = data and data:FindFirstChild("Level") and data.Level.Value or 0
                    local beli = data and data:FindFirstChild("Beli") and data.Beli.Value or 0
                    if level >= 300 and beli >= 750000 then
                        if not LocalPlayer.Character:FindFirstChild("Instinct") then
                            SafeTween(CFrame.new(-5225, 432, -2280))
                            wait(1)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", "Observation")
                            Notify("Xylene", "Instinct purchased!", 5)
                            _G.AutoBuyInstinct = false
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Stats
    task.spawn(function()
        while wait(1.5) do
            if _G.AutoStats then
                pcall(function()
                    local points = LocalPlayer.Data:FindFirstChild("Points") and LocalPlayer.Data.Points.Value or 0
                    if points > 0 then
                        local chunk = math.min(points, _G.StatPointsChunk or 3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", chunk)
                        task.wait(0.1)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", chunk)
                    end
                end)
            end
        end
    end)

    -- Auto Haki
    task.spawn(function()
        while wait(3) do
            if _G.AutoHaki then pcall(AutoHaki) end
        end
    end)

    -- Kitsune Ember + Pray
    task.spawn(function()
        while wait(0.3) do
            if _G.AutoCollectEmbers then
                pcall(function()
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
                    local collect = Net and Net:FindFirstChild("RE/CollectBlueEmber")
                    for _, obj in ipairs(workspace:GetChildren()) do
                        if string.find(obj.Name, "Ember") or string.find(obj.Name, "BlueEmber") then
                            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildOfClass("BasePart")
                            if part then
                                if collect then collect:FireServer(part) end
                                SafeTween(part.CFrame, 350)
                                task.wait(0.2)
                            end
                        end
                    end
                end)
            end
            if _G.AutoPrayStatue then
                pcall(function()
                    local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
                    local pray = Net and Net:FindFirstChild("RF/KitsuneStatuePray")
                    if pray then pray:InvokeServer() end
                end)
            end
        end
    end)

    -- Race V4 + Mirage
    task.spawn(function()
        while wait(1) do
            pcall(function()
                local Events = ReplicatedStorage:FindFirstChild("Events")
                if _G.AutoAwakenV4 and Events then
                    local act = Events:FindFirstChild("ActivateRaceV4")
                    if act then act:FireServer() end
                end
                if _G.AutoUseRaceSkill and Events then
                    local use = Events:FindFirstChild("UsedRaceSkill")
                    if use then use:FireServer() end
                end
                if _G.AutoMirageGear then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj.Name == "Gear" or string.find(obj.Name, "MirageGear") then
                            SafeTween(obj.CFrame, 350)
                            Notify("Xylene", "Mirage Gear found!")
                            SendDiscordWebhook("Mirage Gear", "Blue Gear found!", 3447003, {})
                            break
                        end
                    end
                end
            end)
        end
    end)

    -- Sea Events (Leviathan, Sea Beast, Ship)
    task.spawn(function()
        while wait(0.5) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    if _G.AutoLeviathan then
                        local seaBeasts = workspace:FindFirstChild("SeaBeasts")
                        if seaBeasts then
                            for _, beast in ipairs(seaBeasts:GetChildren()) do
                                if string.find(beast.Name, "Leviathan") and beast:FindFirstChild("HumanoidRootPart") then
                                    SafeTween(beast.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    EquipTool(_G.SelectWeapon or "Melee")
                                    Attack()
                                end
                            end
                        end
                    end
                    if _G.AutoSeaBeast then
                        local sb = workspace:FindFirstChild("SeaBeasts") or workspace:FindFirstChild("Enemies")
                        if sb then
                            for _, beast in ipairs(sb:GetChildren()) do
                                if string.find(beast.Name, "SeaBeast") and beast:FindFirstChild("HumanoidRootPart") then
                                    SafeTween(beast.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0))
                                    EquipTool(_G.SelectWeapon or "Melee")
                                    Attack()
                                end
                            end
                        end
                    end
                    if _G.AutoShipRaid then
                        local boats = workspace:FindFirstChild("Boats") or workspace:FindFirstChild("Enemies")
                        if boats then
                            for _, boat in ipairs(boats:GetChildren()) do
                                if string.find(boat.Name, "Brigade") or string.find(boat.Name, "Ship") then
                                    local boatHrp = boat:FindFirstChild("HumanoidRootPart") or boat:FindFirstChildOfClass("BasePart")
                                    if boatHrp then
                                        SafeTween(boatHrp.CFrame * CFrame.new(0, 25, 0))
                                        EquipTool(_G.SelectWeapon or "Melee")
                                        Attack()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- Noclip
RunService.Stepped:Connect(function()
    if _G.Noclip or _G.AutoLevel or _G.AutoChest or _G.AutoBoss or _G.AutoFarmSelectedMob or _G.AutoNear then
        pcall(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Info label live updates
task.spawn(function()
    while wait(2) do
        pcall(function()
            if InfoLabels.level and LocalPlayer:FindFirstChild("Data") then
                InfoLabels.level:Set("Level: " .. tostring(LocalPlayer.Data.Level.Value))
            end
            if InfoLabels.beli and LocalPlayer.Data:FindFirstChild("Beli") then
                InfoLabels.beli:Set("Beli: " .. tostring(LocalPlayer.Data.Beli.Value))
            end
            if InfoLabels.fragments and LocalPlayer.Data:FindFirstChild("Fragments") then
                InfoLabels.fragments:Set("Fragments: " .. tostring(LocalPlayer.Data.Fragments.Value))
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════
-- LOADED
-- ═══════════════════════════════════════════════════════════

Rayfield:Notify({
    Title = "Xylene v1.3",
    Content = "Loaded! New: Bring Mob AOE, Kitsune, Race V4, Leviathan",
    Duration = 5
})

Rayfield:LoadConfiguration()
print("Xylene v1.3 Ultimate loaded successfully.")
