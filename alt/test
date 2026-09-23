-- ═══════════════════════════════════════════════════════════════════════════
-- XYLENE v2.0 ULTIMATE — Blox Fruits Complete Hub
-- Custom Xylene
-- Features: 130+ functions across farming, ESP, teleport, legendary weapons,
--           boat autopilot, movement, PvP, world tools, and utility
-- ═══════════════════════════════════════════════════════════════════════════

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
local TeleportService = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea = game.PlaceId == 7449423635
local InBloxFruits = First_Sea or Second_Sea or Third_Sea

-- ═══════════════════════════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════════════════════════

local Settings = {
    AimbotEnabled = false, AimbotMode = "Always On", AimbotTeamCheck = true,
    FOV = 100, ShowFOV = true, Smoothing = 5,
    ESPEnabled = false, ESPBox = true, ESPName = true, ESPHealth = true,
    ESPDistance = true, ESPTeamCheck = false,
    ESPPlayerColor = Color3.fromRGB(255, 255, 0),
    ESPRange = 1000
}

_G.AutoLevel = false
_G.AutoNear = false
_G.AutoBoss = false
_G.AutoHaki = false
_G.AutoFarmSelectedMob = false
_G.FruitSniper = false
_G.AutoGacha = false
_G.AutoMagnet = false
_G.AutoBuyInstinct = false
_G.AutoChest = false
_G.AutoStats = false
_G.AutoStoreFruit = false
_G.AutoCollectEmbers = false
_G.AutoPrayStatue = false
_G.AutoAwakenV4 = false
_G.AutoUseRaceSkill = false
_G.AutoMirageGear = false
_G.AutoLeviathan = false
_G.AutoSeaBeast = false
_G.AutoShipRaid = false
_G.AutoTerrorshark = false
_G.farmpiranya = false
_G.AutoShark = false
_G.InfiniteJump = false
_G.Noclip = false
_G.Fly = false
_G.FlySpeed = 100
_G.SpeedHack = false
_G.SpeedValue = 50
_G.NoSlow = false
_G.AutoRetreat = false
_G.RetreatHP = 30
_G.TPBackDeath = false
_G.ClickTP = false
_G.NearbyNotif = false
_G.NearbyRange = 100
_G.FruitNotif = false
_G.AntiLag = false
_G.BringMob = true
_G.FastAttack = true
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.9
_G.SelectedBoss = "Bandit"
_G.SelectedMob = "Bandit"
_G.FruitRange = 5000
_G.BringMobDistance = 350
_G.TweenSpeed = 280
_G.EnableWebhook = false
_G.WebhookURL = ""
_G.ChestsCollected = 0
_G.GachaCooldown = 60
_G.MagnetItemName = "MagnetToken"
_G.SavedPosition = nil
_G.StatPointsChunk = 3
-- Legendary Weapons
_G.AutoSaber = false
_G.AutoPoleV1 = false
_G.AutoSharkSaw = false
_G.AutoWarden = false
_G.AutoRengoku = false
_G.AutoCanvander = false
_G.AutoMusketeerHat = false
_G.AutoObservationV2 = false
_G.AutoHallow = false
_G.AutoYama = false
_G.AutoTushita = false
_G.AutoHolyTorch = false
_G.AutoRainbowHaki = false
_G.AutoSkullGuitar = false
_G.AutoBuddy = false
_G.AutoDualKatana = false
-- Sea
_G.AutoSailSea2 = false
_G.AutoSailSea3 = false
_G.BoatTweenSpeed = 350
_G.SelectedBoat = "PirateGrandBrigade"
_G.AutoFindPrehistoric = false
_G.AutoFindMirage = false
_G.AutoFindFrozen = false
_G.AutoComeTiki = false
_G.AutoComeHydra = false
_G.AutoLockMoon = false
_G.TweenToGear = false
-- Haki Fortress
_G.HakiFortress = false
-- Special Bosses
_G.CastleRaid = false
_G.AutoFactory = false
_G.AutoDonSwan = false
_G.AutoElite = false
_G.CakePrince = false
_G.SpawnCakePrince = true
_G.DoughKing = false
_G.AutoEvoRace = false
-- ESP Toggles
_G.IslandESP = false
_G.ChestESP = false
_G.DevilFruitESP = false
_G.FlowerESP = false
_G.RealFruitESP = false
_G.MobESP = false
_G.SeaBeastESP = false
_G.NpcESP = false
_G.MirageIslandESP = false
_G.AuraESP = false
_G.LSDESP = false
_G.MirageGearESP = false

local ChestCountLabel = nil
local InfoLabels = {}
local _conns = {}

-- ═══════════════════════════════════════════════════════════════════════════
-- UTILITIES
-- ═══════════════════════════════════════════════════════════════════════════

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 3})
    end)
end

local function SendDiscordWebhook(title, description, color, fields)
    if not _G.EnableWebhook or _G.WebhookURL == "" or #_G.WebhookURL < 15 then return end
    task.spawn(function()
        pcall(function()
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if not req then return end
            req({
                Url = _G.WebhookURL, Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    username = "Xylene Hub",
                    embeds = {{
                        title = "Xylene | " .. title,
                        description = description,
                        color = color or 65535,
                        fields = fields or {},
                        footer = { text = "Xylene v2.0 • " .. os.date("%d/%m/%Y %H:%M:%S") }
                    }}
                })
            })
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SAFE TWEEN
-- ═══════════════════════════════════════════════════════════════════════════

local currentTween, tweenDestination = nil, nil

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
        else existing.Velocity = Vector3.zero end
    else
        if existing then existing:Destroy() end
    end
end

local function StopTween()
    if currentTween then pcall(function() currentTween:Cancel() end)
        currentTween, tweenDestination = nil, nil
    end
    SetFlyAnchor(false)
end

local function SafeTween(targetCFrame, speedOverride)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local speed = speedOverride or _G.TweenSpeed
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    if distance <= 15 then hrp.CFrame = targetCFrame; if currentTween then StopTween() end; return end
    if tweenDestination and (tweenDestination.Position - targetCFrame.Position).Magnitude < 10 and currentTween then return currentTween end
    if currentTween then pcall(function() currentTween:Cancel() end) end
    tweenDestination = targetCFrame
    currentTween = TweenService:Create(hrp, TweenInfo.new(distance / speed, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    currentTween:Play()
    currentTween.Completed:Connect(function() tweenDestination = nil; currentTween = nil end)
    return currentTween
end

local function Tween2(targetCFrame, speedOverride)
    SafeTween(targetCFrame, speedOverride or 350)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- COMBAT HELPERS
-- ═══════════════════════════════════════════════════════════════════════════

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
            LocalPlayer.Character.Humanoid:EquipTool(tool) return tool
        end
    end
    local any = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if any then LocalPlayer.Character.Humanoid:EquipTool(any) return any end
end

local function Attack()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(1280, 672))
    end)
    if _G.FastAttack then
        pcall(function()
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
            if ReplicatedStorage.Modules and ReplicatedStorage.Modules:FindFirstChild("Net") then
                local ra = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")
                if ra then ra:FireServer(0) end
            end
        end)
    end
end

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

local function GetMaterial(matName)
    for _, v in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" and v.Type == "Material" and v.Name == matName then
            return v.Count
        end
    end
    return 0
end

-- ═══════════════════════════════════════════════════════════════════════════
-- QUEST DATA
-- ═══════════════════════════════════════════════════════════════════════════

local function CheckLevel()
    local Lv = LocalPlayer.Data.Level.Value
    if First_Sea then
        if Lv <= 9 then return "Bandit","BanditQuest1",1,CFrame.new(1060,16,1547) end
        if Lv <= 14 then return "Monkey","JungleQuest",1,CFrame.new(-1601,36,153) end
        if Lv <= 29 then return "Gorilla","JungleQuest",2,CFrame.new(-1601,36,153) end
        if Lv <= 39 then return "Pirate","BuggyQuest1",1,CFrame.new(-1140,4,3827) end
        if Lv <= 59 then return "Brute","BuggyQuest1",2,CFrame.new(-1140,4,3827) end
        if Lv <= 74 then return "Desert Bandit","DesertQuest",1,CFrame.new(896,6,4390) end
        if Lv <= 89 then return "Desert Officer","DesertQuest",2,CFrame.new(896,6,4390) end
        if Lv <= 99 then return "Snow Bandit","SnowQuest",1,CFrame.new(1386,87,-1298) end
        if Lv <= 119 then return "Snowman","SnowQuest",2,CFrame.new(1386,87,-1298) end
        if Lv <= 149 then return "Chief Petty Officer","MarineQuest2",1,CFrame.new(-5035,28,4324) end
        if Lv <= 174 then return "Sky Bandit","SkyQuest",1,CFrame.new(-4842,717,-2623) end
        if Lv <= 189 then return "Dark Master","SkyQuest",2,CFrame.new(-4842,717,-2623) end
        if Lv <= 209 then return "Prisoner","PrisonerQuest",1,CFrame.new(5310,0,474) end
        if Lv <= 249 then return "Dangerous Prisoner","PrisonerQuest",2,CFrame.new(5310,0,474) end
        if Lv <= 274 then return "Toga Warrior","ColosseumQuest",1,CFrame.new(-1577,7,-2984) end
        if Lv <= 299 then return "Gladiator","ColosseumQuest",2,CFrame.new(-1577,7,-2984) end
        if Lv <= 324 then return "Military Soldier","MagmaQuest",1,CFrame.new(-5316,12,8517) end
        if Lv <= 374 then return "Military Spy","MagmaQuest",2,CFrame.new(-5316,12,8517) end
        if Lv <= 399 then return "Fishman Warrior","FishmanQuest",1,CFrame.new(61122,18,1569) end
        if Lv <= 449 then return "Fishman Commando","FishmanQuest",2,CFrame.new(61122,18,1569) end
        if Lv <= 474 then return "God's Guard","SkyExp1Quest",1,CFrame.new(-4721,845,-1953) end
        if Lv <= 524 then return "Shanda","SkyExp1Quest",2,CFrame.new(-7863,5545,-378) end
        if Lv <= 549 then return "Royal Squad","SkyExp2Quest",1,CFrame.new(-7903,5635,-1410) end
        if Lv <= 624 then return "Royal Soldier","SkyExp2Quest",2,CFrame.new(-7903,5635,-1410) end
        if Lv <= 649 then return "Galley Pirate","FountainQuest",1,CFrame.new(5258,38,4050) end
        return "Galley Captain","FountainQuest",2,CFrame.new(5258,38,4050)
    elseif Second_Sea then
        if Lv <= 724 then return "Raider","Area1Quest",1,CFrame.new(-427,72,1835) end
        if Lv <= 774 then return "Mercenary","Area1Quest",2,CFrame.new(-427,72,1835) end
        if Lv <= 799 then return "Swan Pirate","Area2Quest",1,CFrame.new(635,73,917) end
        if Lv <= 874 then return "Factory Staff","Area2Quest",2,CFrame.new(635,73,917) end
        if Lv <= 899 then return "Marine Lieutenant","MarineQuest3",1,CFrame.new(-2440,73,-3217) end
        if Lv <= 949 then return "Marine Captain","MarineQuest3",2,CFrame.new(-2440,73,-3217) end
        if Lv <= 974 then return "Zombie","ZombieQuest",1,CFrame.new(-5494,48,-794) end
        if Lv <= 999 then return "Vampire","ZombieQuest",2,CFrame.new(-5494,48,-794) end
        if Lv <= 1049 then return "Snow Trooper","SnowMountainQuest",1,CFrame.new(607,401,-5370) end
        if Lv <= 1099 then return "Winter Warrior","SnowMountainQuest",2,CFrame.new(607,401,-5370) end
        if Lv <= 1124 then return "Lab Subordinate","IceSideQuest",1,CFrame.new(-6061,15,-4902) end
        if Lv <= 1174 then return "Horned Warrior","IceSideQuest",2,CFrame.new(-6061,15,-4902) end
        if Lv <= 1199 then return "Magma Ninja","FireSideQuest",1,CFrame.new(-5429,15,-5297) end
        if Lv <= 1249 then return "Lava Pirate","FireSideQuest",2,CFrame.new(-5429,15,-5297) end
        if Lv <= 1274 then return "Ship Deckhand","ShipQuest1",1,CFrame.new(1040,125,32911) end
        if Lv <= 1299 then return "Ship Engineer","ShipQuest1",2,CFrame.new(1040,125,32911) end
        if Lv <= 1324 then return "Ship Steward","ShipQuest2",1,CFrame.new(971,125,33245) end
        if Lv <= 1349 then return "Ship Officer","ShipQuest2",2,CFrame.new(971,125,33245) end
        if Lv <= 1374 then return "Arctic Warrior","FrostQuest",1,CFrame.new(5668,28,-6484) end
        if Lv <= 1424 then return "Snow Lurker","FrostQuest",2,CFrame.new(5668,28,-6484) end
        if Lv <= 1449 then return "Sea Soldier","ForgottenQuest",1,CFrame.new(-3054,236,-10147) end
        return "Water Fighter","ForgottenQuest",2,CFrame.new(-3054,236,-10147)
    else
        if Lv <= 1524 then return "Pirate Millionaire","PiratePortQuest",1,CFrame.new(-289,43,5580) end
        if Lv <= 1574 then return "Pistol Billionaire","PiratePortQuest",2,CFrame.new(-289,43,5580) end
        if Lv <= 1599 then return "Dragon Crew Warrior","AmazonQuest",1,CFrame.new(5833,51,-1103) end
        if Lv <= 1624 then return "Dragon Crew Archer","AmazonQuest",2,CFrame.new(5833,51,-1103) end
        if Lv <= 1649 then return "Female Islander","AmazonQuest2",1,CFrame.new(5446,601,749) end
        if Lv <= 1699 then return "Giant Islander","AmazonQuest2",2,CFrame.new(5446,601,749) end
        if Lv <= 1724 then return "Marine Commodore","MarineTreeIsland",1,CFrame.new(2179,28,-6740) end
        if Lv <= 1774 then return "Marine Rear Admiral","MarineTreeIsland",2,CFrame.new(2179,28,-6740) end
        if Lv <= 1799 then return "Fishman Raider","DeepForestIsland3",1,CFrame.new(-10582,331,-8757) end
        if Lv <= 1824 then return "Fishman Captain","DeepForestIsland3",2,CFrame.new(-10582,331,-8757) end
        if Lv <= 1849 then return "Forest Pirate","DeepForestIsland",1,CFrame.new(-13232,332,-7626) end
        if Lv <= 1899 then return "Mythological Pirate","DeepForestIsland",2,CFrame.new(-13232,332,-7626) end
        if Lv <= 1924 then return "Jungle Pirate","DeepForestIsland2",1,CFrame.new(-12682,390,-9902) end
        if Lv <= 1974 then return "Musketeer Pirate","DeepForestIsland2",2,CFrame.new(-12682,390,-9902) end
        if Lv <= 1999 then return "Reborn Skeleton","HauntedQuest1",1,CFrame.new(-9480,142,5566) end
        if Lv <= 2024 then return "Living Zombie","HauntedQuest1",2,CFrame.new(-9480,142,5566) end
        if Lv <= 2049 then return "Demonic Soul","HauntedQuest2",1,CFrame.new(-9516,178,6078) end
        if Lv <= 2074 then return "Posessed Mummy","HauntedQuest2",2,CFrame.new(-9516,178,6078) end
        if Lv <= 2099 then return "Peanut Scout","NutsIslandQuest",1,CFrame.new(-2105,37,-10195) end
        if Lv <= 2124 then return "Peanut President","NutsIslandQuest",2,CFrame.new(-2105,37,-10195) end
        if Lv <= 2149 then return "Ice Cream Chef","IceCreamIslandQuest",1,CFrame.new(-819,64,-10967) end
        if Lv <= 2199 then return "Ice Cream Commander","IceCreamIslandQuest",2,CFrame.new(-819,64,-10967) end
        if Lv <= 2224 then return "Cookie Crafter","CakeQuest1",1,CFrame.new(-2022,36,-12030) end
        if Lv <= 2249 then return "Cake Guard","CakeQuest1",2,CFrame.new(-2022,36,-12030) end
        if Lv <= 2274 then return "Baking Staff","CakeQuest2",1,CFrame.new(-1928,37,-12840) end
        if Lv <= 2299 then return "Head Baker","CakeQuest2",2,CFrame.new(-1928,37,-12840) end
        if Lv <= 2324 then return "Cocoa Warrior","ChocQuest1",1,CFrame.new(231,23,-12200) end
        if Lv <= 2349 then return "Chocolate Bar Battler","ChocQuest1",2,CFrame.new(231,23,-12200) end
        if Lv <= 2374 then return "Sweet Thief","ChocQuest2",1,CFrame.new(151,23,-12774) end
        if Lv <= 2400 then return "Candy Rebel","ChocQuest2",2,CFrame.new(151,23,-12774) end
        if Lv <= 2424 then return "Candy Pirate","CandyQuest1",1,CFrame.new(-1149,13,-14445) end
        if Lv <= 2449 then return "Snow Demon","CandyQuest1",2,CFrame.new(-1149,13,-14445) end
        if Lv <= 2474 then return "Isle Outlaw","TikiQuest1",1,CFrame.new(-16549,55,-179) end
        if Lv <= 2524 then return "Island Boy","TikiQuest1",2,CFrame.new(-16549,55,-179) end
        return "Isle Champion","TikiQuest2",2,CFrame.new(-16542,55,1044)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- UI
-- ═══════════════════════════════════════════════════════════════════════════

local Window = Rayfield:CreateWindow({
    Name = "Xylene",
    LoadingTitle = "Xylene v2.0 Ultimate",
    LoadingSubtitle = "Blox Fruits Complete Hub",
    ConfigurationSaving = { Enabled = true, FolderName = "Xylene", FileName = "Config" },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main")
local BossTab = Window:CreateTab("Boss & Mob")
local EventsTab = Window:CreateTab("Events")
local SeaTab = Window:CreateTab("Sea & Race")
local LegendTab = Window:CreateTab("Legendary")
local MoveTab = Window:CreateTab("Movement")
local PvPTab = Window:CreateTab("PvP")
local ESPTab = Window:CreateTab("ESP")
local WorldTab = Window:CreateTab("World")
local TeleportTab = Window:CreateTab("Teleport")
local InfoTab = Window:CreateTab("Info")

-- ═══════════════════════════════════════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════════════════════════════════════

MainTab:CreateSection("Farming")
if InBloxFruits then
    MainTab:CreateDropdown({ Name = "Weapon Type", Options = {"Melee","Sword","Blox Fruit","Gun"},
        CurrentOption = "Melee", Callback = function(v) _G.SelectWeapon = v end })
    MainTab:CreateDropdown({ Name = "Attack Speed", Options = {"Normal","Fast","Very Fast"},
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
    MainTab:CreateToggle({ Name = "Bring Mob AOE", CurrentValue = true,
        Callback = function(v) _G.BringMob = v end })
    MainTab:CreateSlider({ Name = "Bring Mob Radius", Range = {100,500}, Increment = 25,
        CurrentValue = 350, Callback = function(v) _G.BringMobDistance = v end })
    MainTab:CreateToggle({ Name = "Auto Castle Raid", CurrentValue = false,
        Callback = function(v) _G.CastleRaid = v end })

    MainTab:CreateSection("Auto Stats")
    MainTab:CreateToggle({ Name = "Auto Stats", CurrentValue = false,
        Callback = function(v) _G.AutoStats = v end })
    MainTab:CreateSlider({ Name = "Points per Cycle", Range = {1,10}, Increment = 1,
        CurrentValue = 3, Callback = function(v) _G.StatPointsChunk = v end })

    MainTab:CreateSection("Haki Fortress")
    MainTab:CreateToggle({ Name = "Collect All Aura Skins", CurrentValue = false,
        Callback = function(v)
            _G.HakiFortress = v
            if v then Notify("Xylene", "Collecting Snow White, Pure Red, Winter Sky") end
        end })
end

-- ═══════════════════════════════════════════════════════════════════════════
-- BOSS & MOB TAB
-- ═══════════════════════════════════════════════════════════════════════════

if InBloxFruits then
    local mobList = {"Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Snow Bandit","Snowman","Chief Petty Officer","Military Soldier","Military Spy","Fishman Warrior","God's Guard","Raider","Mercenary","Swan Pirate"}
    BossTab:CreateSection("Selected Mob")
    BossTab:CreateDropdown({ Name = "Select Mob", Options = mobList, CurrentOption = mobList[1],
        Callback = function(v) _G.SelectedMob = v end })
    BossTab:CreateToggle({ Name = "Auto Farm Selected Mob", CurrentValue = false,
        Callback = function(v) _G.AutoFarmSelectedMob = v end })

    BossTab:CreateSection("Boss")
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
        Callback = function(v) _G.AutoBoss = v end })

    BossTab:CreateSection("Elite Hunter")
    BossTab:CreateParagraph({ Name = "Elite Status", Content = "Checking..." })
    BossTab:CreateToggle({ Name = "Auto Kill Elite Hunter", CurrentValue = false,
        Callback = function(v) _G.AutoElite = v end })

    if Third_Sea then
        BossTab:CreateSection("Cake Prince / Dough King")
        BossTab:CreateToggle({ Name = "Auto Cake Prince", CurrentValue = false,
            Callback = function(v) _G.CakePrince = v end })
        BossTab:CreateToggle({ Name = "Auto Spawn Cake Prince", CurrentValue = true,
            Callback = function(v) _G.SpawnCakePrince = v end })
        BossTab:CreateToggle({ Name = "Auto Dough King", CurrentValue = false,
            Callback = function(v) _G.DoughKing = v end })
    end

    if Second_Sea then
        BossTab:CreateSection("Factory (Sea 2)")
        BossTab:CreateToggle({ Name = "Auto Factory Core", CurrentValue = false,
            Callback = function(v) _G.AutoFactory = v end })
        BossTab:CreateToggle({ Name = "Auto Don Swan", CurrentValue = false,
            Callback = function(v) _G.AutoDonSwan = v end })
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EVENTS TAB
-- ═══════════════════════════════════════════════════════════════════════════

if InBloxFruits then
    EventsTab:CreateSection("Fruit")
    EventsTab:CreateToggle({ Name = "Fruit Sniper", CurrentValue = false,
        Callback = function(v) _G.FruitSniper = v end })
    EventsTab:CreateSlider({ Name = "Fruit Range", Range = {100,10000}, Increment = 100,
        CurrentValue = 5000, Callback = function(v) _G.FruitRange = v end })
    EventsTab:CreateToggle({ Name = "Auto Store Fruit", CurrentValue = false,
        Callback = function(v) _G.AutoStoreFruit = v end })
    EventsTab:CreateToggle({ Name = "Auto Gacha", CurrentValue = false,
        Callback = function(v) _G.AutoGacha = v end })
    EventsTab:CreateSlider({ Name = "Gacha Cooldown (sec)", Range = {30,600}, Increment = 10,
        CurrentValue = 60, Callback = function(v) _G.GachaCooldown = v end })

    EventsTab:CreateSection("Magnet Event")
    EventsTab:CreateInput({ Name = "Magnet Item Name", PlaceholderText = "MagnetToken",
        CurrentValue = "MagnetToken", RemoveTextAfterFocusLost = false,
        Callback = function(v) _G.MagnetItemName = v end })
    EventsTab:CreateToggle({ Name = "Auto Farm Magnet", CurrentValue = false,
        Callback = function(v) _G.AutoMagnet = v end })

    EventsTab:CreateSection("Kitsune Event")
    EventsTab:CreateToggle({ Name = "Auto Collect Blue Embers", CurrentValue = false,
        Callback = function(v) _G.AutoCollectEmbers = v end })
    EventsTab:CreateToggle({ Name = "Auto Pray Statue", CurrentValue = false,
        Callback = function(v) _G.AutoPrayStatue = v end })
    EventsTab:CreateButton({ Name = "Touch Kitsune Statue", Callback = function()
        pcall(function()
            local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
            local t = Net and Net:FindFirstChild("RE/TouchKitsuneStatue")
            if t then t:FireServer() Notify("Xylene", "Touched Statue") end
        end)
    end })

    EventsTab:CreateSection("Chests")
    ChestCountLabel = EventsTab:CreateLabel("Chests: 0")
    EventsTab:CreateToggle({ Name = "Auto Chest", CurrentValue = false,
        Callback = function(v) _G.AutoChest = v end })
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SEA & RACE TAB
-- ═══════════════════════════════════════════════════════════════════════════

if InBloxFruits then
    SeaTab:CreateSection("Race V4")
    SeaTab:CreateToggle({ Name = "Auto Awaken Race V4", CurrentValue = false,
        Callback = function(v) _G.AutoAwakenV4 = v end })
    SeaTab:CreateToggle({ Name = "Auto Use Race Skill", CurrentValue = false,
        Callback = function(v) _G.AutoUseRaceSkill = v end })
    SeaTab:CreateToggle({ Name = "Auto Find Mirage Gear", CurrentValue = false,
        Callback = function(v) _G.AutoMirageGear = v end })
    if Second_Sea then
        SeaTab:CreateToggle({ Name = "Auto Evo Race V2", CurrentValue = false,
            Callback = function(v) _G.AutoEvoRace = v end })
    end

    SeaTab:CreateSection("Sea Events")
    SeaTab:CreateToggle({ Name = "Auto Leviathan", CurrentValue = false,
        Callback = function(v) _G.AutoLeviathan = v end })
    SeaTab:CreateToggle({ Name = "Auto Sea Beast", CurrentValue = false,
        Callback = function(v) _G.AutoSeaBeast = v end })
    SeaTab:CreateToggle({ Name = "Auto Ship Raid", CurrentValue = false,
        Callback = function(v) _G.AutoShipRaid = v end })
    SeaTab:CreateToggle({ Name = "Auto Terrorshark", CurrentValue = false,
        Callback = function(v) _G.AutoTerrorshark = v end })
    SeaTab:CreateToggle({ Name = "Auto Piranha", CurrentValue = false,
        Callback = function(v) _G.farmpiranya = v end })
    SeaTab:CreateToggle({ Name = "Auto Shark", CurrentValue = false,
        Callback = function(v) _G.AutoShark = v end })

    if Third_Sea then
        SeaTab:CreateSection("Boat Autopilot")
        SeaTab:CreateSlider({ Name = "Boat Speed", Range = {100,500}, Increment = 10,
            CurrentValue = 350, Callback = function(v) _G.BoatTweenSpeed = v end })
        SeaTab:CreateToggle({ Name = "Find Prehistoric Island", CurrentValue = false,
            Callback = function(v) _G.AutoFindPrehistoric = v end })
        SeaTab:CreateToggle({ Name = "Find Mirage Island", CurrentValue = false,
            Callback = function(v) _G.AutoFindMirage = v end })
        SeaTab:CreateToggle({ Name = "Find Frozen Dimension", CurrentValue = false,
            Callback = function(v) _G.AutoFindFrozen = v end })
        SeaTab:CreateToggle({ Name = "Come Back to Tiki", CurrentValue = false,
            Callback = function(v) _G.AutoComeTiki = v end })
        SeaTab:CreateToggle({ Name = "Come Back to Hydra", CurrentValue = false,
            Callback = function(v) _G.AutoComeHydra = v end })

        SeaTab:CreateSection("Mirage Utilities")
        SeaTab:CreateToggle({ Name = "Auto Lock Moon", CurrentValue = false,
            Callback = function(v) _G.AutoLockMoon = v end })
        SeaTab:CreateButton({ Name = "Tween to Highest Point", Callback = function()
            if workspace.Map:FindFirstChild("MysticIsland") then
                for _, v in pairs(workspace.Map.MysticIsland:GetDescendants()) do
                    if v:IsA("MeshPart") and v.MeshId == "rbxassetid://83190276951914" then
                        SafeTween(v.CFrame * CFrame.new(0, 211, 0)) break
                    end
                end
            end
        end })
        SeaTab:CreateToggle({ Name = "Tween to Blue Gear", CurrentValue = false,
            Callback = function(v) _G.TweenToGear = v end })
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- LEGENDARY WEAPONS TAB
-- ═══════════════════════════════════════════════════════════════════════════

LegendTab:CreateSection("Sea 1")
if First_Sea then
    LegendTab:CreateToggle({ Name = "Auto Saber (Level 200+)", CurrentValue = false,
        Callback = function(v) _G.AutoSaber = v end })
    LegendTab:CreateToggle({ Name = "Auto Pole V1", CurrentValue = false,
        Callback = function(v) _G.AutoPoleV1 = v end })
    LegendTab:CreateToggle({ Name = "Auto Shark Saw", CurrentValue = false,
        Callback = function(v) _G.AutoSharkSaw = v end })
    LegendTab:CreateToggle({ Name = "Auto Warden Sword", CurrentValue = false,
        Callback = function(v) _G.AutoWarden = v end })
    LegendTab:CreateToggle({ Name = "Auto Rengoku", CurrentValue = false,
        Callback = function(v) _G.AutoRengoku = v end })
end

LegendTab:CreateSection("Sea 2")
if Second_Sea then
    LegendTab:CreateToggle({ Name = "Auto Canvander", CurrentValue = false,
        Callback = function(v) _G.AutoCanvander = v end })
    LegendTab:CreateToggle({ Name = "Auto Musketeer Hat", CurrentValue = false,
        Callback = function(v) _G.AutoMusketeerHat = v end })
    LegendTab:CreateToggle({ Name = "Auto Observation Haki V2", CurrentValue = false,
        Callback = function(v) _G.AutoObservationV2 = v end })
end

LegendTab:CreateSection("Sea 3")
if Third_Sea then
    LegendTab:CreateToggle({ Name = "Auto Hallow Scythe", CurrentValue = false,
        Callback = function(v) _G.AutoHallow = v end })
    LegendTab:CreateToggle({ Name = "Auto Yama", CurrentValue = false,
        Callback = function(v) _G.AutoYama = v end })
    LegendTab:CreateToggle({ Name = "Auto Tushita", CurrentValue = false,
        Callback = function(v) _G.AutoTushita = v end })
    LegendTab:CreateToggle({ Name = "Auto Holy Torch", CurrentValue = false,
        Callback = function(v) _G.AutoHolyTorch = v end })
    LegendTab:CreateToggle({ Name = "Auto Rainbow Haki", CurrentValue = false,
        Callback = function(v) _G.AutoRainbowHaki = v end })
    LegendTab:CreateToggle({ Name = "Auto Skull Guitar", CurrentValue = false,
        Callback = function(v) _G.AutoSkullGuitar = v end })
    LegendTab:CreateToggle({ Name = "Auto Buddy Sword", CurrentValue = false,
        Callback = function(v) _G.AutoBuddy = v end })
    LegendTab:CreateToggle({ Name = "Auto Cursed Dual Katana (CDK)", CurrentValue = false,
        Callback = function(v) _G.AutoDualKatana = v end })
end

-- ═══════════════════════════════════════════════════════════════════════════
-- MOVEMENT TAB
-- ═══════════════════════════════════════════════════════════════════════════

MoveTab:CreateSection("Flight")
MoveTab:CreateToggle({ Name = "Fly (WASD + Space/Ctrl)", CurrentValue = false,
    Callback = function(v)
        _G.Fly = v
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if _conns.fly then _conns.fly:Disconnect() _conns.fly = nil end
        if not v then
            if hum then hum.PlatformStand = false end
            if hrp then
                local bv = hrp:FindFirstChild("Xylene_FlyBV")
                local bg = hrp:FindFirstChild("Xylene_FlyBG")
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end
            return
        end
        if not hrp or not hum then return end
        hum.PlatformStand = true
        local bv = Instance.new("BodyVelocity")
        bv.Name = "Xylene_FlyBV" bv.MaxForce = Vector3.new(1e5,1e5,1e5) bv.Velocity = Vector3.zero bv.Parent = hrp
        local bg = Instance.new("BodyGyro")
        bg.Name = "Xylene_FlyBG" bg.MaxTorque = Vector3.new(1e5,1e5,1e5) bg.P = 1e4 bg.Parent = hrp
        _conns.fly = RunService.Heartbeat:Connect(function()
            if not _G.Fly or not hrp.Parent then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.yAxis end
            bv.Velocity = dir.Magnitude > 0 and dir.Unit * _G.FlySpeed or Vector3.zero
            bg.CFrame = cam.CFrame
        end)
    end })
MoveTab:CreateSlider({ Name = "Fly Speed", Range = {10,1000}, Increment = 10,
    CurrentValue = 100, Callback = function(v) _G.FlySpeed = v end })

MoveTab:CreateSection("Speed")
MoveTab:CreateToggle({ Name = "Speed Hack", CurrentValue = false,
    Callback = function(v)
        _G.SpeedHack = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v and _G.SpeedValue or 16 end
    end })
MoveTab:CreateSlider({ Name = "Walk Speed", Range = {16,500}, Increment = 5,
    CurrentValue = 50, Callback = function(v)
        _G.SpeedValue = v
        if _G.SpeedHack then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end })
MoveTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false,
    Callback = function(v)
        _G.InfiniteJump = v
        if _conns.ij then _conns.ij:Disconnect() _conns.ij = nil end
        if v then
            _conns.ij = UserInputService.JumpRequest:Connect(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
    end })
MoveTab:CreateSlider({ Name = "Jump Power", Range = {50,500}, Increment = 10,
    CurrentValue = 50, Callback = function(v)
        _G.JumpPower = v
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end })
MoveTab:CreateToggle({ Name = "Noclip", CurrentValue = false,
    Callback = function(v)
        _G.Noclip = v
        if not v and LocalPlayer.Character then
            for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end })
MoveTab:CreateToggle({ Name = "No Slow", CurrentValue = false,
    Callback = function(v) _G.NoSlow = v end })

MoveTab:CreateSection("Position Utility")
MoveTab:CreateButton({ Name = "Save Position", Callback = function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then _G.SavedPosition = hrp.CFrame Notify("Xylene", "Saved!") end
end })
MoveTab:CreateButton({ Name = "TP to Saved", Callback = function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and _G.SavedPosition then hrp.CFrame = _G.SavedPosition Notify("Xylene", "Teleported!")
    else Notify("Xylene", "No saved position") end
end })
MoveTab:CreateToggle({ Name = "Auto Retreat (Low HP)", CurrentValue = false,
    Callback = function(v) _G.AutoRetreat = v end })
MoveTab:CreateSlider({ Name = "Retreat HP %", Range = {1,99}, Increment = 1,
    CurrentValue = 30, Callback = function(v) _G.RetreatHP = v end })
MoveTab:CreateToggle({ Name = "TP Back on Death", CurrentValue = false,
    Callback = function(v)
        _G.TPBackDeath = v
        if _conns.tpDeath then _conns.tpDeath:Disconnect() _conns.tpDeath = nil end
        if v then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then _G.SavedPosition = hrp.CFrame end
            _conns.tpDeath = LocalPlayer.CharacterAdded:Connect(function(c)
                task.wait(1)
                local root = c:WaitForChild("HumanoidRootPart", 5)
                if root and _G.SavedPosition then root.CFrame = _G.SavedPosition end
            end)
        end
    end })

-- ═══════════════════════════════════════════════════════════════════════════
-- PVP TAB
-- ═══════════════════════════════════════════════════════════════════════════

PvPTab:CreateSection("Aimbot")
PvPTab:CreateToggle({ Name = "Enable Aimbot", CurrentValue = false,
    Callback = function(v) Settings.AimbotEnabled = v end })
PvPTab:CreateDropdown({ Name = "Activation", Options = {"Always On","Right Click (MB2)"},
    CurrentOption = "Always On", Callback = function(v) Settings.AimbotMode = v end })
PvPTab:CreateToggle({ Name = "Team Check", CurrentValue = true,
    Callback = function(v) Settings.AimbotTeamCheck = v end })
PvPTab:CreateSlider({ Name = "FOV Size", Range = {20,500}, Increment = 5,
    CurrentValue = 100, Callback = function(v) Settings.FOV = v end })
PvPTab:CreateToggle({ Name = "Show FOV Circle", CurrentValue = true,
    Callback = function(v) Settings.ShowFOV = v end })
PvPTab:CreateSlider({ Name = "Smoothing", Range = {2,20}, Increment = 1,
    CurrentValue = 5, Callback = function(v) Settings.Smoothing = v end })

-- ═══════════════════════════════════════════════════════════════════════════
-- ESP TAB
-- ═══════════════════════════════════════════════════════════════════════════

ESPTab:CreateSection("Player ESP")
ESPTab:CreateToggle({ Name = "Enable Player ESP", CurrentValue = false,
    Callback = function(v) Settings.ESPEnabled = v end })
ESPTab:CreateToggle({ Name = "ESP Box", CurrentValue = true,
    Callback = function(v) Settings.ESPBox = v end })
ESPTab:CreateToggle({ Name = "ESP Name", CurrentValue = true,
    Callback = function(v) Settings.ESPName = v end })
ESPTab:CreateToggle({ Name = "ESP Health Bar", CurrentValue = true,
    Callback = function(v) Settings.ESPHealth = v end })
ESPTab:CreateToggle({ Name = "ESP Distance", CurrentValue = true,
    Callback = function(v) Settings.ESPDistance = v end })
ESPTab:CreateToggle({ Name = "Team Check", CurrentValue = false,
    Callback = function(v) Settings.ESPTeamCheck = v end })
ESPTab:CreateSlider({ Name = "ESP Range", Range = {100,3000}, Increment = 100,
    CurrentValue = 1000, Callback = function(v) Settings.ESPRange = v end })
ESPTab:CreateColorPicker({ Name = "Player Color", Color = Settings.ESPPlayerColor,
    Callback = function(v) Settings.ESPPlayerColor = v end })

ESPTab:CreateSection("World ESP")
ESPTab:CreateToggle({ Name = "Island ESP", CurrentValue = false,
    Callback = function(v) _G.IslandESP = v end })
ESPTab:CreateToggle({ Name = "Mirage Island ESP", CurrentValue = false,
    Callback = function(v) _G.MirageIslandESP = v end })
ESPTab:CreateToggle({ Name = "Mirage Gear ESP", CurrentValue = false,
    Callback = function(v) _G.MirageGearESP = v end })
ESPTab:CreateToggle({ Name = "Chest ESP", CurrentValue = false,
    Callback = function(v) _G.ChestESP = v end })
ESPTab:CreateToggle({ Name = "Devil Fruit ESP", CurrentValue = false,
    Callback = function(v) _G.DevilFruitESP = v end })
ESPTab:CreateToggle({ Name = "Real Fruit ESP", CurrentValue = false,
    Callback = function(v) _G.RealFruitESP = v end })
ESPTab:CreateToggle({ Name = "Flower ESP", CurrentValue = false,
    Callback = function(v) _G.FlowerESP = v end })
ESPTab:CreateToggle({ Name = "Mob ESP", CurrentValue = false,
    Callback = function(v) _G.MobESP = v end })
ESPTab:CreateToggle({ Name = "Sea Beast ESP", CurrentValue = false,
    Callback = function(v) _G.SeaBeastESP = v end })
ESPTab:CreateToggle({ Name = "NPC ESP", CurrentValue = false,
    Callback = function(v) _G.NpcESP = v end })
ESPTab:CreateToggle({ Name = "Aura NPC ESP", CurrentValue = false,
    Callback = function(v) _G.AuraESP = v end })
ESPTab:CreateToggle({ Name = "Legendary Sword Dealer ESP", CurrentValue = false,
    Callback = function(v) _G.LSDESP = v end })

-- ═══════════════════════════════════════════════════════════════════════════
-- WORLD TAB
-- ═══════════════════════════════════════════════════════════════════════════

WorldTab:CreateSection("Visuals")
WorldTab:CreateToggle({ Name = "No Fog", CurrentValue = false,
    Callback = function(v)
        Lighting.FogEnd = v and 1e6 or 100000
        Lighting.FogStart = v and 1e6 or 0
    end })
WorldTab:CreateToggle({ Name = "Full Bright", CurrentValue = false,
    Callback = function(v)
        Lighting.Brightness = v and 2 or 1
        Lighting.ClockTime = v and 14 or 12
    end })
WorldTab:CreateSlider({ Name = "FOV", Range = {30,120}, Increment = 1, CurrentValue = 70,
    Callback = function(v)
        if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = v end
    end })
WorldTab:CreateToggle({ Name = "Anti Lag", CurrentValue = false,
    Callback = function(v)
        _G.AntiLag = v
        if v then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                end
            end
        end
    end })
WorldTab:CreateSlider({ Name = "FPS Cap", Range = {15,240}, Increment = 5, CurrentValue = 60,
    Callback = function(v) if setfpscap then setfpscap(v) end end })

WorldTab:CreateSection("Utility")
WorldTab:CreateButton({ Name = "Copy Coordinates", Callback = function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local p = hrp.Position
        local s = string.format("%.2f, %.2f, %.2f", p.X, p.Y, p.Z)
        if setclipboard then setclipboard(s) end
        Notify("Xylene", s)
    end
end })
WorldTab:CreateToggle({ Name = "Nearby Player Notifier", CurrentValue = false,
    Callback = function(v) _G.NearbyNotif = v end })
WorldTab:CreateSlider({ Name = "Alert Range", Range = {10,500}, Increment = 10, CurrentValue = 100,
    Callback = function(v) _G.NearbyRange = v end })
WorldTab:CreateToggle({ Name = "Click TP", CurrentValue = false,
    Callback = function(v)
        _G.ClickTP = v
        if _conns.clickTP then _conns.clickTP:Disconnect() _conns.clickTP = nil end
        if v then
            _conns.clickTP = UserInputService.InputBegan:Connect(function(input, gp)
                if gp or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local cam = workspace.CurrentCamera
                if not hrp or not cam then return end
                local params = RaycastParams.new()
                params.FilterType = Enum.RaycastFilterType.Exclude
                params.FilterDescendantsInstances = {LocalPlayer.Character}
                local hit = workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 1000, params)
                if hit then hrp.CFrame = CFrame.new(hit.Position + Vector3.new(0, 4, 0)) end
            end)
        end
    end })
WorldTab:CreateToggle({ Name = "Fruit Spawn Notifier", CurrentValue = false,
    Callback = function(v) _G.FruitNotif = v end })

-- ═══════════════════════════════════════════════════════════════════════════
-- TELEPORT TAB
-- ═══════════════════════════════════════════════════════════════════════════

TeleportTab:CreateSection("Sea Travel")
TeleportTab:CreateToggle({ Name = "Auto Sail to Sea 2 (Level 700+)", CurrentValue = false,
    Callback = function(v) _G.AutoSailSea2 = v end })
TeleportTab:CreateToggle({ Name = "Auto Sail to Sea 3 (Level 1500+)", CurrentValue = false,
    Callback = function(v) _G.AutoSailSea3 = v end })
TeleportTab:CreateButton({ Name = "Go to First Sea", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
end })
TeleportTab:CreateButton({ Name = "Go to Second Sea", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
end })
TeleportTab:CreateButton({ Name = "Go to Third Sea", Callback = function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
end })

local IslandData = {}
if First_Sea then
    IslandData = {
        WindMill = {type="tween", cf=CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594)},
        Marine = {type="tween", cf=CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156)},
        ["Middle Town"] = {type="tween", cf=CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094)},
        Jungle = {type="tween", cf=CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754)},
        ["Pirate Village"] = {type="tween", cf=CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969)},
        Desert = {type="tween", cf=CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688)},
        ["Snow Island"] = {type="tween", cf=CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469)},
        MarineFord = {type="tween", cf=CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313)},
        Colosseum = {type="tween", cf=CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969)},
        ["Sky Island 1"] = {type="tween", cf=CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063)},
        ["Sky Island 2"] = {type="remote", entrance=Vector3.new(-4607.82275, 872.54248, -1667.55688)},
        ["Sky Island 3"] = {type="remote", entrance=Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047)},
        Prison = {type="tween", cf=CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656)},
        ["Magma Village"] = {type="tween", cf=CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875)},
        ["Under Water Island"] = {type="remote", entrance=Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)},
        ["Fountain City"] = {type="tween", cf=CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813)},
        ["Shank Room"] = {type="tween", cf=CFrame.new(-1442.16553, 29.8788261, -28.3547478)},
        ["Mob Island"] = {type="tween", cf=CFrame.new(-2850.20068, 7.39224768, 5354.99268)}
    }
elseif Second_Sea then
    IslandData = {
        ["The Cafe"] = {type="remote_tween", entrance=Vector3.new(-281.93707275390625, 306.130615234375, 609.280029296875), cf=CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828)},
        ["First Spot"] = {type="tween", cf=CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375)},
        ["Dark Area"] = {type="tween", cf=CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375)},
        ["Flamingo Mansion"] = {type="remote", entrance=Vector3.new(-281.93707275390625, 306.130615234375, 609.280029296875)},
        ["Flamingo Room"] = {type="remote", entrance=Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625)},
        ["Green Zone"] = {type="tween", cf=CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344)},
        Factory = {type="tween", cf=CFrame.new(424.12698364258, 211.16171264648, -427.54049682617)},
        Colossuim = {type="tween", cf=CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641)},
        ["Zombie Island"] = {type="tween", cf=CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094)},
        ["Two Snow Mountain"] = {type="tween", cf=CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938)},
        ["Punk Hazard"] = {type="tween", cf=CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125)},
        ["Cursed Ship"] = {type="remote", entrance=Vector3.new(923.40197753906, 125.05712890625, 32885.875)},
        ["Ice Castle"] = {type="tween", cf=CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188)},
        ["Forgotten Island"] = {type="tween", cf=CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875)},
        ["Ussop Island"] = {type="tween", cf=CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781)},
        ["Mini Sky Island"] = {type="tween", cf=CFrame.new(-288.74060058594, 49326.31640625, -35248.59375)}
    }
elseif Third_Sea then
    IslandData = {
        Mansion = {type="remote", entrance=Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125)},
        ["Port Town"] = {type="tween", cf=CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375)},
        ["Great Tree"] = {type="tween", cf=CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625)},
        ["Castle On The Sea"] = {type="remote", entrance=Vector3.new(-5075.50927734375, 314.5155029296875, -3150.0224609375)},
        MiniSky = {type="tween", cf=CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125)},
        ["Hydra Island"] = {type="remote", entrance=Vector3.new(5661.5322265625, 1013.0907592773438, -334.9649963378906)},
        ["Floating Turtle"] = {type="tween", cf=CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625)},
        ["Haunted Castle"] = {type="tween", cf=CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562)},
        ["Ice Cream Island"] = {type="tween", cf=CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625)},
        ["Peanut Island"] = {type="tween", cf=CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375)},
        ["Cake Island"] = {type="tween", cf=CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375)},
        ["Cocoa Island"] = {type="tween", cf=CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375)},
        ["Candy Island"] = {type="tween", cf=CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625)},
        ["Tiki Outpost"] = {type="tween", cf=CFrame.new(-16542.447265625, 55.68632888793945, 1044.41650390625)},
        ["Submerged Island"] = {type="tween", cf=CFrame.new(-27420.5, -85.2, 230.4)}
    }
end

local islandList = {}
for name, _ in pairs(IslandData) do table.insert(islandList, name) end
table.sort(islandList)

TeleportTab:CreateSection("Island Teleport")
TeleportTab:CreateDropdown({ Name = "Select Island", Options = islandList, CurrentOption = islandList[1],
    Callback = function(v) _G.SelectIsland = v end })
TeleportTab:CreateButton({ Name = "Teleport to Island", Callback = function()
    local data = IslandData[_G.SelectIsland]
    if not data then Notify("Xylene", "Island not found") return end
    if data.type == "tween" then SafeTween(data.cf)
    elseif data.type == "remote" then ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", data.entrance)
    elseif data.type == "remote_tween" then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", data.entrance)
        task.wait(1) SafeTween(data.cf)
    end
    Notify("Xylene", "Teleporting to " .. tostring(_G.SelectIsland))
end })
TeleportTab:CreateButton({ Name = "Cancel Tween", Callback = function() StopTween() end })

-- ═══════════════════════════════════════════════════════════════════════════
-- INFO TAB
-- ═══════════════════════════════════════════════════════════════════════════

InfoTab:CreateSection("Player")
local executorName = (identifyexecutor and identifyexecutor()) or "Unknown"
local seaName = First_Sea and "Sea 1" or Second_Sea and "Sea 2" or Third_Sea and "Sea 3" or "N/A"
InfoLabels.executor = InfoTab:CreateLabel("Executor: " .. tostring(executorName))
InfoLabels.sea = InfoTab:CreateLabel("Sea: " .. seaName)
InfoLabels.player = InfoTab:CreateLabel("Player: " .. LocalPlayer.Name)
InfoLabels.level = InfoTab:CreateLabel("Level: ?")
InfoLabels.beli = InfoTab:CreateLabel("Beli: ?")
InfoLabels.fragments = InfoTab:CreateLabel("Fragments: ?")

InfoTab:CreateSection("Utility")
InfoTab:CreateButton({ Name = "Rejoin Server", Callback = function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end })
InfoTab:CreateButton({ Name = "Server Hop", Callback = function()
    pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local data = HttpService:JSONDecode(game:HttpGet(url))
        for _, s in ipairs(data.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
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
    for _, c in pairs(codes) do pcall(function() ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end) task.wait(0.2) end
    Notify("Xylene", "Redeemed codes")
end })

-- ═══════════════════════════════════════════════════════════════════════════
-- FOV / WALLCHECK / AIMBOT / PLAYER ESP
-- ═══════════════════════════════════════════════════════════════════════════

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2 FOVCircle.NumSides = 60 FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255) FOVCircle.Visible = false

RunService.RenderStepped:Connect(function()
    local mp = UserInputService:GetMouseLocation()
    FOVCircle.Position = mp
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Visible = Settings.ShowFOV and Settings.AimbotEnabled
end)

local function IsVisible(targetPart)
    if not targetPart then return false end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    local char = LocalPlayer.Character
    rp.FilterDescendantsInstances = char and {char, Camera} or {Camera}
    rp.IgnoreWater = true
    local result = workspace:Raycast(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position), rp)
    if result then return result.Instance:IsDescendantOf(targetPart.Parent) end
    return true
end

local function GetClosestInFOV()
    local closest, shortest = nil, Settings.FOV
    local mp = UserInputService:GetMouseLocation()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local pass = true
                if Settings.AimbotTeamCheck and p.Team and LocalPlayer.Team then
                    pass = (p.Team ~= LocalPlayer.Team)
                end
                if pass then
                    local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local d = (mp - Vector2.new(pos.X, pos.Y)).Magnitude
                        if d < shortest then shortest = d; closest = p end
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Settings.AimbotEnabled then
        local should = (Settings.AimbotMode == "Always On") or
            (Settings.AimbotMode == "Right Click (MB2)" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))
        if should then
            local t = GetClosestInFOV()
            if t and t.Character and t.Character:FindFirstChild("Head") then
                local sp = Camera:WorldToViewportPoint(t.Character.Head.Position)
                local mp = UserInputService:GetMouseLocation()
                pcall(function()
                    mousemoverel((sp.X - mp.X) / Settings.Smoothing, (sp.Y - mp.Y) / Settings.Smoothing)
                end)
            end
        end
    end
end)

local espCache = {}
local function CreatePlayerESP(player)
    espCache[player] = {
        Box = Drawing.new("Square"), HealthBarBg = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"), Name = Drawing.new("Text"),
        DistanceText = Drawing.new("Text")
    }
    for _, d in pairs(espCache[player]) do d.Visible = false end
    espCache[player].Box.Thickness = 1 espCache[player].Box.Filled = false
    espCache[player].HealthBarBg.Filled = true
    espCache[player].HealthBarBg.Color = Color3.fromRGB(0, 0, 0)
    espCache[player].HealthBar.Filled = true
    espCache[player].Name.Size = 14 espCache[player].Name.Center = true
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

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreatePlayerESP(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then CreatePlayerESP(p) end end)

RunService.RenderStepped:Connect(function()
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for player, d in pairs(espCache) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local head = char and char:FindFirstChild("Head")
        if Settings.ESPEnabled and char and root and hum and head and hum.Health > 0 then
            local dist = localRoot and (root.Position - localRoot.Position).Magnitude or 0
            local show = true
            if Settings.ESPTeamCheck and player.Team and LocalPlayer.Team then
                show = (player.Team == LocalPlayer.Team)
            end
            if show and dist <= Settings.ESPRange then
                local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local visible = IsVisible(head)
                    local color = visible and Color3.fromRGB(0, 255, 0) or Settings.ESPPlayerColor
                    local size = Vector2.new(2000/pos.Z, 3000/pos.Z)
                    local bp = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
                    if Settings.ESPBox then d.Box.Size = size d.Box.Position = bp d.Box.Color = color d.Box.Visible = true
                    else d.Box.Visible = false end
                    if Settings.ESPHealth then
                        local hp = math.clamp(hum.Health/hum.MaxHealth, 0, 1)
                        local bh = size.Y * hp
                        d.HealthBarBg.Size = Vector2.new(3, size.Y)
                        d.HealthBarBg.Position = Vector2.new(bp.X - 6, bp.Y)
                        d.HealthBarBg.Visible = true
                        d.HealthBar.Size = Vector2.new(1, bh)
                        d.HealthBar.Position = Vector2.new(bp.X - 5, bp.Y + (size.Y - bh))
                        d.HealthBar.Color = Color3.fromRGB(255 * (1-hp), 255 * hp, 0)
                        d.HealthBar.Visible = true
                    else d.HealthBarBg.Visible = false d.HealthBar.Visible = false end
                    if Settings.ESPName then
                        d.Name.Text = player.Name
                        d.Name.Position = Vector2.new(pos.X, bp.Y - 18)
                        d.Name.Visible = true
                    else d.Name.Visible = false end
                    if Settings.ESPDistance then
                        d.DistanceText.Text = "[" .. math.floor(dist) .. " studs]"
                        d.DistanceText.Position = Vector2.new(pos.X, bp.Y + size.Y + 2)
                        d.DistanceText.Visible = true
                    else d.DistanceText.Visible = false end
                else for _, x in pairs(d) do x.Visible = false end end
            else for _, x in pairs(d) do x.Visible = false end end
        else for _, x in pairs(d) do x.Visible = false end end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- WORLD ESP (BillboardGui)
-- ═══════════════════════════════════════════════════════════════════════════

local ESPNumber = math.random(1, 1000000)
local function round(n) return math.floor(tonumber(n) + 0.5) end

local function createBillboard(parent, name, color)
    if parent:FindFirstChild(name) then return parent[name] end
    local bill = Instance.new("BillboardGui", parent)
    bill.Name = name
    bill.ExtentsOffset = Vector3.new(0, 1, 0)
    bill.Size = UDim2.new(1, 200, 1, 30)
    bill.Adornee = parent
    bill.AlwaysOnTop = true
    local label = Instance.new("TextLabel", bill)
    label.Font = Enum.Font.GothamBold
    label.FontSize = Enum.FontSize.Size14
    label.TextWrapped = true
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.5
    label.TextColor3 = color or Color3.fromRGB(80, 245, 245)
    return bill
end

-- 1. Island ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local locs = workspace._WorldOrigin and workspace._WorldOrigin.Locations
            if not locs then return end
            for _, v in pairs(locs:GetChildren()) do
                if _G.IslandESP and v.Name ~= "Sea" then
                    local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                    if head then
                        local bill = createBillboard(v, "XyleneIsland", Color3.fromRGB(7, 236, 240))
                        bill.TextLabel.Text = v.Name .. "   \n" .. round((head.Position - v.Position).Magnitude/3) .. " Distance"
                    end
                elseif v:FindFirstChild("XyleneIsland") then v.XyleneIsland:Destroy() end
            end
        end)
    end
end)

-- 2. Chest ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetChildren()) do
                if string.find(v.Name, "Chest") then
                    if _G.ChestESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneChest", Color3.fromRGB(109, 109, 109))
                            local d = round((head.Position - v.Position).Magnitude/3)
                            if v.Name == "Chest1" then bill.TextLabel.Text = "Chest 1\n" .. d .. " Distance" bill.TextLabel.TextColor3 = Color3.fromRGB(109, 109, 109)
                            elseif v.Name == "Chest2" then bill.TextLabel.Text = "Chest 2\n" .. d .. " Distance" bill.TextLabel.TextColor3 = Color3.fromRGB(173, 158, 21)
                            elseif v.Name == "Chest3" then bill.TextLabel.Text = "Chest 3\n" .. d .. " Distance" bill.TextLabel.TextColor3 = Color3.fromRGB(85, 255, 255) end
                        end
                    elseif v:FindFirstChild("XyleneChest") then v.XyleneChest:Destroy() end
                end
            end
        end)
    end
end)

-- 3. Devil Fruit ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetChildren()) do
                if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                    if _G.DevilFruitESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v.Handle, "XyleneDevilFruit", Color3.fromRGB(255, 255, 255))
                            bill.TextLabel.Text = v.Name .. "\n" .. round((head.Position - v.Handle.Position).Magnitude/3) .. " Distance"
                        end
                    elseif v.Handle:FindFirstChild("XyleneDevilFruit") then v.Handle.XyleneDevilFruit:Destroy() end
                end
            end
        end)
    end
end)

-- 4. Flower ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Flower1" or v.Name == "Flower2" then
                    if _G.FlowerESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneFlower", Color3.fromRGB(255, 0, 0))
                            local d = round((head.Position - v.Position).Magnitude/3)
                            if v.Name == "Flower1" then bill.TextLabel.Text = "Blue Flower\n" .. d .. " Distance" bill.TextLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
                            else bill.TextLabel.Text = "Red Flower\n" .. d .. " Distance" bill.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0) end
                        end
                    elseif v:FindFirstChild("XyleneFlower") then v.XyleneFlower:Destroy() end
                end
            end
        end)
    end
end)

-- 5. Real Fruit ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local spawners = {
                {folder="AppleSpawner", color=Color3.fromRGB(255, 0, 0)},
                {folder="PineappleSpawner", color=Color3.fromRGB(255, 174, 0)},
                {folder="BananaSpawner", color=Color3.fromRGB(251, 255, 0)}
            }
            for _, sp in ipairs(spawners) do
                local folder = workspace:FindFirstChild(sp.folder)
                if folder then
                    for _, v in pairs(folder:GetChildren()) do
                        if v:IsA("Tool") and v:FindFirstChild("Handle") then
                            if _G.RealFruitESP then
                                local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                                if head then
                                    local bill = createBillboard(v.Handle, "XyleneRealFruit", sp.color)
                                    bill.TextLabel.Text = v.Name .. "\n" .. round((head.Position - v.Handle.Position).Magnitude/3) .. " Distance"
                                end
                            elseif v.Handle:FindFirstChild("XyleneRealFruit") then v.Handle.XyleneRealFruit:Destroy() end
                        end
                    end
                end
            end
        end)
    end
end)

-- 6. Mob ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local enemies = workspace:FindFirstChild("Enemies")
            if not enemies then return end
            for _, v in pairs(enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    if _G.MobESP then
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local bill = createBillboard(v, "XyleneMob", Color3.fromRGB(7, 236, 240))
                            bill.Size = UDim2.new(0, 200, 0, 50)
                            bill.StudsOffset = Vector3.new(0, 2.5, 0)
                            bill.TextLabel.Text = v.Name .. " - " .. math.floor((hrp.Position - v.HumanoidRootPart.Position).Magnitude) .. " Distance"
                        end
                    elseif v:FindFirstChild("XyleneMob") then v.XyleneMob:Destroy() end
                end
            end
        end)
    end
end)

-- 7. Sea Beast ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local sb = workspace:FindFirstChild("SeaBeasts")
            if not sb then return end
            for _, v in pairs(sb:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    if _G.SeaBeastESP then
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local bill = createBillboard(v, "XyleneSeaBeast", Color3.fromRGB(7, 236, 240))
                            bill.Size = UDim2.new(0, 200, 0, 50)
                            bill.StudsOffset = Vector3.new(0, 2.5, 0)
                            bill.TextLabel.Text = v.Name .. " - " .. math.floor((hrp.Position - v.HumanoidRootPart.Position).Magnitude) .. " Distance"
                        end
                    elseif v:FindFirstChild("XyleneSeaBeast") then v.XyleneSeaBeast:Destroy() end
                end
            end
        end)
    end
end)

-- 8. NPC ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local npcs = workspace:FindFirstChild("NPCs")
            if not npcs then return end
            for _, v in pairs(npcs:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    if _G.NpcESP then
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local bill = createBillboard(v, "XyleneNpc", Color3.fromRGB(7, 236, 240))
                            bill.Size = UDim2.new(0, 200, 0, 50)
                            bill.StudsOffset = Vector3.new(0, 2.5, 0)
                            bill.TextLabel.Text = v.Name .. " - " .. math.floor((hrp.Position - v.HumanoidRootPart.Position).Magnitude) .. " Distance"
                        end
                    elseif v:FindFirstChild("XyleneNpc") then v.XyleneNpc:Destroy() end
                end
            end
        end)
    end
end)

-- 9. Mirage Island ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local locs = workspace._WorldOrigin and workspace._WorldOrigin.Locations
            if not locs then return end
            for _, v in pairs(locs:GetChildren()) do
                if v.Name == "Mirage Island" then
                    if _G.MirageIslandESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneMirage", Color3.fromRGB(80, 245, 245))
                            bill.TextLabel.Text = v.Name .. "\n" .. round((head.Position - v.Position).Magnitude/3) .. " M"
                        end
                    elseif v:FindFirstChild("XyleneMirage") then v.XyleneMirage:Destroy() end
                end
            end
        end)
    end
end)

-- 10. Aura NPC ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local npcs = workspace:FindFirstChild("NPCs")
            if not npcs then return end
            for _, v in pairs(npcs:GetChildren()) do
                if v.Name == "Master of Enhancement" then
                    if _G.AuraESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneAura", Color3.fromRGB(80, 245, 245))
                            bill.TextLabel.Text = v.Name .. "\n" .. round((head.Position - v.Position).Magnitude/3) .. " M"
                        end
                    elseif v:FindFirstChild("XyleneAura") then v.XyleneAura:Destroy() end
                end
            end
        end)
    end
end)

-- 11. LSD ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local npcs = workspace:FindFirstChild("NPCs")
            if not npcs then return end
            for _, v in pairs(npcs:GetChildren()) do
                if v.Name == "Legendary Sword Dealer" then
                    if _G.LSDESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneLSD", Color3.fromRGB(80, 245, 245))
                            bill.TextLabel.Text = v.Name .. "\n" .. round((head.Position - v.Position).Magnitude/3) .. " M"
                        end
                    elseif v:FindFirstChild("XyleneLSD") then v.XyleneLSD:Destroy() end
                end
            end
        end)
    end
end)

-- 12. Mirage Gear ESP
task.spawn(function()
    while wait(0.5) do
        pcall(function()
            local mystic = workspace.Map and workspace.Map:FindFirstChild("MysticIsland")
            if not mystic then return end
            for _, v in pairs(mystic:GetChildren()) do
                if v.Name == "MeshPart" then
                    if _G.MirageGearESP then
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if head then
                            local bill = createBillboard(v, "XyleneGear", Color3.fromRGB(80, 245, 245))
                            bill.TextLabel.Text = "Gear\n" .. round((head.Position - v.Position).Magnitude/3) .. " M"
                        end
                    elseif v:FindFirstChild("XyleneGear") then v.XyleneGear:Destroy() end
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- FARMING LOOPS
-- ═══════════════════════════════════════════════════════════════════════════

if InBloxFruits then
    -- Auto Farm Level
    task.spawn(function()
        while wait(0.05) do
            if _G.AutoLevel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local Ms, NQ, QL, CQ = CheckLevel()
                    if not Ms then return end
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    local hasQuest = LocalPlayer.PlayerGui.Main.Quest.Visible and
                        string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text or "", Ms)
                    if not hasQuest then
                        SetFlyAnchor(false)
                        local d = (hrp.Position - CQ.Position).Magnitude
                        if d > 25 then SafeTween(CQ) else
                            StopTween() hrp.CFrame = CQ
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NQ, QL)
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
                            local mh = target.HumanoidRootPart
                            local d = (hrp.Position - mh.Position).Magnitude
                            local tp = CFrame.new(mh.Position + Vector3.new(0, 30, 0), mh.Position)
                            if d > 40 then SetFlyAnchor(false) SafeTween(tp) else
                                StopTween() SetFlyAnchor(true)
                                hrp.CFrame = tp hrp.Velocity = Vector3.zero
                                BringMobs(Ms, mh.CFrame)
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        else SetFlyAnchor(false) end
                    end
                end)
            end
        end
    end)

    -- Auto Near
    task.spawn(function()
        while wait(0.05) do
            if _G.AutoNear and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local d = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            if d <= 5000 then
                                local tp = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 30, 0), v.HumanoidRootPart.Position)
                                if d > 40 then SetFlyAnchor(false) SafeTween(tp) else
                                    StopTween() SetFlyAnchor(true)
                                    hrp.CFrame = tp
                                    BringMobs(v.Name, v.HumanoidRootPart.CFrame)
                                    EquipTool(_G.SelectWeapon) Attack()
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
            if _G.AutoBoss and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.Humanoid.Health > 0 then
                pcall(function()
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    AutoHaki()
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == _G.SelectedBoss and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local d = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            local tp = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 25, 0), v.HumanoidRootPart.Position)
                            if d > 40 then SetFlyAnchor(false) SafeTween(tp) else
                                StopTween() SetFlyAnchor(true)
                                hrp.CFrame = tp
                                v.HumanoidRootPart.CanCollide = false
                                EquipTool(_G.SelectWeapon) Attack()
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
                            local d = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                            local tp = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 30, 0), v.HumanoidRootPart.Position)
                            if d > 40 then SetFlyAnchor(false) SafeTween(tp) else
                                StopTween() SetFlyAnchor(true)
                                hrp.CFrame = tp
                                BringMobs(_G.SelectedMob, v.HumanoidRootPart.CFrame)
                                EquipTool(_G.SelectWeapon) Attack()
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
            if _G.AutoChest and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
                            if ChestCountLabel then ChestCountLabel:Set("Chests: " .. _G.ChestsCollected) end
                            task.wait(0.25)
                        end
                    end
                end)
            end
        end
    end)

    -- Fruit Sniper + Store
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
                                        SendDiscordWebhook("Fruit Collected", obj.Name, 16753920, {{name="Fruit",value=obj.Name,inline=true}})
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

    -- Magnet
    task.spawn(function()
        while wait(0.5) do
            if _G.AutoMagnet and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
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
        while wait(3) do if _G.AutoHaki then pcall(AutoHaki) end end
    end)

    -- Haki Fortress
    task.spawn(function()
        while wait(0.5) do
            if _G.HakiFortress then
                pcall(function()
                    local function eqAuraSkin(name, pos)
                        local args = {{StorageName = name, Type = "AuraSkin", Context = "Equip"}}
                        pcall(function() ReplicatedStorage.Modules.Net:FindFirstChild("RF/FruitCustomizerRF"):InvokeServer(unpack(args)) end)
                        SafeTween(CFrame.new(pos))
                    end
                    eqAuraSkin("Snow White", Vector3.new(-4971.71, 335.95, -3720.05))
                    task.wait(1)
                    eqAuraSkin("Pure Red", Vector3.new(-5414.92, 314.25, -2212.20))
                    task.wait(1)
                    eqAuraSkin("Winter Sky", Vector3.new(-5420.26, 1089.35, -2666.81))
                    task.wait(1)
                    _G.HakiFortress = false
                    Notify("Xylene", "Haki Fortress complete!")
                end)
            end
        end
    end)

    -- Kitsune Ember + Pray
    task.spawn(function()
        while wait(0.3) do
            if _G.AutoCollectEmbers then
                pcall(function()
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

    -- Race V4 + Mirage Gear
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
                            SafeTween(obj.CFrame, 350) Notify("Xylene", "Mirage Gear found!") break
                        end
                    end
                end
            end)
        end
    end)

    -- Auto Lock Moon
    task.spawn(function()
        while wait(0.1) do
            if _G.AutoLockMoon then
                pcall(function()
                    local md = game.Lighting:GetMoonDirection()
                    local la = workspace.CurrentCamera.CFrame.p + md * 100
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.p, la)
                    local CommE = ReplicatedStorage.Remotes:FindFirstChild("CommE")
                    if CommE then CommE:FireServer("ActivateAbility") end
                end)
            end
        end
    end)

    -- Sea Events
    task.spawn(function()
        while wait(0.5) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    if _G.AutoLeviathan then
                        local sb = workspace:FindFirstChild("SeaBeasts")
                        if sb then for _, b in ipairs(sb:GetChildren()) do
                            if string.find(b.Name, "Leviathan") and b:FindFirstChild("HumanoidRootPart") then
                                SafeTween(b.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        end end
                    end
                    if _G.AutoSeaBeast then
                        local sb = workspace:FindFirstChild("SeaBeasts") or workspace:FindFirstChild("Enemies")
                        if sb then for _, b in ipairs(sb:GetChildren()) do
                            if string.find(b.Name, "SeaBeast") and b:FindFirstChild("HumanoidRootPart") then
                                SafeTween(b.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0))
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        end end
                    end
                    if _G.AutoShipRaid then
                        local boats = workspace:FindFirstChild("Boats") or workspace:FindFirstChild("Enemies")
                        if boats then for _, b in ipairs(boats:GetChildren()) do
                            if string.find(b.Name, "Brigade") or string.find(b.Name, "Ship") then
                                local h = b:FindFirstChild("HumanoidRootPart") or b:FindFirstChildOfClass("BasePart")
                                if h then SafeTween(h.CFrame * CFrame.new(0, 25, 0)) EquipTool(_G.SelectWeapon) Attack() end
                            end
                        end end
                    end
                    if _G.AutoTerrorshark then
                        for _, b in ipairs(workspace.Enemies:GetChildren()) do
                            if b.Name == "Terrorshark" and b:FindFirstChild("HumanoidRootPart") then
                                SafeTween(b.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        end
                    end
                    if _G.farmpiranya then
                        for _, b in ipairs(workspace.Enemies:GetChildren()) do
                            if b.Name == "Piranha" and b:FindFirstChild("HumanoidRootPart") then
                                SafeTween(b.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        end
                    end
                    if _G.AutoShark then
                        for _, b in ipairs(workspace.Enemies:GetChildren()) do
                            if b.Name == "Shark" and b:FindFirstChild("HumanoidRootPart") then
                                SafeTween(b.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                EquipTool(_G.SelectWeapon) Attack()
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Cake Prince / Dough King
    if Third_Sea then
        task.spawn(function()
            while wait(0.5) do
                pcall(function()
                    if _G.SpawnCakePrince then
                        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true) end)
                        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner") end)
                    end
                end)
            end
        end)
        task.spawn(function()
            while wait(0.5) do
                if _G.CakePrince then
                    pcall(function()
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Cake Prince" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat
                                    wait(_G.Fast_Delay)
                                    Attack() AutoHaki() EquipTool(_G.SelectWeapon)
                                    TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)}):Play()
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                until not _G.CakePrince or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while wait(0.5) do
                if _G.DoughKing then
                    pcall(function()
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Dough King" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat
                                    wait(_G.Fast_Delay)
                                    Attack() AutoHaki() EquipTool(_G.SelectWeapon)
                                    TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)}):Play()
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                until not _G.DoughKing or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end)
                end
            end
        end)
    end

    -- Elite Hunter
    if Third_Sea then
        task.spawn(function()
            while wait(0.5) do
                if _G.AutoElite then
                    pcall(function()
                        local qt = LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text or ""
                        if not LocalPlayer.PlayerGui.Main.Quest.Visible or (not string.find(qt, "Diablo") and not string.find(qt, "Deandre") and not string.find(qt, "Urban")) then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                        end
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if (v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat
                                    wait(_G.Fast_Delay)
                                    Attack() AutoHaki() EquipTool(_G.SelectWeapon)
                                    TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)}):Play()
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                until not _G.AutoElite or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end)
                end
            end
        end)
    end

    -- Auto Sail Sea 2
    if First_Sea then
        task.spawn(function()
            while wait(0.5) do
                if _G.AutoSailSea2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        if LocalPlayer.Data.Level.Value < 700 then
                            Notify("Xylene", "Need Level 700+ for Sea 2")
                            _G.AutoSailSea2 = false return
                        end
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        AutoHaki()
                        local hasKey = LocalPlayer.Backpack:FindFirstChild("Key") or LocalPlayer.Character:FindFirstChild("Key")
                        if not hasKey then
                            SafeTween(CFrame.new(4849.29883, 5.65138149, 719.611877))
                            if (hrp.Position - Vector3.new(4849.29883, 5.65138149, 719.611877)).Magnitude <= 10 then
                                task.wait(0.5)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                                task.wait(0.5)
                                EquipTool("Key")
                            end
                        end
                        local ia = workspace.Enemies:FindFirstChild("Ice Admiral")
                        if ia and ia:FindFirstChild("Humanoid") and ia.Humanoid.Health > 0 then
                            repeat
                                task.wait(_G.Fast_Delay)
                                Attack() AutoHaki() EquipTool(_G.SelectWeapon)
                                ia.HumanoidRootPart.CanCollide = false
                                ia.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                TweenService:Create(hrp, TweenInfo.new(0.3), {CFrame = ia.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)}):Play()
                            until not _G.AutoSailSea2 or not ia.Parent or ia.Humanoid.Health <= 0
                        elseif ReplicatedStorage:FindFirstChild("Ice Admiral") then
                            SafeTween(ReplicatedStorage:FindFirstChild("Ice Admiral").HumanoidRootPart.CFrame * CFrame.new(5,10,7))
                        elseif workspace.Map.Ice.Door and (workspace.Map.Ice.Door.CanCollide == false or workspace.Map.Ice.Door.Transparency == 1) then
                            SafeTween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            if (hrp.Position - Vector3.new(1347.7124, 37.3751602, -1325.6488)).Magnitude <= 3 then
                                task.wait(1)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                                _G.AutoSailSea2 = false
                                Notify("Xylene", "Sailed to Sea 2!")
                            end
                        end
                    end)
                end
            end
        end)
    end

    -- Auto Sail Sea 3
    if Second_Sea then
        task.spawn(function()
            while wait(0.5) do
                if _G.AutoSailSea3 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        if LocalPlayer.Data.Level.Value < 1500 then
                            Notify("Xylene", "Need Level 1500+ for Sea 3")
                            _G.AutoSailSea3 = false return
                        end
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        AutoHaki()
                        if ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
                            SafeTween(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                            if (hrp.Position - Vector3.new(-1926.3221435547, 12.819851875305, 1738.3092041016)).Magnitude <= 10 then
                                task.wait(1.5)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                            end
                        end
                        local ri = workspace.Enemies:FindFirstChild("rip_indra")
                        if ri and ri:FindFirstChild("Humanoid") and ri.Humanoid.Health > 0 then
                            repeat
                                task.wait(_G.Fast_Delay)
                                Attack() AutoHaki() EquipTool(_G.SelectWeapon)
                                ri.HumanoidRootPart.CanCollide = false
                                ri.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                TweenService:Create(hrp, TweenInfo.new(0.3), {CFrame = ri.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)}):Play()
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                            until not _G.AutoSailSea3 or not ri.Parent or ri.Humanoid.Health <= 0
                            _G.AutoSailSea3 = false
                            Notify("Xylene", "Sailed to Sea 3!")
                        else
                            SafeTween(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                        end
                    end)
                end
            end
        end)
    end

    -- Boat Autopilot
    if Third_Sea then
        local function getSeat()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            for _, boat in pairs(workspace.Boats:GetChildren()) do
                local seat = boat:FindFirstChild("VehicleSeat")
                if seat and seat.Occupant == hum then return seat end
            end
            return nil
        end
        task.spawn(function()
            while wait(0.5) do
                if _G.AutoFindPrehistoric or _G.AutoFindMirage or _G.AutoFindFrozen then
                    pcall(function()
                        local seat = getSeat()
                        if not seat then
                            for _, boat in pairs(workspace.Boats:GetChildren()) do
                                local s = boat:FindFirstChild("VehicleSeat")
                                if s and not s.Occupant then SafeTween(s.CFrame) break end
                            end
                            return
                        end
                        seat.MaxSpeed = _G.BoatTweenSpeed
                        VirtualInputManager:SendKeyEvent(true, "W", false, game)
                        for _, name in ipairs({"ShipwreckIsland","SandIsland","TreeIsland","TinyIsland","MysticIsland","KitsuneIsland","FrozenDimension","PrehistoricIsland"}) do
                            local obj = workspace.Map:FindFirstChild(name)
                            if obj and obj:IsA("Model") then obj:Destroy() end
                        end
                        local target
                        if _G.AutoFindPrehistoric then target = workspace.Map:FindFirstChild("PrehistoricIsland") end
                        if _G.AutoFindMirage then target = workspace.Map:FindFirstChild("MysticIsland") end
                        if _G.AutoFindFrozen then target = workspace.Map:FindFirstChild("FrozenDimension") end
                        if target then
                            VirtualInputManager:SendKeyEvent(false, "W", false, game)
                            _G.AutoFindPrehistoric = false
                            _G.AutoFindMirage = false
                            _G.AutoFindFrozen = false
                            Notify("Xylene", "Island found!")
                        end
                    end)
                end
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- WORLD LOOPS
-- ═══════════════════════════════════════════════════════════════════════════

-- Noclip
RunService.Stepped:Connect(function()
    if _G.Noclip or _G.AutoLevel or _G.AutoChest or _G.AutoBoss or _G.AutoNear or _G.AutoFarmSelectedMob then
        pcall(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                end
            end
        end)
    end
end)

-- No Slow
task.spawn(function()
    while wait(0.5) do
        if _G.NoSlow then
            pcall(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed < 16 and not _G.SpeedHack then hum.WalkSpeed = 16 end
            end)
        end
    end
end)

-- Auto Retreat
task.spawn(function()
    while wait(0.5) do
        if _G.AutoRetreat and _G.SavedPosition then
            pcall(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.MaxHealth > 0 and hum.Health / hum.MaxHealth * 100 <= _G.RetreatHP then
                    hrp.CFrame = _G.SavedPosition
                end
            end)
        end
    end
end)

-- Nearby Notifier
task.spawn(function()
    while wait(4) do
        if _G.NearbyNotif and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local pr = p.Character:FindFirstChild("HumanoidRootPart")
                        if pr then
                            local d = (hrp.Position - pr.Position).Magnitude
                            if d <= _G.NearbyRange then Notify("Nearby!", p.Name .. " - " .. math.floor(d) .. "m") end
                        end
                    end
                end
            end)
        end
    end
end)

-- Fruit Notifier
task.spawn(function()
    while wait(5) do
        if _G.FruitNotif and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if (obj:IsA("Model") or obj:IsA("BasePart")) and obj.Name:lower():find("fruit") then
                        local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position) or obj.Position
                        if pos then
                            local d = (hrp.Position - pos).Magnitude
                            if d < 300 then Notify("Fruit!", obj.Name .. " - " .. math.floor(d) .. " studs") end
                        end
                    end
                end
            end)
        end
    end
end)

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Info labels
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

-- Character respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if _G.SpeedHack then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = _G.SpeedValue end
    end
    if _G.JumpPower and _G.JumpPower ~= 50 then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = _G.JumpPower end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- LOADED
-- ═══════════════════════════════════════════════════════════════════════════

Rayfield:Notify({
    Title = "Xylene v2.0 Ultimate",
    Content = "Loaded! 130+ features across all tabs.",
    Duration = 5
})

Rayfield:LoadConfiguration()
print("Xylene v2.0 Ultimate loaded successfully.")
