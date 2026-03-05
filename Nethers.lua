local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ==========================================
-- SYSTEME DE WHITELIST
-- ==========================================
local WhitelistedIDs = {
    [2354866600] = true,
    [7714389292] = true,
    [player.UserId] = true -- Ajouté pour tes tests
}

if not WhitelistedIDs[player.UserId] then
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://135431631525798" 
    sound.Volume = 10
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    task.wait(0.1)
    player:Kick("\n[SECURITY]\nNot Whitelisted.")
    return
end

-- ==========================================
-- CONFIGURATION : POSITIONS (BASE 3 AJOUTÉE)
-- ==========================================
local BASE_1_POS = Vector3.new(-489.01, 29.26, 124.6)
local BASE_2_POS = Vector3.new(-488.11, 28.64, 17.6)
local BASE_3_POS = Vector3.new(-332.88, 29.89, 99.86) -- Ta nouvelle position
local spawnPos = nil  
local currentBase = 1 

-- AUTO-CAPTURE DU SPAWN
local function onCharacterAdded(char)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then spawnPos = hrp.CFrame end
end
player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then onCharacterAdded(player.Character) end

-- ==========================================
-- INTERFACE GRAPHIQUE (ADAPTÉE)
-- ==========================================
local function RGBStroke(obj)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    task.spawn(function()
        local h = 0
        while obj.Parent do
            stroke.Color = Color3.fromHSV(h,1,1)
            h = (h + 0.01) % 1
            task.wait()
        end
    end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "NethersStealGui"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 320) -- Agrandi pour le 4ème bouton
main.Position = UDim2.new(.5,0,.5,0)
main.AnchorPoint = Vector2.new(.5,.5)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)
RGBStroke(main)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "Nethers Exotic Private"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Parent = main

-- Drag System
local dragging, dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

local function createButton(text, posY, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(.8,0,0,40) -- Taille légèrement réduite pour l'espace
    btn.Position = UDim2.new(.1,0,0,posY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = color or Color3.fromRGB(25,25,25)
    btn.Parent = main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    RGBStroke(btn)
    return btn
end

local stealBtn = createButton("INSTANT STEAL", 65, Color3.fromRGB(45, 25, 25))
local tp1Btn = createButton("TP BASE 1", 115)
local tp2Btn = createButton("TP BASE 2", 165)
local tp3Btn = createButton("TP BASE 3", 215) -- Nouveau bouton !

-- ==========================================
-- LOGIQUE DES COMMANDES
-- ==========================================

-- Touche F : Alternance Base 1 -> 2 -> 3
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            if currentBase == 1 then
                root.CFrame = CFrame.new(BASE_1_POS)
                currentBase = 2
            elseif currentBase == 2 then
                root.CFrame = CFrame.new(BASE_2_POS)
                currentBase = 3
            else
                root.CFrame = CFrame.new(BASE_3_POS)
                currentBase = 1
            end
        end
    end
end)

stealBtn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root and spawnPos then
        local oldPos = root.CFrame 
        root.CFrame = spawnPos
        stealBtn.Text = "STEALING..."
        task.wait(0.25)
        root.CFrame = oldPos
        stealBtn.Text = "SUCCESS!"
    end
    task.wait(1)
    stealBtn.Text = "INSTANT STEAL"
end)

tp1Btn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(BASE_1_POS) end
end)

tp2Btn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(BASE_2_POS) end
end)

tp3Btn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(BASE_3_POS) end
end)
