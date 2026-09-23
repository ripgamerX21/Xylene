-- ═══════════════════════════════════════════════════════════════════════════
-- Anti-Cheat Bypass: SafeTween, SafeTeleport, Rate Limiter
-- ═══════════════════════════════════════════════════════════════════════════

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Rate limiter
local lastAction = 0
local COOLDOWN = 0.05

-- Safe Tween (avoids anticheat detection by using proper velocity)
local activeTween = nil
local lastTarget = nil

function SafeTween(targetCFrame, speed)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local spd = speed or _G.TweenSpeed or 280
    local distance = (hrp.Position - targetCFrame.Position).Magnitude

    -- Too close, snap directly
    if distance <= 15 then
        hrp.CFrame = targetCFrame
        return
    end

    -- Already tweening to same target
    if lastTarget and (lastTarget.Position - targetCFrame.Position).Magnitude < 10 and activeTween then
        return activeTween
    end

    -- Cancel previous
    if activeTween then
        pcall(function() activeTween:Cancel() end)
    end

    lastTarget = targetCFrame
    activeTween = TweenService:Create(
        hrp,
        TweenInfo.new(distance / spd, Enum.EasingStyle.Linear),
        {CFrame = targetCFrame}
    )
    activeTween:Play()

    activeTween.Completed:Connect(function()
        lastTarget = nil
        activeTween = nil
    end)

    return activeTween
end

-- Alias used by Banana modules
function Tween2(targetCFrame, speed)
    SafeTween(targetCFrame, speed)
end

-- Safe Teleport (snap with anti-fall anchor)
function SafeTeleport(targetCFrame)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
end

-- Fly anchor (prevents falling while hovering)
function SetFlyAnchor(enabled)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local existing = hrp:FindFirstChild("Xylene_FlyVelocity")
    if enabled then
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

-- Cancel tween
function CancelTween()
    if activeTween then
        pcall(function() activeTween:Cancel() end)
        activeTween = nil
        lastTarget = nil
    end
    SetFlyAnchor(false)
end

-- Rate limiter check
function IsRateLimited()
    if tick() - lastAction < COOLDOWN then return true end
    lastAction = tick()
    return false
end

_G.SafeTween = SafeTween
_G.SafeTeleport = SafeTeleport
_G.SetFlyAnchor = SetFlyAnchor
_G.CancelTween = CancelTween
