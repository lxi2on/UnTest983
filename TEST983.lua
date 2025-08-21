local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MOUSE_OFFSET_Y = 36

local PingEvent = ReplicatedStorage:FindFirstChild("PingEvent")
if not PingEvent then
    PingEvent = Instance.new("RemoteEvent")
    PingEvent.Name = "PingEvent"
    PingEvent.Parent = ReplicatedStorage
end

pcall(function()
    playerGui:FindFirstChild("TPGui"):Destroy()
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TPGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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
frame.Visible = false

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

local topFrame = Instance.new("Frame")
topFrame.Size = UDim2.new(1, 0, 0, 20)
topFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
topFrame.BackgroundTransparency = 0.25
topFrame.Parent = frame

local frameCorner3 = Instance.new("UICorner")
frameCorner3.CornerRadius = UDim.new(0, 6)
frameCorner3.Parent = topFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -20)
scrollFrame.Position = UDim2.new(0, 0, 0, 20)
scrollFrame.CanvasSize = UDim2.new(0, 0, 1.7, 0)
scrollFrame.ScrollBarThickness = 5
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
scrollFrame.ScrollBarImageTransparency = 0.3
scrollFrame.Parent = frame

local lineFrame = Instance.new("Frame")
lineFrame.Size = UDim2.new(1, 0, 0, 1)
lineFrame.Position = UDim2.new(0, 0, 0, 79)
lineFrame.BackgroundTransparency = 0.4
lineFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
lineFrame.Parent = scrollFrame

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

local roofTpButton = createButton("RoofTPButton", "Roof TP", UDim2.new(0, 15, 0, 80), btnSize)
local roofStudsBox = createTextBox("RoofStudsBox", "18", UDim2.new(0, 185, 0, 85), boxSize)
local wallTpButton = createButton("WallTPButton", "Wall TP", UDim2.new(0, 15, 0, 125), btnSize)
local wallStudsBox = createTextBox("WallStudsBox", "5", UDim2.new(0, 185, 0, 130), boxSize)
local floorTpButton = createButton("FloorTPButton", "Floor TP", UDim2.new(0, 15, 0, 170), btnSize)
local floorStudsBox = createTextBox("FloorStudsBox", "5", UDim2.new(0, 185, 0, 175), boxSize)
local backTpButton = createButton("BackTPButton", "Back TP", UDim2.new(0, 15, 0, 215), btnSize)
local backStudsBox = createTextBox("BackStudsBox", "5", UDim2.new(0, 185, 0, 220), boxSize)
local jumpButton = createButton("JumpPowerButton", "Set JumpPower", UDim2.new(0, 15, 0, 260), btnSize)
local jumpPowerBox = createTextBox("JumpPowerBox", "50", UDim2.new(0, 185, 0, 265), boxSize)
local loopSpeedButton = createButton("LoopSpeedButton", "Set Loop Speed", UDim2.new(0, 15, 0, 305), btnSize)
local loopSpeedBox = createTextBox("LoopSpeedBox", "0.5", UDim2.new(0, 185, 0, 310), boxSize)
local AimButton = createButton("AimBotButton", "CamLock", UDim2.new(0, 15, 0, 350), btnSize)
local camDelayBox = createTextBox("CamDelayBox", "auto", UDim2.new(0,185,0,355), boxSize)
local SmoothButton = createButton("SmoothCamButton", "SmoothCam", UDim2.new(0, 15, 0, 395), btnSize)
local SmoothBox = createTextBox("SmoothCamBox", "0.2", UDim2.new(0, 185, 0, 400), boxSize)
local SpeedButton = createButton("SpeedChangeButton", "Change Speed", UDim2.new(0, 15, 0, 440), btnSize)
local SpeedBox = createTextBox("SpeedChangeBox", "16", UDim2.new(0, 185, 0, 445), boxSize)
local xyzButton = createButton("XYZTPButton", "TP XYZ", UDim2.new(0, 15, 0, 485), btnSize)
local xyzBox = createTextBox("XYZBox", "0,0,0", UDim2.new(0, 185, 0, 490), boxSize)
local loopSavedTPButton = createButton("LoopSavedTPButton", "Loop Saved TP", UDim2.new(0, 15, 0, 530), btnSize)

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
local loopSpeed = 0.5
local loopSavedTPEnabled = false

local function deactivateCurrentTP()
    if tpConnection then tpConnection:Disconnect(); tpConnection = nil end
    roofTpButton.BackgroundColor3 = redColor; roofTpButton.Text = "Roof TP"
    wallTpButton.BackgroundColor3 = redColor; wallTpButton.Text = "Wall TP"
    floorTpButton.BackgroundColor3 = redColor; floorTpButton.Text = "Floor TP"
    backTpButton.BackgroundColor3 = redColor; backTpButton.Text = "Back TP"
    activeTP = nil
    fixedPosition = nil
end

local function teleportLoop()
    local char = player.Character
    if not (char and char:FindFirstChild("HumanoidRootPart") and fixedPosition) then
        deactivateCurrentTP()
        return
    end
    local hrp = char.HumanoidRootPart
    if (hrp.Position - fixedPosition).Magnitude > 0.5 then
        hrp.Velocity = Vector3.new(0,0,0)
        hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(fixedPosition), loopSpeed)
    end
end

loopSavedTPButton.MouseButton1Click:Connect(function()
    loopSavedTPEnabled = not loopSavedTPEnabled
    loopSavedTPButton.BackgroundColor3 = loopSavedTPEnabled and greenColor or redColor
    if not loopSavedTPEnabled then
        deactivateCurrentTP()
        for j=1,6 do
            tpButtons[j].BackgroundColor3 = redColor
            tpButtons[j].Text = "TP "..j
        end
    end
end)

for i=1,6 do
    saveButtons[i].MouseButton1Click:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            savedPositions[i] = char.HumanoidRootPart.Position
            saveButtons[i].BackgroundColor3 = greenColor
            task.wait(0.2)
            saveButtons[i].BackgroundColor3 = redColor
        end
    end)
    tpButtons[i].MouseButton1Click:Connect(function()
        if not savedPositions[i] then return end
        local char = player.Character
        if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
        local hrp = char.HumanoidRootPart

        if loopSavedTPEnabled then
            if activeTP == "saved"..i then
                deactivateCurrentTP()
                tpButtons[i].BackgroundColor3 = redColor
                tpButtons[i].Text = "TP "..i
                return
            end
            deactivateCurrentTP()
            for j=1,6 do
                tpButtons[j].BackgroundColor3 = redColor
                tpButtons[j].Text = "TP "..j
            end
            activeTP = "saved"..i
            fixedPosition = savedPositions[i]
            tpButtons[i].BackgroundColor3 = greenColor
            tpButtons[i].Text = "Stop TP "..i
            hrp.CFrame = CFrame.new(fixedPosition)
            tpConnection = RunService.Heartbeat:Connect(teleportLoop)
        else
            hrp.CFrame = CFrame.new(savedPositions[i])
            tpButtons[i].BackgroundColor3 = greenColor
            task.wait(0.2)
            tpButtons[i].BackgroundColor3 = redColor
        end
    end)
end

local function setupTPButton(button, typeName, studsBox, vectorFunc, directional)
    button.MouseButton1Click:Connect(function()
        if activeTP == typeName then deactivateCurrentTP(); return end
        deactivateCurrentTP()
        activeTP = typeName
        button.Text = "Stop " .. button.Name:gsub("Button", "")
        button.BackgroundColor3 = greenColor
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local studs = tonumber(studsBox.Text) or 5
            if directional then
                local lookVector = hrp.CFrame.LookVector
                if typeName == "back" then lookVector = -lookVector end
                fixedPosition = hrp.Position + lookVector * studs
            else
                fixedPosition = vectorFunc(hrp.Position, studs)
            end
            hrp.CFrame = CFrame.new(fixedPosition)
            tpConnection = RunService.Heartbeat:Connect(teleportLoop)
        end
    end)
end

setupTPButton(roofTpButton, "roof", roofStudsBox, function(pos,s) return pos + Vector3.new(0,s,0) end, false)
setupTPButton(wallTpButton, "wall", wallStudsBox, function(pos,s) return pos + hrp.CFrame.LookVector * s end, false)
setupTPButton(floorTpButton, "floor", floorStudsBox, function(pos,s) return pos - Vector3.new(0,s,0) end, false)
setupTPButton(backTpButton, "back", backStudsBox, function(pos,s) return pos - hrp.CFrame.LookVector * s end, false)

jumpButton.MouseButton1Click:Connect(function()
    local num = tonumber(jumpPowerBox.Text)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") and num then
        local humanoid = char.Humanoid
        humanoid.UseJumpPower = true
        humanoid.JumpPower = num
        jumpButton.BackgroundColor3 = greenColor
        task.wait(0.2)
        jumpButton.BackgroundColor3 = redColor
    end
end)

loopSpeedButton.MouseButton1Click:Connect(function()
    local num = tonumber(loopSpeedBox.Text)
    if num and num > 0 and num <= 1 then
        loopSpeed = num
        loopSpeedButton.BackgroundColor3 = greenColor
        task.wait(0.2)
        loopSpeedButton.BackgroundColor3 = redColor
    end
end)

local isDragging = false
local dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
local camlockEnabled = false
local camTarget = nil
local smoothStrength = 0.2
local localPing = 0
local lastPingRequest = 0
local PING_COOLDOWN = 0.5

local function measureLocalPing()
    local startTime = tick()
    RunService.Heartbeat:Wait() 
    local endTime = tick()
    localPing = endTime - startTime
end

local function calculatePredictionTime(targetHrp)
    local cam = Workspace.CurrentCamera
    local distance = (targetHrp.Position - cam.CFrame.Position).Magnitude

    local predictionValue = 0
    local delaySetting = camDelayBox.Text:lower()

    if delaySetting == "auto" then
        if tick() - lastPingRequest > PING_COOLDOWN then
            lastPingRequest = tick()
            measureLocalPing()
        end
        predictionValue = localPing 
    else
        predictionValue = tonumber(delaySetting) or 0
    end

    local bulletSpeed = 500
    local bulletTravelTime = distance / bulletSpeed

    return predictionValue + bulletTravelTime
end

SmoothBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(SmoothBox.Text)
        smoothStrength = (val and math.clamp(val, 0, 1)) or 0.2
    end
end)

local function getClosestTargetToCursor()
    local cam = Workspace.CurrentCamera
    local mousePos = UserInputService:GetMouseLocation()
    mousePos = Vector2.new(mousePos.X, mousePos.Y - MOUSE_OFFSET_Y)

    local closestPlayer = nil
    local smallestDist = 200

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = otherPlayer.Character.HumanoidRootPart
            local screenPos, onScreen = cam:WorldToViewportPoint(targetHrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < smallestDist then
                    smallestDist = dist
                    closestPlayer = otherPlayer
                end
            end
        end
    end
    return closestPlayer
end

local function toggleCamlock(state)
    camlockEnabled = state
    AimButton.BackgroundColor3 = camlockEnabled and greenColor or redColor
    if camlockEnabled then
        camTarget = getClosestTargetToCursor()
    else
        camTarget = nil
    end
end

AimButton.MouseButton1Click:Connect(function()
    toggleCamlock(not camlockEnabled)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleCamlock(not camlockEnabled)
    end
end)

RunService.RenderStepped:Connect(function()
    if camlockEnabled and camTarget and camTarget.Character and camTarget.Character:FindFirstChild("HumanoidRootPart") then
        local targetHrp = camTarget.Character.HumanoidRootPart
        local cam = Workspace.CurrentCamera

        local predictionTime = calculatePredictionTime(targetHrp)
        local futurePos = targetHrp.Position + (targetHrp.Velocity * predictionTime)
        local targetCFrame = CFrame.new(cam.CFrame.Position, futurePos)

        cam.CFrame = cam.CFrame:Lerp(targetCFrame, smoothStrength)
    end
end)

local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
player.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
end)

local speedToggle = false
local speedConnection
local function applySpeed()
    if humanoid then
        local num = tonumber(SpeedBox.Text) or 16
        humanoid.WalkSpeed = math.clamp(num, 0, 1000)
    end
end

SpeedButton.MouseButton1Click:Connect(function()
    speedToggle = not speedToggle
    SpeedButton.BackgroundColor3 = speedToggle and greenColor or redColor
    if speedToggle then
        applySpeed()
        speedConnection = RunService.Heartbeat:Connect(applySpeed)
    else
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end)

xyzButton.MouseButton1Click:Connect(function()
    local char = player.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = char.HumanoidRootPart

    if xyzBox.Text:lower() == "location" then
        local pos = hrp.Position
        xyzBox.Text = string.format("%.1f,%.1f,%.1f", pos.X, pos.Y, pos.Z)
        xyzButton.BackgroundColor3 = greenColor
        task.wait(0.2)
        xyzButton.BackgroundColor3 = redColor
        return
    end

    local coords = {}
    for num in xyzBox.Text:gmatch("[^,]+") do
        table.insert(coords, tonumber(num))
    end

    if #coords == 3 then
        hrp.CFrame = CFrame.new(coords[1], coords[2], coords[3])
        xyzButton.BackgroundColor3 = greenColor
        task.wait(0.2)
        xyzButton.BackgroundColor3 = redColor
    else
        xyzButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
        task.wait(0.5)
        xyzButton.BackgroundColor3 = redColor
    end
end)
