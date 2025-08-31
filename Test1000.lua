local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Elimina GUI antigua
pcall(function()
    local oldGui = player.PlayerGui:FindFirstChild("TPGui")
    if oldGui then oldGui:Destroy() end
end)

-- Crear GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TPGui"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

local function createButton(name, text, pos, size)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Position = pos
    btn.Size = size
    btn.BackgroundColor3 = Color3.fromRGB(255,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BackgroundTransparency = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,8)
    corner.Parent = btn
    btn.Parent = screenGui
    return btn
end

local function createTextBox(name, placeholder, pos, size)
    local box = Instance.new("TextBox")
    box.Name = name
    box.PlaceholderText = placeholder
    box.Position = pos
    box.Size = size
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    box.ClearTextOnFocus = false
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,6)
    corner.Parent = box
    box.Parent = screenGui
    return box
end

-- Botones y textboxes ejemplo
local roofButton = createButton("RoofTP","Roof TP",UDim2.new(0,15,0,50),UDim2.new(0,120,0,35))
local roofBox = createTextBox("RoofBox","18",UDim2.new(0,150,0,50),UDim2.new(0,60,0,30))
local camButton = createButton("CamLock","CamLock",UDim2.new(0,15,0,100),UDim2.new(0,120,0,35))
local smoothBox = createTextBox("Smooth","0.5",UDim2.new(0,150,0,100),UDim2.new(0,60,0,30))

-- Variables CamLock y ESP
local CamlockEnabled = false
local CamTarget = nil
local smoothStrength = 0.5

-- ESP 2D
local ESPFolder = Instance.new("Folder",screenGui)
ESPFolder.Name = "ESP"
local ESPBoxes = {}

local function createESPBox(plr)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0,50,0,80)
    box.BorderSizePixel = 2
    box.BackgroundTransparency = 1
    box.BorderColor3 = Color3.fromRGB(255,0,0)
    box.Parent = ESPFolder
    return box
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr ~= player then ESPBoxes[plr]=createESPBox(plr) end
end
Players.PlayerAdded:Connect(function(plr)
    if plr ~= player then ESPBoxes[plr]=createESPBox(plr) end
end)
Players.PlayerRemoving:Connect(function(plr)
    if ESPBoxes[plr] then ESPBoxes[plr]:Destroy() ESPBoxes[plr]=nil end
end)

-- Obtener jugador más cercano al mouse
local function GetLookedTarget()
    local mousePos = UIS:GetMouseLocation()
    local closestPlayer = nil
    local smallestDist = math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local screenPos,onScreen = camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X,screenPos.Y)-mousePos).Magnitude
                if dist < smallestDist then
                    smallestDist = dist
                    closestPlayer = plr
                end
            end
        end
    end
    return closestPlayer
end

-- Calcular predicción
local function calcularPrediccion(hrp)
    return hrp.Velocity * 0.5
end

-- Conexión RenderStepped
RunService.RenderStepped:Connect(function()
    -- ESP
    for plr,box in pairs(ESPBoxes) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local headPos,headOn = camera:WorldToViewportPoint(hrp.Position + Vector3.new(0,2,0))
            local footPos,footOn = camera:WorldToViewportPoint(hrp.Position)
            if headOn and footOn then
                local height = math.abs(headPos.Y - footPos.Y)
                local width = height/2
                box.Size = UDim2.new(0,width,0,height)
                box.Position = UDim2.new(0, headPos.X-width/2, 0, headPos.Y-height)
                box.Visible = true
            else
                box.Visible = false
            end
        else
            box.Visible=false
        end
    end

    -- CamLock
    if CamlockEnabled and CamTarget and CamTarget.Character and CamTarget.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = CamTarget.Character.HumanoidRootPart
        local futurePos = hrp.Position + calcularPrediccion(hrp)
        camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position,futurePos),smoothStrength)
    end
end)

-- Input CamLock
UIS.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Q then
        CamlockEnabled = not CamlockEnabled
        if CamlockEnabled then CamTarget = GetLookedTarget() end
    elseif input.KeyCode == Enum.KeyCode.H then
        CamlockEnabled = false
        CamTarget = nil
    end
end)

camButton.MouseButton1Click:Connect(function()
    CamlockEnabled = not CamlockEnabled
    if CamlockEnabled then CamTarget = GetLookedTarget() end
end)

smoothBox.FocusLost:Connect(function()
    local val = tonumber(smoothBox.Text)
    if val then smoothStrength = math.clamp(val,0,1) end
end)
