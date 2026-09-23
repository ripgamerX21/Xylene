-- ═══════════════════════════════════════════════════════════════════════════
-- Xylene UI Core
-- Uses Fluent UI
-- ═══════════════════════════════════════════════════════════════════════════

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Xylene | Blox Fruits",
    SubTitle = "Universal Script Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Home      = Window:AddTab({ Title = "Home",       Icon = "home" }),
    Main      = Window:AddTab({ Title = "Main",       Icon = "sword" }),
    Sea       = Window:AddTab({ Title = "Sea",        Icon = "anchor" }),
    ITM       = Window:AddTab({ Title = "ITM",        Icon = "shopping-cart" }),
    Setting   = Window:AddTab({ Title = "Settings",   Icon = "settings" }),
    Status    = Window:AddTab({ Title = "Status",     Icon = "activity" }),
    Stats     = Window:AddTab({ Title = "Stats",      Icon = "plus-circle" }),
    Player    = Window:AddTab({ Title = "Player",     Icon = "user" }),
    Teleport  = Window:AddTab({ Title = "Teleport",   Icon = "map-pin" }),
    Visual    = Window:AddTab({ Title = "Visual",     Icon = "eye" }),
    Fruit     = Window:AddTab({ Title = "Fruit",      Icon = "apple" }),
    Raid      = Window:AddTab({ Title = "Raid",       Icon = "zap" }),
    Race      = Window:AddTab({ Title = "Race",       Icon = "chevrons-right" }),
    Shop      = Window:AddTab({ Title = "Shop",       Icon = "shopping-bag" }),
    Misc      = Window:AddTab({ Title = "Misc",       Icon = "list-plus" })
}

local Options = Fluent.Options

-- Expose globally for all modules
_G.Fluent = Fluent
_G.Window = Window
_G.Tabs = Tabs
_G.Options = Options
_G.SaveManager = SaveManager
_G.InterfaceManager = InterfaceManager

Fluent:Notify({
    Title = "Xylene",
    Content = "UI loaded successfully!",
    SubContent = "Loading modules...",
    Duration = 5
})
