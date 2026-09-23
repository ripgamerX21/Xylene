-- ═══════════════════════════════════════════════════════════════════════════
-- Sea Detection + Anti-Idle
-- ═══════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Sea Detection
local PlaceId = game.PlaceId
_G.Sea1 = PlaceId == 2753915549
_G.Sea2 = PlaceId == 4442272183
_G.Sea3 = PlaceId == 7449423635

-- Aliases for compatibility
Sea1 = _G.Sea1
Sea2 = _G.Sea2
Sea3 = _G.Sea3
World1 = _G.Sea1
World2 = _G.Sea2

if not _G.Sea1 and not _G.Sea2 and not _G.Sea3 then
    _G.Window:Dialog({
        Title = "Unsupported Game",
        Content = "Xylene only supports Blox Fruits. This game is not recognized."
    })
    return
end

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

print("[Xylene] Sea detected: " .. (_G.Sea1 and "First Sea" or _G.Sea2 and "Second Sea" or "Third Sea"))
