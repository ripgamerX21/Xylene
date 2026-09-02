-- Xylene – Blox Fruits Script
-- Loaded from: https://flowauth.net/v1/loaders/05bb09f33fbc8fb7fc14f8348fa26484.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Library = Rayfield

local Window = Library:CreateWindow({
    Name = "Xylene",
    LoadingTitle = "Xylene",
    LoadingSubtitle = "Blox Fruits Script",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Xylene",
        FileName = "Settings"
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main")
local TeleportTab = Window:CreateTab("Teleport")
local MiscTab = Window:CreateTab("Misc")

-- Variables
local plr = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
_G.AutoFarm = false
_G.AutoStats = false

-- Functions
local function AutoHaki()
    if not plr.Character:FindFirstChild("HasBuso") then
        pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("Buso") end)
    end
end

local function EquipTool(weapon)
    if not plr.Character then return end
    if plr.Character:FindFirstChild(weapon) then return end
    if plr.Backpack:FindFirstChild(weapon) then
        plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(weapon))
    end
end

local function Attack()
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
    end)
end

-- UI
MainTab:CreateSection("Farming")

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(v) _G.AutoFarm = v end
})

MainTab:CreateToggle({
    Name = "Auto Stats",
    CurrentValue = false,
    Callback = function(v) _G.AutoStats = v end
})

MainTab:CreateDropdown({
    Name = "Weapon",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = "Melee",
    Callback = function(v) _G.SelectWeapon = v end
})

TeleportTab:CreateSection("Teleport")

TeleportTab:CreateButton({
    Name = "Teleport to First Sea",
    Callback = function()
        replicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Second Sea",
    Callback = function()
        replicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Third Sea",
    Callback = function()
        replicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
    end
})

MiscTab:CreateSection("Misc")

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, plr)
    end
})

MiscTab:CreateButton({
    Name = "FPS Booster",
    Callback = function()
        settings().Rendering.QualityLevel = "Level01"
        game.Lighting.GlobalShadows = false
    end
})

Rayfield:Notify({
    Title = "Xylene",
    Content = "Script loaded successfully!",
    Duration = 3
})

-- Farming Loop
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 5000 then
                            repeat
                                wait(0.9)
                                AutoHaki()
                                EquipTool(_G.SelectWeapon or "Melee")
                                local tween = game:GetService("TweenService"):Create(
                                    plr.Character.HumanoidRootPart,
                                    TweenInfo.new(1, Enum.EasingStyle.Linear),
                                    {CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)}
                                )
                                tween:Play()
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                Attack()
                            until not _G.AutoFarm or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

-- Stats Loop
spawn(function()
    while wait() do
        if _G.AutoStats then
            pcall(function()
                replicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
                replicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 3)
            end)
        end
    end
end)

print("Xylene loaded.")
