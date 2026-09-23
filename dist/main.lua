-- ═══════════════════════════════════════════════════════════════════════════
-- main.lua
-- Xylene | Blox Fruits
-- ═══════════════════════════════════════════════════════════════════════════
-- How to execute:
--   loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/Xylene/main/dist/main.lua"))()
-- ═══════════════════════════════════════════════════════════════════════════

local BASE = "https://raw.githubusercontent.com/YOUR_USERNAME/Xylene/main/dist/"

local function Load(path)
    local ok, err = pcall(function()
        loadstring(game:HttpGet(BASE .. path))()
    end)
    if not ok then
        warn("[Xylene] Error loading " .. path .. ": " .. tostring(err))
    end
end

-- ── CORE: UI ──────────────────────────────────────────
Load("src/core/ui/init.lua")           -- UI, Window, all Tabs

-- ── CORE: DETECTION ───────────────────────────────────
Load("src/core/detection/sea.lua")     -- Sea1/Sea2/Sea3 detection + Anti-idle
Load("src/core/detection/anticheat.lua") -- Anti-cheat bypass: SafeTween, SafeTeleport, Rate Limiter

-- ── CORE: DATA ────────────────────────────────────────
Load("src/core/data/data.lua")         -- CheckLevel, CheckBossQuest, MaterialMon, tableMon

-- ── CORE: ESP ─────────────────────────────────────────
Load("src/core/esp/esp.lua")           -- All ESP functions (Island, Player, Chest, Fruit...)

-- ── CORE: UTILS ───────────────────────────────────────
Load("src/core/utils/utils.lua")       -- Tween, EquipTool, AutoHaki, BodyClip, etc.

-- ── TABS: INFO ────────────────────────────────────────
Load("src/tabs/info/home.lua")         -- Home Tab
Load("src/tabs/info/status.lua")       -- Status & Server Tab
Load("src/tabs/info/stats.lua")        -- Stats Tab (Auto Stats)

-- ── TABS: FARM ────────────────────────────────────────
Load("src/tabs/farm/farm.lua")         -- Farm Tab (AutoLevel, AutoBoss, Material, Kitsune, Saber...)
Load("src/tabs/farm/setting.lua")      -- Farm Settings Tab
Load("src/tabs/farm/sea_events.lua")   -- Sea Events Tab

-- ── TABS: PLAYER ──────────────────────────────────────
Load("src/tabs/player/player.lua")     -- Player Tab
Load("src/tabs/player/teleport.lua")   -- Teleport Tab
Load("src/tabs/player/visual.lua")     -- Visual Tab

-- ── TABS: COMBAT ──────────────────────────────────────
Load("src/tabs/combat/raid.lua")       -- Raid Tab
Load("src/tabs/combat/race.lua")       -- Race Upgrade Tab

-- ── TABS: OTHER ───────────────────────────────────────
Load("src/tabs/other/fruit.lua")       -- Fruit ESP & Fruit Tab
Load("src/tabs/other/shop.lua")        -- Shop Tab
Load("src/tabs/other/misc.lua")        -- Misc Tab

print("[Xylene] Loaded!")
