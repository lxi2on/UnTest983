local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- RemoteEvent para medir ping
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
scrollFrame.Size = UDim2.new(1, 0, 1, -35) -- ocupa el resto del frame
scrollFrame.Position = UDim2.new(0, 0, 0, 20)
scrollFrame.CanvasSize = UDim2.new(0, 0, 1.7, 0) -- ajusta según la cantidad de botones
scrollFrame.ScrollBarThickness = 8
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
scrollFrame.ScrollBarImageTransparency = 0.3  -- 0 es opaco, 1 invisible
scrollFrame.ScrollBarThickness = 0  -- antes era 8
scrollFrame.Parent = frame

local lineFrame = Instance.new("Frame")
lineFrame.Size = UDim2.new(1, 0, 1, -580)
lineFrame.Position = UDim2.new(0, 0, 0, 79)
lineFrame.BackgroundTransparency = 0.4
lineFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
lineFrame.Parent = scrollFrame

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Funciones para botones y textbox
local function createButton(name, text, pos, size)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = size
    button.Position = pos
    button.Text = text
    button.BackgroundTransparency = 0
    button.BackgroundColor3 = Color3.fromRGB(255,0,0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 9)
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
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    box.ClearTextOnFocus = false
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box
    box.Parent = scrollFrame
    return box
end

local redColor = Color3.fromRGB(255, 0, 0)
local greenColor = Color3.fromRGB(0, 255, 0)

local btnSize = UDim2.new(0, 160, 0, 40)
local boxSize = UDim2.new(0, 65, 0, 30)
local smallBtnSize = UDim2.new(0, 35, 0, 35)

-- TP Buttons
local roofTpButton = createButton("RoofTPButton", "Roof TP", UDim2.new(0, 15, 0, 80), btnSize)
local roofStudsBox = createTextBox("RoofStudsBox", "18", UDim2.new(0, 185, 0, 85), boxSize)
local wallTpButton = createButton("WallTPButton", "Wall TP", UDim2.new(0, 15, 0, 125), btnSize)
local wallStudsBox = createTextBox("WallStudsBox", "5", UDim2.new(0, 185, 0, 130), boxSize)
local floorTpButton = createButton("FloorTPButton", "Floor TP", UDim2.new(0, 15, 0, 170), btnSize)
local floorStudsBox = createTextBox("FloorStudsBox", "5", UDim2.new(0, 185, 0, 175), boxSize)
local backTpButton = createButton("BackTPButton", "Back TP", UDim2.new(0, 15, 0, 215), btnSize)
local backStudsBox = createTextBox("BackStudsBox", "5", UDim2.new(0, 185, 0, 220), boxSize)

-- Jump Power
local jumpButton = createButton("JumpPowerButton", "Set JumpPower", UDim2.new(0, 15, 0, 260), btnSize)
local jumpPowerBox = createTextBox("JumpPowerBox", "50", UDim2.new(0, 185, 0, 265), boxSize)

-- Loop Speed
local loopSpeedButton = createButton("LoopSpeedButton", "Set Loop Speed", UDim2.new(0, 15, 0, 305), btnSize)
local loopSpeedBox = createTextBox("LoopSpeedBox", "0.5", UDim2.new(0, 185, 0, 310), boxSize)
local loopSpeed = 0.5

-- CamLock
local AimButton = createButton("AimBotButton", "CamLock", UDim2.new(0, 15, 0, 350), btnSize)
local camDelayBox = createTextBox("CamDelayBox", "0", UDim2.new(0,185,0,355), boxSize)

-- SmoothCam
local SmoothButton = createButton("SmoothCamButton", "SmoothCam", UDim2.new(0, 15, 0, 395), btnSize)
local SmoothBox = createTextBox("SmoothCamBox", "0", UDim2.new(0, 185, 0, 400), boxSize)

-- Speed Change
local SpeedButton = createButton("SpeedChangeButton", "Change Speed", UDim2.new(0, 15, 0, 440), btnSize)
local SpeedBox = createTextBox("SpeedChangeBox", "16", UDim2.new(0, 185, 0, 445), boxSize)

-- Loop Save TP
local loopSavedTPButton = createButton("LoopSavedTPButton", "Loop Saved TP", UDim2.new(0, 15, 0, 530), btnSize)

-- Crear botón y textbox para TP a XYZ
local xyzButton = createButton("XYZTPButton", "TP XYZ", UDim2.new(0, 15, 0, 485), btnSize)
local xyzBox = createTextBox("XYZBox", "0,0,0", UDim2.new(0, 185, 0, 490), boxSize)

-- Saved positions
local savePositions = {{15,0},{55,0},{95,0},{135,0},{175,0},{215,0}}
local saveButtons = {}
local tpButtons = {}
for i=1,6 do
    saveButtons[i] = createButton("SaveButton"..i, tostring(i), UDim2.new(0, savePositions[i][1], 0, savePositions[i][2]), smallBtnSize)
    tpButtons[i] = createButton("TPButton"..i, "TP "..i, UDim2.new(0, savePositions[i][1], 0, 40), smallBtnSize)
end

local savedPositions = {}
local activeTP = nil
local tpConnection = nil
local fixedPosition = nil

-- Functions de TP
local function deactivateCurrentTP()
    if tpConnection then tpConnection:Disconnect(); tpConnection=nil end
    roofTpButton.BackgroundColor3=redColor; roofTpButton.Text="Roof TP"
    wallTpButton.BackgroundColor3=redColor; wallTpButton.Text="Wall TP"
    floorTpButton.BackgroundColor3=redColor; floorTpButton.Text="Floor TP"
    backTpButton.BackgroundColor3=redColor; backTpButton.Text="Back TP"
    activeTP=nil
    fixedPosition=nil
end

local function startTeleportLoop()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if not hrp then deactivateCurrentTP() return end
    hrp.CFrame = CFrame.new(fixedPosition)
    tpConnection = RunService.RenderStepped:Connect(function()
        if hrp and fixedPosition then
            if (hrp.Position-fixedPosition).Magnitude>0.5 then
                hrp.Velocity=Vector3.new(0,0,0)
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(fixedPosition), loopSpeed)
            end
        else
            deactivateCurrentTP()
        end
    end)
end

local function teleportToPosition(position)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if hrp then hrp.CFrame=CFrame.new(position) end
end

-- Toggle para Loop Saved TP
local loopSavedTPEnabled = false
loopSavedTPButton.MouseButton1Click:Connect(function()
    loopSavedTPEnabled = not loopSavedTPEnabled
    loopSavedTPButton.BackgroundColor3 = loopSavedTPEnabled and greenColor or redColor
end)

-- Toggle para Loop Saved TP con desactivación segura
local loopSavedTPEnabled = false
loopSavedTPButton.MouseButton1Click:Connect(function()
    loopSavedTPEnabled = not loopSavedTPEnabled
    loopSavedTPButton.BackgroundColor3 = loopSavedTPEnabled and greenColor or redColor

    -- Si desactivamos el loop, detenemos cualquier TP activo
    if not loopSavedTPEnabled then
        if tpConnection then tpConnection:Disconnect(); tpConnection=nil end
        activeTP = nil
        fixedPosition = nil
        for j=1,6 do
            tpButtons[j].BackgroundColor3 = redColor
            tpButtons[j].Text = "TP "..j
        end
    end
end)

-- Saved TP buttons con loop activable por toggle
for i=1,6 do
    saveButtons[i].MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then savedPositions[i] = hrp.Position end
        saveButtons[i].BackgroundColor3 = greenColor
        wait(0.2)
        saveButtons[i].BackgroundColor3 = redColor
    end)

    tpButtons[i].MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        -- Si loop está activo
        if loopSavedTPEnabled then
            -- Si ya está activo este TP, lo desactivamos
            if activeTP == "saved"..i then
                if tpConnection then tpConnection:Disconnect(); tpConnection=nil end
                tpButtons[i].BackgroundColor3 = redColor
                tpButtons[i].Text = "TP "..i
                activeTP = nil
                fixedPosition = nil
                return
            end

            -- Desactivamos cualquier otro TP activo
            if tpConnection then tpConnection:Disconnect(); tpConnection=nil end
            for j=1,6 do
                tpButtons[j].BackgroundColor3 = redColor
                tpButtons[j].Text = "TP "..j
            end

            -- Activamos loop TP
            if savedPositions[i] then
                activeTP = "saved"..i
                fixedPosition = savedPositions[i]
                tpButtons[i].BackgroundColor3 = greenColor
                tpButtons[i].Text = "Stop TP "..i

                hrp.CFrame = CFrame.new(fixedPosition)
                tpConnection = RunService.RenderStepped:Connect(function()
                    if hrp and fixedPosition and loopSavedTPEnabled then
                        if (hrp.Position - fixedPosition).Magnitude > 0.5 then
                            hrp.Velocity = Vector3.new(0,0,0)
                            hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(fixedPosition), loopSpeed)
                        end
                    else
                        if tpConnection then tpConnection:Disconnect(); tpConnection=nil end
                        tpButtons[i].BackgroundColor3 = redColor
                        tpButtons[i].Text = "TP "..i
                        activeTP = nil
                        fixedPosition = nil
                    end
                end)
            end
        else
            -- TP normal de 1 vez
            if savedPositions[i] then
                hrp.CFrame = CFrame.new(savedPositions[i])
                tpButtons[i].BackgroundColor3 = greenColor
                wait(0.2)
                tpButtons[i].BackgroundColor3 = redColor
            end
        end
    end)
end


-- Setup TP Buttons
local function setupTPButton(button, typeName, studsBox, vectorFunc, directional)
    button.MouseButton1Click:Connect(function()
        if activeTP==typeName then deactivateCurrentTP() return end
        deactivateCurrentTP()
        activeTP=typeName
        button.Text="Stop "..button.Text
        button.BackgroundColor3=greenColor
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local studs=tonumber(studsBox.Text) or 5
            if directional then
                local lookVector = hrp.CFrame.LookVector
                if typeName=="back" then lookVector = -lookVector end
                fixedPosition = hrp.Position + lookVector * studs
            else
                fixedPosition = vectorFunc(hrp.Position, studs)
            end
            startTeleportLoop()
        end
    end)
end

setupTPButton(roofTpButton,false,roofStudsBox,function(pos,s) return pos+Vector3.new(0,s,0) end,false)
setupTPButton(wallTpButton,"wall",wallStudsBox,function(pos,s) return pos+Vector3.new(0,0,-s) end,true)
setupTPButton(floorTpButton,"floor",floorStudsBox,function(pos,s) return pos-Vector3.new(0,s,0) end,false)
setupTPButton(backTpButton,"back",backStudsBox,function(pos,s) return pos+Vector3.new(0,0,s) end,true)

-- Jump Power
jumpButton.MouseButton1Click:Connect(function()
    local num=tonumber(jumpPowerBox.Text)
    local char=player.Character or player.CharacterAdded:Wait()
    local humanoid=char:WaitForChild("Humanoid")
    if num and num>=1 and num<=10000 and humanoid then
        humanoid.UseJumpPower=true
        humanoid.JumpPower=num
        jumpButton.BackgroundColor3 = greenColor
        wait(0.2)
        jumpButton.BackgroundColor3 = redColor
    end
end)

-- Loop Speed
loopSpeedButton.MouseButton1Click:Connect(function()
    local num=tonumber(loopSpeedBox.Text)
    if num and num>0 and num<=1 then
        loopSpeed=num
        loopSpeedButton.BackgroundColor3 = greenColor
        wait(0.2)
        loopSpeedButton.BackgroundColor3 = redColor
    end
end)

-- Dragging frame
local dragging=false
local dragInput,dragStart,startPos
local function update(input)
    local delta=input.Position-dragStart
    local goal=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    RunService:BindToRenderStep("DragFrame",Enum.RenderPriority.Input.Value,function()
        if dragging then frame.Position=frame.Position:Lerp(goal,0.2)
        else RunService:UnbindFromRenderStep("DragFrame") end
    end)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true; dragStart=input.Position; startPos=frame.Position
        input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then dragging=false end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end
end)

UIS.InputChanged:Connect(function(input)
    if input==dragInput and dragging then update(input) end
end)

-- CamLock con predicción avanzada y SmoothCam optimizada
local CamlockEnabled = false
local CamTarget = nil
local smoothStrength = 0
local realPing = 0
local pingTimer = 0.2 -- segundos entre cada medición de ping

-- Función para medir ping real de forma eficiente
local function measurePing()
    local startTime = tick()
    PingEvent:FireServer()
    local conn
    conn = PingEvent.OnClientEvent:Connect(function()
        realPing = tick() - startTime
        conn:Disconnect()
    end)
end

local function calcularPrediccionAvanzada(hrp)
    local cam = workspace.CurrentCamera
    local distancia = (hrp.Position - cam.CFrame.Position).Magnitude
    local factorDistancia = math.clamp(distancia / 50, 0.2, 1)

    local val = camDelayBox.Text
    local pingValue = 0
    if val:lower()=="auto" then
        -- Medir ping solo cada pingTimer segundos
        if tick() - (pingMeasureTime or 0) > pingTimer then
            measurePing()
            pingMeasureTime = tick()
        end
        pingValue = realPing
    else
        pingValue = tonumber(val) or 0
    end

    pingValue = math.clamp(pingValue, 0, 1)
    local predic = factorDistancia * 0.6 * pingValue
    return Vector3.new(predic, predic*0.5, predic)
end

-- SmoothCam
SmoothBox.FocusLost:Connect(function()
    local val = tonumber(SmoothBox.Text)
    if val and val >= 0 and val <= 1 then
        smoothStrength = val
    end
end)

local function GetLookedTarget()
    local cam = workspace.CurrentCamera
    local mousePos = UIS:GetMouseLocation() - Vector2.new(0,36)
    local closestPlayer = nil
    local smallestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < smallestDist then
                    smallestDist = dist
                    closestPlayer = plr
                end
            end
        end
    end
    return closestPlayer
end

-- Activar/Desactivar CamLock con Q
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.Q then
        if AimButton.BackgroundColor3==greenColor then
            CamlockEnabled = not CamlockEnabled
            if CamlockEnabled then CamTarget = GetLookedTarget() end
        end
    elseif input.KeyCode==Enum.KeyCode.H then
        CamlockEnabled=false
        CamTarget=nil
        AimButton.BackgroundColor3 = redColor
    end
end)

-- Botones CamLock / SmoothCam
AimButton.MouseButton1Click:Connect(function()
    if AimButton.BackgroundColor3==redColor then
        AimButton.BackgroundColor3 = greenColor
        CamlockEnabled = true
        CamTarget = GetLookedTarget()
    else
        AimButton.BackgroundColor3 = redColor
        CamlockEnabled = false
        CamTarget = nil
    end
end)

SmoothButton.MouseButton1Click:Connect(function()
    if not CamlockEnabled then
        SmoothButton.BackgroundColor3 = redColor
        return
    end
    SmoothButton.BackgroundColor3 = SmoothButton.BackgroundColor3==redColor and greenColor or redColor
end)

-- RenderStepped
RunService.RenderStepped:Connect(function()
    if CamlockEnabled and CamTarget and CamTarget.Character and CamTarget.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = CamTarget.Character.HumanoidRootPart
        local cam = workspace.CurrentCamera
        local predVec = calcularPrediccionAvanzada(hrp)
        local futurePos = hrp.Position + hrp.Velocity * predVec
        if SmoothButton.BackgroundColor3==greenColor then
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,futurePos), smoothStrength)
        else
            cam.CFrame = CFrame.new(cam.CFrame.Position,futurePos)
        end
    end
end)

-- Change Speed forzado (toggle)
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
player.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
end)

local speedToggle = false
local speedConnection

local function applySpeed()
    if humanoid then
        local num = tonumber(SpeedBox.Text)
        if num then
            num = math.clamp(num, 0, 1000) -- límite 0 a 1000
        else
            num = 16 -- default
        end
        humanoid.WalkSpeed = num
    end
end

SpeedButton.MouseButton1Click:Connect(function()
    speedToggle = not speedToggle
    if speedToggle then
        SpeedButton.BackgroundColor3 = greenColor
        applySpeed()
        speedConnection = RunService.Heartbeat:Connect(function()
            if speedToggle and humanoid then
                applySpeed()
            end
        end)
    else
        SpeedButton.BackgroundColor3 = redColor
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end)
-- TP XYZ Button (1 click)
xyzButton.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if xyzBox.Text:lower() == "location" then
        -- Si el comando es Location, poner la posición actual
        local pos = hrp.Position
        xyzBox.Text = string.format("%.1f,%.1f,%.1f", pos.X, pos.Y, pos.Z)
        xyzButton.BackgroundColor3 = greenColor
        wait(0.2)
        xyzButton.BackgroundColor3 = redColor
        return
    end

    -- Intentar teletransportarse a la posición indicada en XYZBox
    local coords = {}
    for num in xyzBox.Text:gmatch("[^,]+") do
        table.insert(coords, tonumber(num))
    end

    if #coords == 3 then
        hrp.CFrame = CFrame.new(coords[1], coords[2], coords[3])
        xyzButton.BackgroundColor3 = greenColor
        wait(0.2)
        xyzButton.BackgroundColor3 = redColor
    else
        -- Si los datos son inválidos, poner rojo por error
        xyzButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
        wait(0.5)
        xyzButton.BackgroundColor3 = redColor
    end
end)
