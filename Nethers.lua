local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")

local tpPosition = hrp.CFrame

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NethersTP"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 180)
frame.Position = UDim2.new(0.5, -100, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0

-- Bouton Set TP
local setTP = Instance.new("TextButton", frame)
setTP.Size = UDim2.new(1, -20, 0, 30)
setTP.Position = UDim2.new(0, 10, 0, 10)
setTP.Text = "Set TP"
setTP.BackgroundColor3 = Color3.fromRGB(60,120,255)
setTP.TextColor3 = Color3.new(1,1,1)
setTP.BorderSizePixel = 0

-- Bouton TP
local normalTP = Instance.new("TextButton", frame)
normalTP.Size = UDim2.new(1, -20, 0, 30)
normalTP.Position = UDim2.new(0, 10, 0, 50)
normalTP.Text = "TP"
normalTP.BackgroundColor3 = Color3.fromRGB(60,200,120)
normalTP.TextColor3 = Color3.new(1,1,1)
normalTP.BorderSizePixel = 0

-- Bouton Steal Exotic (placeholder)
local stealBtn = Instance.new("TextButton", frame)
stealBtn.Size = UDim2.new(1, -20, 0, 30)
stealBtn.Position = UDim2.new(0, 10, 0, 90)
stealBtn.Text = "Steal Exotic"
stealBtn.BackgroundColor3 = Color3.fromRGB(200,120,60)
stealBtn.TextColor3 = Color3.new(1,1,1)
stealBtn.BorderSizePixel = 0

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Text = "Made by Nethers"
credit.TextColor3 = Color3.fromRGB(180,180,180)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 14

-- Set position
setTP.MouseButton1Click:Connect(function()
    tpPosition = hrp.CFrame
end)

-- TP temporaire
local function doTempTP()
    local oldPosition = hrp.CFrame
    hrp.CFrame = tpPosition
    task.wait(0.5)
    hrp.CFrame = oldPosition
end

-- TP normal
local function doNormalTP()
    hrp.CFrame = tpPosition
end

-- Fonction Steal Exotic (à adapter pour ton jeu légitime)
local function stealExotic()
    print("Steal Exotic activé (placeholder)")
end

normalTP.MouseButton1Click:Connect(doNormalTP)
stealBtn.MouseButton1Click:Connect(stealExotic)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        doTempTP()
    end
    
    if input.KeyCode == Enum.KeyCode.G then
        doNormalTP()
    end
end)
