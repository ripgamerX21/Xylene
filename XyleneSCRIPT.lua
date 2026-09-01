-- Xylene – Delta Compatible Version
-- Simplified for better execution

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

if not First_Sea and not Second_Sea and not Third_Sea then
    game:Shutdown()
end

-- Main Window
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

local Tabs = {
    Main = Window:CreateTab("Main"),
    Sea = Window:CreateTab("Sea"),
    Boss = Window:CreateTab("Boss"),
    Material = Window:CreateTab("Material"),
    Raid = Window:CreateTab("Raid"),
    Race = Window:CreateTab("Race"),
    Teleport = Window:CreateTab("Teleport"),
    Stats = Window:CreateTab("Stats"),
    ESP = Window:CreateTab("ESP"),
    Misc = Window:CreateTab("Misc")
}

-- UI Elements
Tabs.Main:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(v) _G.AutoLevel = v end
})

Tabs.Main:CreateToggle({
    Name = "Auto Kill Near Mobs",
    CurrentValue = false,
    Callback = function(v) _G.AutoNear = v end
})

-- Notifications
Rayfield:Notify({
    Title = "Xylene",
    Content = "Script loaded successfully!",
    Duration = 3
})

print("Xylene loaded.")
