local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local PingEvent = ReplicatedStorage:FindFirstChild("PingEvent")
if not PingEvent then
    PingEvent = Instance.new("RemoteEvent")
    PingEvent.Name = "PingEvent"
    PingEvent.Parent = ReplicatedStorage
end

pcall(function()
    player:WaitForChild("PlayerGui"):FindFirstChild("TPGui"):Destroy()
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TPGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleHubButton"
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0, 660, 0, -46)
toggleButton.BackgroundColor3 = Color3.fromRGB(10,10,10)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Image = "rbxassetid://17419287546"
toggleButton.Parent = screenGui
local frameCorner2 = Instance.new("UICorner")
frameCorner2.CornerRadius = UDim.new(1, 0)
frameCorner2.Parent = toggleButton

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 265, 0, 340)
frame.Position = UDim2.new(0, 550, 0, 150)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

local topFrame = Instance.new("Frame")
topFrame.Size = UDim2.new(1, 0, 0, 20)
topFrame.Position = UDim2.new(0, 0, 0, 0)
topFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
topFrame.BackgroundTransparency = 0.25
topFrame.Parent = frame
local frameCorner3 = Instance.new("UICorner")
frameCorner3.CornerRadius = UDim.new(0, 6)
frameCorner3.Parent = topFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -35)
scrollFrame.Position = UDim2.new(0, 0, 0, 20)
scrollFrame.CanvasSize = UDim2.new(0, 0, 1.7, 0)
scrollFrame.ScrollBarThickness = 0
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = frame

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local function createButton(name, text, pos, size)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = size
    button.Position = pos
    button.Text = text
    button.BackgroundTransparency = 0
    button.BackgroundColor3 = Color3.fromRGB(255,0,0)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0,9)
    uiCorner.Parent = button
    button.Parent = scrollFrame
    return button
end

local function createTextBox(name, placeholder, pos, size)
    local box = Instance.new("TextBox")
    box.Name = name
    box.Size = size
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundTransparency = 0
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    box.ClearTextOnFocus = false
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0,6)
    boxCorner.Parent = box
    box.Parent = scrollFrame
    return box
end

local redColor = Color3.fromRGB(255,0,0)
local greenColor = Color3.fromRGB(0,255,0)
local btnSize = UDim2.new(0,160,0,40)
local boxSize = UDim2.new(0,65,0,30)
local smallBtnSize = UDim2.new(0,35,0,35)

-- Aquí agrego tu ESP 2D y CamLock completo
local camera = workspace.CurrentCamera
local CamlockEnabled = false
local CamTarget = nil
local smoothStrength = 0
local realPing = 0
local pingTimer = 0.2

local ESPFolder = Instance.new("Folder")
ESPFolder.Name="ESP"
ESPFolder.Parent=screenGui

local ESPBoxes = {}
local function createESPBox(plr)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0,50,0,80)
    box.BorderSizePixel = 2
    box.BackgroundTransparency = 1
    box.BorderColor3 = Color3.new(1,0,0)
    box.Parent = ESPFolder
    return box
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr~=player then ESPBoxes[plr]=createESPBox(plr) end
end

Players.PlayerAdded:Connect(function(plr)
    if plr~=player then ESPBoxes[plr]=createESPBox(plr) end
end)
Players.PlayerRemoving:Connect(function(plr)
    if ESPBoxes[plr] then ESPBoxes[plr]:Destroy(); ESPBoxes[plr]=nil end
end)

local function GetLookedTarget()
    local mousePos = UIS:GetMouseLocation()-Vector2.new(0,36)
    local closestPlayer = nil
    local smallestDist = math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr~=player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local screenPos,onScreen = camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X,screenPos.Y)-mousePos).Magnitude
                if dist<smallestDist then
                    smallestDist=dist
                    closestPlayer=plr
                end
            end
        end
    end
    return closestPlayer
end

local function measurePing()
    local startTime = tick()
    PingEvent:FireServer()
    local conn
    conn = PingEvent.OnClientEvent:Connect(function()
        realPing = tick()-startTime
        conn:Disconnect()
    end)
end

local function calcularPrediccionAvanzada(hrp)
    local distancia = (hrp.Position - camera.CFrame.Position).Magnitude
    local factorDistancia = math.clamp(distancia / 50, 0.2, 1)
    local val = camDelayBox.Text
    local pingValue = 0
    if val:lower()=="auto" then
        if tick()-(pingMeasureTime or 0)>pingTimer then
            measurePing()
            pingMeasureTime=tick()
        end
        pingValue=realPing
    else
        pingValue=tonumber(val) or 0
    end
    pingValue = math.clamp(pingValue,0,1)
    return Vector3.new(factorDistancia*0.6*pingValue,factorDistancia*0.3*pingValue,factorDistancia*0.6*pingValue)
end

RunService.RenderStepped:Connect(function()
    for plr,box in pairs(ESPBoxes) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp=plr.Character.HumanoidRootPart
            local headPos,headOnScreen=camera:WorldToViewportPoint(hrp.Position+Vector3.new(0,2,0))
            local feetPos,feetOnScreen=camera:WorldToViewportPoint(hrp.Position)
            if headOnScreen and feetOnScreen then
                local height = math.abs(headPos.Y-feetPos.Y)
                local width = height/2
                box.Size = UDim2.new(0,width,0,height)
                box.Position = UDim2.new(0,headPos.X-width/2,0,headPos.Y-height)
                box.Visible = true
            else
                box.Visible=false
            end
        else
            box.Visible=false
        end
    end
    if CamlockEnabled and CamTarget and CamTarget.Character and CamTarget.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = CamTarget.Character.HumanoidRootPart
        local futurePos = hrp.Position + hrp.Velocity * calcularPrediccionAvanzada(hrp)
        if SmoothButton.BackgroundColor3==greenColor then
            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position,futurePos),smoothStrength)
        else
            camera.CFrame = CFrame.new(camera.CFrame.Position,futurePos)
        end
    end
end)

UIS.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.Q then
        CamlockEnabled = not CamlockEnabled
        if CamlockEnabled then CamTarget=GetLookedTarget() end
    elseif input.KeyCode==Enum.KeyCode.H then
        CamlockEnabled=false
        CamTarget=nil
    end
end)
AimButton.MouseButton1Click:Connect(function()
    CamlockEnabled = not CamlockEnabled
    if CamlockEnabled then CamTarget=GetLookedTarget() end
end)
SmoothButton.MouseButton1Click:Connect(function()
    SmoothButton.BackgroundColor3 = SmoothButton.BackgroundColor3==redColor and greenColor or redColor
end)
