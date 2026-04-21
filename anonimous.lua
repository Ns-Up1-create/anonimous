-- ============================================================
--  ⚡ hackeado TONTO JAJAJAJA HUB MATRIX ⚡  |  by anonimous
--  Versión ROTA con Rayfield UI + Hitbox REAL 50x50x50
-- ============================================================

-- [0] INTRO MATRIX MORADA
local function RunMatrixIntro()
    local ScreenGui = Instance.new("ScreenGui")
    local Blackout = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Subtitle = Instance.new("TextLabel")
    
    ScreenGui.Name = "hackado tonto HAHAHA"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Blackout.Size = UDim2.new(1, 0, 1, 0)
    Blackout.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Blackout.BorderSizePixel = 0
    Blackout.Parent = ScreenGui
    
    Title.Size = UDim2.new(1, 0, 0.5, 0)
    Title.Position = UDim2.new(0, 0, 0.25, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "⚡ hackeado tonto haahahah ⚡"
    Title.TextColor3 = Color3.fromRGB(138, 43, 226)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 48
    Title.TextStrokeTransparency = 0
    Title.TextStrokeColor3 = Color3.fromRGB(75, 0, 130)
    Title.ZIndex = 100
    Title.Parent = Blackout

    Subtitle.Size = UDim2.new(1, 0, 0.1, 0)
    Subtitle.Position = UDim2.new(0, 0, 0.6, 0)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "by mini | tonto ez"
    Subtitle.TextColor3 = Color3.fromRGB(255, 0, 255)
    Subtitle.Font = Enum.Font.Code
    Subtitle.TextSize = 18
    Subtitle.Parent = Blackout

    task.spawn(function()
        for i = 1, 150 do
            task.spawn(function()
                while Blackout.Parent do
                    local m = Instance.new("TextLabel")
                    m.Text = tostring(math.random(0, 9))
                    m.Position = UDim2.new(math.random(), 0, math.random(), 0)
                    m.BackgroundTransparency = 1
                    m.TextColor3 = Color3.fromRGB(math.random(100, 200), 0, math.random(150, 255))
                    m.Font = Enum.Font.Code
                    m.TextSize = math.random(14, 24)
                    m.TextTransparency = 1
                    m.Parent = Blackout
                    
                    local duration = math.random(5, 15) / 10
                    game:GetService("TweenService"):Create(m, TweenInfo.new(duration/2), {TextTransparency = 0}):Play()
                    task.wait(duration)
                    game:GetService("TweenService"):Create(m, TweenInfo.new(duration/2), {TextTransparency = 1}):Play()
                    game:GetService("Debris"):AddItem(m, duration)
                    task.wait(math.random(1, 5) / 10)
                end
            end)
        end
        
        task.wait(5)
        local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
        game:GetService("TweenService"):Create(Blackout, fadeInfo, {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(Title, fadeInfo, {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(Subtitle, fadeInfo, {TextTransparency = 1}):Play()
        task.wait(1)
        ScreenGui:Destroy()
    end)
end

RunMatrixIntro()
task.wait(6)

-- [1] SERVICIOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- [2] BYPASSES SUPREMOS
repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Util")
pcall(function()
    local ss = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
    local noop = function() return nil end
    ss.StartShake = noop; ss.ShakeOnce = noop; ss.ShakeSustain = noop
    ss.CamerShakeInstance = noop; ss.Shake = noop; ss.Start = noop
end)

pcall(function()
    local function Rejoin()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end

    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
        local Method = getnamecallmethod()
        if (Method == "Kick" or Method == "kick") and Self == LocalPlayer then 
            task.spawn(Rejoin)
            return nil 
        end
        return OldNamecall(Self, ...)
    end))

    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        if game:GetService("GuiService"):GetErrorMessage() ~= "" then
            Rejoin()
        end
    end)
end)

-- [3] VARIABLES GLOBALES
local FastAttackEnabled = false
local FastAttackRange = math.huge
local FastAttackConnection = nil
local HitboxEnabled = false
local HitboxVisible = false
local HitboxSize = 50  -- 50x50x50 REAL
local HitboxExtras = 30  -- 30 partes extra
local FruitAttackKitsune = false
local FruitAttackTRex = false
local FruitAttackConnection = nil
local InfiniteJumpEnabled = false
local TOGGLE_KEY = Enum.KeyCode.U

local SelectedPlayer = nil
local TeleportEnabled = false
local InstaTeleportEnabled = false
local SpectateEnabled = false
local TeleportConnection = nil
local InstaTpConnection = nil
local SpectateConnection = nil
local ActiveTween = nil
local YOffset = 0
local PredictionStrength = 0
local TweenSpeedVal = 350

local AutoAwakening = false
local ESPEnabled = false
local ESPObjects = {}
local NoClipEnabled = false
local AutoFarmEnabled = false
local WalkSpeed = 16

local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterHit = Net["RE/RegisterHit"]
local RegisterAttack = Net["RE/RegisterAttack"]

-- [4] HITBOX SYSTEM REAL 50x50x50 + 30 PARTES EXTRA
local teamCheck = false

local function addExtraParts(model)
    if model:FindFirstChild("InfiniteParts") then return end
    local folder = Instance.new("Folder", model)
    folder.Name = "InfiniteParts"
    
    for i = 1, HitboxExtras do
        local p = Instance.new("Part", folder)
        p.Name = "InfPart"..i
        p.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
        p.Transparency = HitboxVisible and 0.7 or 1
        p.CanCollide = false
        p.Anchored = false
        p.BrickColor = BrickColor.new("Magenta")
        p.Material = Enum.Material.ForceField
        p.CFrame = model.HumanoidRootPart.CFrame * CFrame.new(
            math.random(-3000, 3000), 
            math.random(-3000, 3000), 
            math.random(-3000, 3000)
        )
        
        local weld = Instance.new("WeldConstraint", p)
        weld.Part0 = model.HumanoidRootPart
        weld.Part1 = p
    end
end

local function expandHitbox(model)
    if not model:FindFirstChildOfClass("Humanoid") or model:FindFirstChildOfClass("Humanoid").Health <= 0 then return end
    if not model:FindFirstChild("HumanoidRootPart") then return end
    
    for _, v in pairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            v.Transparency = HitboxVisible and 0.7 or 1
            v.CanCollide = false
            if HitboxVisible then
                v.BrickColor = BrickColor.new("Magenta")
                v.Material = Enum.Material.ForceField
            end
        end
    end
    
    addExtraParts(model)
end

local function hitboxLoop()
    if not HitboxEnabled then return end
    
    -- Expandir hitbox de jugadores
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and (not teamCheck or plr.Team ~= LocalPlayer.Team) then
            expandHitbox(plr.Character)
        end
    end
    
    -- Expandir hitbox de NPCs/Enemigos
    for _, folder in pairs({"Enemies", "Boss", "Raid", "SeaBeast", "SeaEvents"}) do
        local f = workspace:FindFirstChild(folder)
        if f then
            for _, v in pairs(f:GetChildren()) do
                if v:IsA("Model") then 
                    expandHitbox(v) 
                end
            end
        end
    end
end

-- [5] FUNCIONES DE ATAQUE ROTO
local function AttackMultipleTargets(targets)
    pcall(function()
        if not targets or #targets == 0 then return end
        local allTargets = {}
        for _, targetChar in pairs(targets) do
            local head = targetChar:FindFirstChild("Head")
            if head then table.insert(allTargets, {targetChar, head}) end
        end
        if #allTargets == 0 then return end
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(allTargets[1][2], allTargets)
    end)
end

local function StartFastAttack()
    if FastAttackConnection then task.cancel(FastAttackConnection) end
    FastAttackConnection = task.spawn(function()
        while FastAttackEnabled do
            task.wait(0.001)
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if not myHRP then return end
                local targets = {}

                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local hum = player.Character:FindFirstChild("Humanoid")
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if hum and hrp and hum.Health > 0 then
                            table.insert(targets, player.Character)
                        end
                    end
                end

                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, npc in pairs(enemies:GetChildren()) do
                        local hum = npc:FindFirstChild("Humanoid")
                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                        if hum and hrp and hum.Health > 0 then
                            table.insert(targets, npc)
                        end
                    end
                end

                if #targets > 0 then AttackMultipleTargets(targets) end
            end)
        end
    end)
end

-- [6] FUNCIONES DE MOVIMIENTO
local function GetPlayerList()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(list, p.Name) end
    end
    if #list == 0 then return {"Ninguno"} end
    return list
end

local function SetNoCollide()
    pcall(function()
        if not LocalPlayer.Character then return end
        for _, v in ipairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end

local function SetCollide()
    pcall(function()
        if not LocalPlayer.Character then return end
        for _, v in ipairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end)
end

local function GetNearestPlayer()
    local nearest, dist = nil, math.huge
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local d = (myHRP.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d; nearest = v end
        end
    end
    return nearest
end

local function TweenTP(targetHRP)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local HRP = LocalPlayer.Character.HumanoidRootPart
    local predictedPos = targetHRP.Position + (targetHRP.Velocity * PredictionStrength)
    local targetCFrame = CFrame.new(predictedPos) * CFrame.Angles(0, math.rad(targetHRP.Orientation.Y), 0) * CFrame.new(0, YOffset, 0)
    local Distance = (targetCFrame.Position - HRP.Position).Magnitude
    if ActiveTween then ActiveTween:Cancel() end
    ActiveTween = TweenService:Create(HRP, TweenInfo.new(Distance / TweenSpeedVal, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    ActiveTween:Play()
end

-- [7] ESP SYSTEM
local function CreateESP(target)
    if not target:FindFirstChild("Head") then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "IsekaMatrixESP"
    billboard.Adornee = target:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = target:FindFirstChild("Head")
    
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.Text = target.Name
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(138, 43, 226)
    lbl.TextStrokeTransparency = 0.4
    lbl.Parent = billboard
    table.insert(ESPObjects, billboard)
end

local function ClearESP()
    for _, obj in pairs(ESPObjects) do
        if obj then pcall(function() obj:Destroy() end) end
    end
    ESPObjects = {}
end

local function UpdateESP()
    ClearESP()
    if not ESPEnabled then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then CreateESP(p.Character) end
    end
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, npc in pairs(enemies:GetChildren()) do CreateESP(npc) end
    end
end

-- ============================================================
--  RAYFIELD UI (TEMA MORADO MATRIX)
-- ============================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "⚡  Anonimous HUB MATRIX ⚡ | by anonimous ",
    LoadingTitle = "Cargando Matrix...",
    LoadingSubtitle = "TopBuddha Edition",
    ConfigurationSaving = {Enabled = false},
    Discord = {Enabled = false},
    KeySystem = false
})

-- ============================================================
--  TAB 1: COMBATE ROTO
-- ============================================================
local Tab1 = Window:CreateTab("⚔️ Combate ROTO", 4483362458)

Tab1:CreateSection("🔥 Ataques Supremos")

Tab1:CreateToggle({
    Name = "⚡ Fast Attack INFINITE (U Key)",
    CurrentValue = false,
    Flag = "FastAttackToggle",
    Callback = function(Value)
        FastAttackEnabled = Value
        if Value then StartFastAttack() else
            if FastAttackConnection then task.cancel(FastAttackConnection) end
        end
    end,
})

Tab1:CreateToggle({
    Name = "🎯 MEGA HITBOX 50x50x50 + 30 PARTES",
    CurrentValue = false,
    Flag = "HitboxToggle",
    Callback = function(Value)
        HitboxEnabled = Value
        if Value then
            task.spawn(function()
                while HitboxEnabled do
                    hitboxLoop()
                    task.wait(0.1)
                end
            end)
        end
    end,
})

Tab1:CreateToggle({
    Name = "👁️ Hitbox Visible (Ver Hitbox)",
    CurrentValue = false,
    Flag = "HitboxVisibleToggle",
    Callback = function(Value)
        HitboxVisible = Value
    end,
})

Tab1:CreateSlider({
    Name = "📏 Tamaño Hitbox",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Flag = "HitboxSizeSlider",
    Callback = function(Value)
        HitboxSize = Value
    end,
})

Tab1:CreateSlider({
    Name = "➕ Partes Extra",
    Range = {0, 50},
    Increment = 1,
    CurrentValue = 30,
    Flag = "HitboxExtrasSlider",
    Callback = function(Value)
        HitboxExtras = Value
    end,
})

Tab1:CreateToggle({
    Name = "🦊 Fruit Attack (Kitsune) Ultra",
    CurrentValue = false,
    Flag = "KitsuneToggle",
    Callback = function(Value)
        FruitAttackKitsune = Value
        if Value then
            FruitAttackConnection = task.spawn(function()
                while FruitAttackKitsune do
                    task.wait(0.001)
                    local targetPlayer = GetNearestPlayer()
                    if targetPlayer and targetPlayer.Character then
                        local tool = LocalPlayer.Character:FindFirstChild("Kitsune-Kitsune")
                        if tool then
                            local direction = (targetPlayer.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
                            pcall(function()
                                tool:WaitForChild("LeftClickRemote"):FireServer(direction, 1, true)
                            end)
                        end
                    end
                end
            end)
        else
            if FruitAttackConnection then task.cancel(FruitAttackConnection) end
        end
    end,
})

Tab1:CreateToggle({
    Name = "🦖 Fruit Attack (T-Rex) Ultra",
    CurrentValue = false,
    Flag = "TRexToggle",
    Callback = function(Value)
        FruitAttackTRex = Value
        if Value then
            FruitAttackConnection = task.spawn(function()
                while FruitAttackTRex do
                    task.wait(0.001)
                    local targetPlayer = GetNearestPlayer()
                    if targetPlayer and targetPlayer.Character then
                        local tool = LocalPlayer.Character:FindFirstChild("T-Rex-T-Rex")
                        if tool then
                            local direction = (targetPlayer.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
                            pcall(function()
                                tool:WaitForChild("LeftClickRemote"):FireServer(direction, 1)
                            end)
                        end
                    end
                end
            end)
        else
            if FruitAttackConnection then task.cancel(FruitAttackConnection) end
        end
    end,
})

Tab1:CreateSection("🚀 Movimiento")

Tab1:CreateToggle({
    Name = "🌟 Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

Tab1:CreateToggle({
    Name = "👻 NoClip (Atravesar Paredes)",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        NoClipEnabled = Value
        task.spawn(function()
            while NoClipEnabled do
                SetNoCollide()
                task.wait(0.1)
            end
            SetCollide()
        end)
    end,
})

Tab1:CreateSlider({
    Name = "⚡ WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        WalkSpeed = Value
        task.spawn(function()
            while task.wait(0.1) do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
                end
            end
        end)
    end,
})

-- ============================================================
--  TAB 2: PLAYER LOCK
-- ============================================================
local Tab2 = Window:CreateTab("🎯 Player Lock", 4483362458)

Tab2:CreateSection("🔒 Target System")

local PlayerDropdown = Tab2:CreateDropdown({
    Name = "Seleccionar Player",
    Options = GetPlayerList(),
    CurrentOption = {"Ninguno"},
    MultipleOptions = false,
    Flag = "PlayerDropdown",
    Callback = function(Value)
        if type(Value) == "table" then Value = Value[1] end
        SelectedPlayer = (Value ~= "Ninguno") and Value or nil
    end,
})

Tab2:CreateToggle({
    Name = "🚀 Tween To Player",
    CurrentValue = false,
    Flag = "TweenToggle",
    Callback = function(Value)
        TeleportEnabled = Value
        if Value then
            TeleportConnection = RunService.Heartbeat:Connect(function()
                if SelectedPlayer then
                    local target = Players:FindFirstChild(SelectedPlayer)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        TweenTP(target.Character.HumanoidRootPart)
                        SetNoCollide()
                    end
                end
            end)
        else
            if TeleportConnection then TeleportConnection:Disconnect() end
            if ActiveTween then ActiveTween:Cancel() end
            SetCollide()
        end
    end,
})

Tab2:CreateToggle({
    Name = "⚡ Insta TP",
    CurrentValue = false,
    Flag = "InstaTpToggle",
    Callback = function(Value)
        InstaTeleportEnabled = Value
        if Value then
            InstaTpConnection = RunService.Stepped:Connect(function()
                if SelectedPlayer then
                    pcall(function()
                        local target = Players:FindFirstChild(SelectedPlayer)
                        if target and target.Character then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, YOffset, 0)
                            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                        end
                    end)
                end
            end)
        else
            if InstaTpConnection then InstaTpConnection:Disconnect() end
        end
    end,
})

Tab2:CreateToggle({
    Name = "👁️ Spectate Player",
    CurrentValue = false,
    Flag = "SpectateToggle",
    Callback = function(Value)
        SpectateEnabled = Value
        if Value then
            SpectateConnection = RunService.RenderStepped:Connect(function()
                if SelectedPlayer then
                    local target = Players:FindFirstChild(SelectedPlayer)
                    if target and target.Character then
                        workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
                    end
                end
            end)
        else
            if SpectateConnection then SpectateConnection:Disconnect() end
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end,
})

Tab2:CreateButton({
    Name = "🔄 Refrescar Lista",
    Callback = function()
        PlayerDropdown:Refresh(GetPlayerList(), true)
    end,
})

Tab2:CreateSlider({
    Name = "📏 Y Offset",
    Range = {0, 500},
    Increment = 1,
    CurrentValue = 0,
    Flag = "YOffsetSlider",
    Callback = function(Value)
        YOffset = Value
    end,
})

Tab2:CreateSection("⚙️ Auto Features")

Tab2:CreateToggle({
    Name = "✨ Auto V4 Awakening",
    CurrentValue = false,
    Flag = "AutoV4Toggle",
    Callback = function(Value)
        AutoAwakening = Value
        task.spawn(function()
            while AutoAwakening do
                task.wait(0.5)
                pcall(function()
                    LocalPlayer.Backpack.Awakening.RemoteFunction:InvokeServer(true)
                end)
            end
        end)
    end,
})

-- ============================================================
--  TAB 3: AUTO FARM
-- ============================================================
local Tab3 = Window:CreateTab("🌾 Auto Farm", 4483362458)

Tab3:CreateSection("💰 Farming Automático")

Tab3:CreateToggle({
    Name = "🤖 Auto Farm NPCs",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmEnabled = Value
        task.spawn(function()
            while AutoFarmEnabled do
                task.wait(0.1)
                pcall(function()
                    local enemies = workspace:FindFirstChild("Enemies")
                    if enemies then
                        for _, npc in pairs(enemies:GetChildren()) do
                            if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                                local npcHRP = npc:FindFirstChild("HumanoidRootPart")
                                if npcHRP then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = npcHRP.CFrame * CFrame.new(0, 0, 5)
                                    task.wait(0.5)
                                end
                                break
                            end
                        end
                    end
                end)
            end
        end)
    end,
})

Tab3:CreateToggle({
    Name = "⚡ Auto Farm + Fast Attack + Hitbox",
    CurrentValue = false,
    Flag = "AutoFarmComboToggle",
    Callback = function(Value)
        if Value then
            AutoFarmEnabled = true
            FastAttackEnabled = true
            HitboxEnabled = true
            StartFastAttack()
            task.spawn(function()
                while HitboxEnabled do
                    hitboxLoop()
                    task.wait(0.1)
                end
            end)
        else
            AutoFarmEnabled = false
            FastAttackEnabled = false
            HitboxEnabled = false
            if FastAttackConnection then task.cancel(FastAttackConnection) end
        end
    end,
})

-- ============================================================
--  TAB 4: TELEPORTS
-- ============================================================
local Tab4 = Window:CreateTab("📍 Teleports", 4483362458)

Tab4:CreateSection("🌍 Ubicaciones")

Tab4:CreateButton({
    Name = "🚢 Tp Barco",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6500, 129, -123)
        end
    end,
})

Tab4:CreateButton({
    Name = "🌌 Tp Krazy Vacio",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11997, 332, -8837)
        end
    end,
})

Tab4:CreateButton({
    Name = "🏝️ Tp Spawn",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
        end
    end,
})

-- ============================================================
--  TAB 5: ESP & VISUALS
-- ============================================================
local Tab5 = Window:CreateTab("👁️ ESP & Visuals", 4483362458)

Tab5:CreateSection("🎨 Visuales")

Tab5:CreateToggle({
    Name = "👁️ ESP Players & NPCs",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        ESPEnabled = Value
        UpdateESP()
        if Value then
            task.spawn(function()
                while ESPEnabled do
                    UpdateESP()
                    task.wait(1)
                end
            end)
        end
    end,
})

-- ============================================================
--  TAB 6: MISC
-- ============================================================
local Tab6 = Window:CreateTab("⚙️ Misc", 4483362458)

Tab6:CreateSection("🛡️ Protecciones")

Tab6:CreateToggle({
    Name = "🔒 Unbreakable",
    CurrentValue = false,
    Flag = "UnbreakableToggle",
    Callback = function(Value)
        task.spawn(function()
            while Value do
                task.wait(0.1)
                if LocalPlayer.Character then
                    LocalPlayer.Character:SetAttribute("UnbreakableAll", true)
                end
            end
        end)
    end,
})

Tab6:CreateButton({
    Name = "🚫 Remove TouchInterest",
    Callback = function()
        for _, descendant in pairs(game:GetDescendants()) do
            if descendant:IsA("TouchTransmitter") then 
                descendant:Destroy() 
            end
        end
        Rayfield:Notify({
            Title = "✅ Completado",
            Content = "TouchInterest eliminado",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

Tab6:CreateSection("🔧 Utilidades")

Tab6:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end,
})

Tab6:CreateButton({
    Name = "🚀 Boost FPS",
    Callback = function()
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        
        sethiddenproperty(l, "Technology", 2)
        sethiddenproperty(t, "Decoration", false)
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        
        settings().Rendering.QualityLevel = "Level01"
        
        for _, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = ""
            end
        end
        
        Rayfield:Notify({
            Title = "✅ FPS Boosted",
            Content = "Optimización aplicada",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

Tab6:CreateSection("ℹ️ Info")

Tab6:CreateLabel("⚡ Isekai Hub Matrix ⚡")
Tab6:CreateLabel("by azeu596")
Tab6:CreateLabel("Hitbox REAL 50x50x50 + 30 Partes")

-- ============================================================
--  INPUT SYSTEM
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    
    if input.KeyCode == TOGGLE_KEY then
        FastAttackEnabled = not FastAttackEnabled
        if FastAttackEnabled then StartFastAttack() else
            if FastAttackConnection then task.cancel(FastAttackConnection) end
        end
    end
    
    if input.KeyCode == Enum.KeyCode.B then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local flag = hrp:FindFirstChild("UpLoop")
            if flag then 
                flag:Destroy() 
            else
                flag = Instance.new("BoolValue", hrp)
                flag.Name = "UpLoop"
                task.spawn(function()
                    while flag.Parent do
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 273861, 0)
                        task.wait(0.05)
                    end
                end)
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then 
            humanoid:ChangeState("Jumping") 
        end
    end
end)

-- ============================================================
--  NOTIFICACIÓN FINAL
-- ============================================================
Rayfield:Notify({
    Title = "⚡ lol HUB MATRIX ⚡",
    Content = "Bienvenido " .. LocalPlayer.Name .. " | Hitbox REAL 50x50x50 Activado",
    Duration = 6.5,
    Image = 4483362458
})

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("⚡ MiniRanny HUB MATRIX ⚡")
print("by Ns_Up1 | ezeta Edition")
print("HITBOX REAL 50x50x50 + 30 PARTES ✅")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
