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

-- ===== Drag fluido compatible PC, móvil y tablet para frame =====
local draggingFrame = false
local dragInputFrame, dragStartFrame, startPosFrame

local function updateFrameDrag(input)
    local delta = input.Position - dragStartFrame
    local goal = UDim2.new(
        startPosFrame.X.Scale,
        startPosFrame.X.Offset + delta.X,
        startPosFrame.Y.Scale,
        startPosFrame.Y.Offset + delta.Y
    )
    RunService:BindToRenderStep("DragFrame", Enum.RenderPriority.Input.Value, function()
        if draggingFrame then
            frame.Position = frame.Position:Lerp(goal, 0.2) -- movimiento suave
        else
            RunService:UnbindFromRenderStep("DragFrame")
        end
    end)
end

-- Detectar inicio del drag (Mouse o Touch)
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = true
        dragStartFrame = input.Position
        startPosFrame = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingFrame = false
            end
        end)
    end
end)

-- Detectar cambios de input
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputFrame = input
    end
end)

-- Actualizar posición mientras se arrastra
UIS.InputChanged:Connect(function(input)
    if input == dragInputFrame and draggingFrame then
        updateFrameDrag(input)
    end
end)

-- Crear el frame flotante de jugadores
local playersFrame = Instance.new("Frame")
playersFrame.Name = "PlayersFrame"
playersFrame.Size = UDim2.new(0, 220, 0, 320)
playersFrame.Position = UDim2.new(0, 300, 0, 10)
playersFrame.BackgroundTransparency = 0.5
playersFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
playersFrame.BorderSizePixel = 0
playersFrame.Visible = false
playersFrame.Parent = frame

local playersCorner = Instance.new("UICorner")
playersCorner.CornerRadius = UDim.new(0, 10)
playersCorner.Parent = playersFrame

local playersTop = Instance.new("Frame")
playersTop.Size = UDim2.new(1, 0, 0, 24)
playersTop.Position = UDim2.new(0, 0, 0, 0)
playersTop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playersTop.BackgroundTransparency = 0.2
playersTop.Parent = playersFrame

local playersTopCorner = Instance.new("UICorner")
playersTopCorner.CornerRadius = UDim.new(0, 8)
playersTopCorner.Parent = playersTop

local playersLabel = Instance.new("TextLabel")
playersLabel.Size = UDim2.new(1, 0, 0, 24)
playersLabel.Position = UDim2.new(0, 0, 0, 0)
playersLabel.BackgroundTransparency = 1
playersLabel.Text = "Jugadores en el servidor"
playersLabel.TextColor3 = Color3.fromRGB(255,255,255)
playersLabel.Font = Enum.Font.SourceSansBold
playersLabel.TextSize = 18
playersLabel.Parent = playersTop

local playersScroll = Instance.new("ScrollingFrame")
playersScroll.Name = "PlayersScroll"
playersScroll.Size = UDim2.new(1, -12, 1, -32)
playersScroll.Position = UDim2.new(0, 6, 0, 28)
playersScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
playersScroll.ScrollBarThickness = 8
playersScroll.BackgroundTransparency = 1
playersScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
playersScroll.ScrollBarImageTransparency = 0.2
playersScroll.Parent = playersFrame

local actionFrame = nil
local esp2dEnabled = false
local esp2dTarget = nil
local tracerEnabled = false
local tracerTarget = nil
local tracerDrawing = nil

local function closeActionFrame()
    if actionFrame then
        actionFrame:Destroy()
        actionFrame = nil
        esp2dEnabled = false
        esp2dTarget = nil
        tracerEnabled = false
        tracerTarget = nil
        if tracerDrawing then
            tracerDrawing.Visible = false
            tracerDrawing:Remove()
            tracerDrawing = nil
        end
    end
end

local function openActionFrame(targetPlayer)
    closeActionFrame()
    actionFrame = Instance.new("Frame")
    actionFrame.Name = "PlayerActionFrame"
    actionFrame.Size = UDim2.new(0, 180, 0, 160)
    actionFrame.Position = UDim2.new(0, playersFrame.Position.X.Offset + playersFrame.Size.X.Offset + 10, 0, playersFrame.Position.Y.Offset)
    actionFrame.BackgroundTransparency = 0.25
    actionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    actionFrame.BorderSizePixel = 0
    actionFrame.Parent = frame
    actionFrame.ZIndex = 20

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = actionFrame

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 22)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.Parent = actionFrame
    topBar.ZIndex = 21

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 8)
    topCorner.Parent = topBar

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 22)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = ""..targetPlayer.Name
    nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 16
    nameLabel.Parent = topBar
    nameLabel.ZIndex = 22

    -- Drag para actionFrame
    local draggingAF = false
    local dragInputAF, dragStartAF, startPosAF
    local function updateAF(input)
        local delta = input.Position - dragStartAF
        local goal = UDim2.new(startPosAF.X.Scale, startPosAF.X.Offset + delta.X, startPosAF.Y.Scale, startPosAF.Y.Offset + delta.Y)
        RunService:BindToRenderStep("DragActionFrame", Enum.RenderPriority.Input.Value, function()
            if draggingAF then
                actionFrame.Position = actionFrame.Position:Lerp(goal, 0.2)
            else
                RunService:UnbindFromRenderStep("DragActionFrame")
            end
        end)
    end
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingAF = true
            dragStartAF = input.Position
            startPosAF = actionFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingAF = false
                end
            end)
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInputAF = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInputAF and draggingAF then
            updateAF(input)
        end
    end)

    -- Botón TP local
    local tpBtn = Instance.new("TextButton")
    tpBtn.Name = "TPToPlayerBtn"
    tpBtn.Size = UDim2.new(0, 150, 0, 32)
    tpBtn.Position = UDim2.new(0, 15, 0, 32)
    tpBtn.Text = "TP a "..targetPlayer.Name
    tpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    tpBtn.TextColor3 = Color3.new(1, 1, 1)
    tpBtn.Font = Enum.Font.SourceSansBold
    tpBtn.TextSize = 16
    tpBtn.Parent = actionFrame
    tpBtn.ZIndex = 23
    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0, 7)
    tpCorner.Parent = tpBtn

    tpBtn.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = targetPlayer.Character.HumanoidRootPart
            if hrp then
                hrp.CFrame = targetHRP.CFrame + Vector3.new(0,2,0)
                tpBtn.BackgroundColor3 = greenColor
                wait(0.2)
                tpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end)

    -- Botón ESP2D
    local espBtn = Instance.new("TextButton")
    espBtn.Name = "ESP2DBtn"
    espBtn.Size = UDim2.new(0, 150, 0, 32)
    espBtn.Position = UDim2.new(0, 15, 0, 70)
    espBtn.Text = "ESP: OFF"
    espBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    espBtn.TextColor3 = Color3.new(1, 1, 1)
    espBtn.Font = Enum.Font.SourceSansBold
    espBtn.TextSize = 16
    espBtn.Parent = actionFrame
    espBtn.ZIndex = 23
    local espCorner = Instance.new("UICorner")
    espCorner.CornerRadius = UDim.new(0, 7)
    espCorner.Parent = espBtn

    espBtn.MouseButton1Click:Connect(function()
        esp2dEnabled = not esp2dEnabled
        if esp2dEnabled then
            espBtn.Text = "ESP : ON"
            espBtn.BackgroundColor3 = greenColor
            esp2dTarget = targetPlayer
        else
            espBtn.Text = "ESP : OFF"
            espBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            esp2dTarget = nil
        end
    end)

    -- Botón Tracer
    local tracerBtn = Instance.new("TextButton")
    tracerBtn.Name = "TracerBtn"
    tracerBtn.Size = UDim2.new(0, 150, 0, 32)
    tracerBtn.Position = UDim2.new(0, 15, 0, 108)
    tracerBtn.Text = "Tracer : OFF"
    tracerBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    tracerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tracerBtn.Font = Enum.Font.SourceSansBold
    tracerBtn.TextSize = 16
    tracerBtn.Parent = actionFrame
    tracerBtn.ZIndex = 23
    
    local tracerCorner = Instance.new("UICorner")
    tracerCorner.CornerRadius = UDim.new(0, 7)
    tracerCorner.Parent = tracerBtn

    tracerBtn.MouseButton1Click:Connect(function()
        tracerEnabled = not tracerEnabled
        if tracerEnabled then
            tracerBtn.Text = "Tracer : ON"
            tracerBtn.BackgroundColor3 = greenColor
            tracerTarget = targetPlayer
        else
            tracerBtn.Text = "Tracer : OFF"
            tracerBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
            tracerTarget = nil
            if tracerDrawing then
                tracerDrawing.Visible = false
                tracerDrawing:Remove()
                tracerDrawing = nil
            end
        end
    end)

    -- Botón cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseActionBtn"
    closeBtn.Size = UDim2.new(0, 22, 0, 22)
    closeBtn.Position = UDim2.new(1, -22, 0, 0)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 16
    closeBtn.Parent = actionFrame
    closeBtn.ZIndex = 24
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 7)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        closeActionFrame()
    end)
end
local utilitiesFrame = Instance.new("Frame")
utilitiesFrame.Name = "UtilitiesFrame"
utilitiesFrame.Size = UDim2.new(0, 220, 0, 320)
utilitiesFrame.Position = UDim2.new(0, 300, 0, 10)
utilitiesFrame.BackgroundTransparency = 0.5
utilitiesFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
utilitiesFrame.BorderSizePixel = 0
utilitiesFrame.Visible = false
utilitiesFrame.Parent = frame

local utilitiesCorner = Instance.new("UICorner")
utilitiesCorner.CornerRadius = UDim.new(0, 10)
utilitiesCorner.Parent = utilitiesFrame

local utilitiesTop = Instance.new("Frame")
utilitiesTop.Size = UDim2.new(1, 0, 0, 24)
utilitiesTop.Position = UDim2.new(0, 0, 0, 0)
utilitiesTop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
utilitiesTop.BackgroundTransparency = 0.2
utilitiesTop.Parent = utilitiesFrame

local utilitiesTopCorner = Instance.new("UICorner")
utilitiesTopCorner.CornerRadius = UDim.new(0, 8)
utilitiesTopCorner.Parent = utilitiesTop

local utilitiesLabel = Instance.new("TextLabel")
utilitiesLabel.Size = UDim2.new(1, 0, 0, 24)
utilitiesLabel.Position = UDim2.new(0, 0, 0, 0)
utilitiesLabel.BackgroundTransparency = 1
utilitiesLabel.Text = "Utilities"
utilitiesLabel.TextColor3 = Color3.fromRGB(255,255,255)
utilitiesLabel.Font = Enum.Font.SourceSansBold
utilitiesLabel.TextSize = 18
utilitiesLabel.Parent = utilitiesTop

local utilitiesScroll = Instance.new("ScrollingFrame")
utilitiesScroll.Name = "PlayersScroll"
utilitiesScroll.Size = UDim2.new(1, -12, 1, -32)
utilitiesScroll.Position = UDim2.new(0, 6, 0, 28)
utilitiesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
utilitiesScroll.ScrollBarThickness = 8
utilitiesScroll.BackgroundTransparency = 1
utilitiesScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
utilitiesScroll.ScrollBarImageTransparency = 0.2
utilitiesScroll.Parent = utilitiesFrame

-- Botón SpeedLoopMode
local flyButton = Instance.new("TextButton")
flyButton.Name = "SpeedLoopButton"
flyButton.Size = UDim2.new(0, 150, 0, 42)
flyButton.Position = UDim2.new(0, 28, 0, 5)
flyButton.Text = "Speed Loop Mode"
flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.SourceSansBold
flyButton.TextSize = 16
flyButton.Parent = utilitiesScroll
flyButton.ZIndex = 23

local loopFlyCorner = Instance.new("UICorner")
loopFlyCorner.CornerRadius = UDim.new(0, 8)
loopFlyCorner.Parent = flyButton

-- TextBox para "studs" (distancia objetivo)
local studsBox1 = Instance.new("TextBox")
studsBox1.Size = UDim2.new(0, 80, 1, 0)
studsBox1.Position = UDim2.new(1, -158, 0, 44)
studsBox1.Parent = flyButton
studsBox1.Text = "15"
studsBox1.PlaceholderText = "Studs"
studsBox1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
studsBox1.TextColor3 = Color3.new(1, 1, 1)

local studsCorner = Instance.new("UICorner")
studsCorner.CornerRadius = UDim.new(0, 8)
studsCorner.Parent = studsBox1

-- TextBox para "FlySpeed" (fluidez)
local speedBox1 = Instance.new("TextBox")
speedBox1.Size = UDim2.new(0, 80, 1, 0)
speedBox1.Position = UDim2.new(1, -68, 0, 44)
speedBox1.Parent = flyButton
speedBox1.Text = "16"
speedBox1.PlaceholderText = "Speed"
speedBox1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox1.TextColor3 = Color3.new(1, 1, 1)

local speedBoxCorner = Instance.new("UICorner")
speedBoxCorner.CornerRadius = UDim.new(0, 8)
speedBoxCorner.Parent = speedBox1

local button = Instance.new("TextButton")
button.Name = "SitButton"
button.Size = UDim2.new(0, 150, 0, 42)
button.Position = UDim2.new(0, 28, 0, 95)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- rojo inicial
button.Text = "Sentarse"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Parent = utilitiesScroll
button.ZIndex = 23

local buttonCornerSit = Instance.new("UICorner")
buttonCornerSit.CornerRadius = UDim.new(0, 8)
buttonCornerSit.Parent = button

-- Botón Loop Fly
local loopFlyButton = Instance.new("TextButton")
loopFlyButton.Name = "LoopFlyButton"
loopFlyButton.Text = "Loop Fly (OFF)"
loopFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loopFlyButton.Size = UDim2.new(0, 150, 0, 42)
loopFlyButton.Position = UDim2.new(0, 28, 0, 140)
loopFlyButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
loopFlyButton.Parent = utilitiesScroll
loopFlyButton.Font = Enum.Font.SourceSansBold
loopFlyButton.TextSize = 16
loopFlyButton.ZIndex = 23

local loopFlyButtonCorner = Instance.new("UICorner")
loopFlyButtonCorner.CornerRadius = UDim.new(0, 8)
loopFlyButtonCorner.Parent = loopFlyButton

-- TextBox Studs
local studsBox2 = Instance.new("TextBox")
studsBox2.Name = "StudsBoxx"
studsBox2.PlaceholderText = "Studs"
studsBox2.Text = "150"
studsBox2.Size = UDim2.new(0, 80, 1, 0)
studsBox2.Position = UDim2.new(1, -156, 0, 44)
studsBox2.Parent = loopFlyButton
studsBox2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
studsBox2.TextColor3 = Color3.new(1, 1, 1)

local studsBox2Corner = Instance.new("UICorner")
studsBox2Corner.CornerRadius = UDim.new(0, 8)
studsBox2Corner.Parent = studsBox2

-- TextBox Speed
local speedBox2 = Instance.new("TextBox")
speedBox2.Name = "SpeedBox"
speedBox2.PlaceholderText = "FlySpeed"
speedBox2.Text = "16"
speedBox2.Size = UDim2.new(0, 80, 1, 0)
speedBox2.Position = UDim2.new(1, -64, 0, 44)
speedBox2.Parent = loopFlyButton
speedBox2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox2.TextColor3 = Color3.new(1, 1, 1)

local speedBox2Corner = Instance.new("UICorner")
speedBox2Corner.CornerRadius = UDim.new(0, 8)
speedBox2Corner.Parent = speedBox2

local fovBox = createTextBox("FOVBox", "FOV (ej: 120)", UDim2.new(0, 75, 0, 240), boxSize)
fovBox.Parent = utilitiesScroll
fovBox.FocusLost:Connect(function()
    local fov = tonumber(fovBox.Text)
    if fov and fov >= 10 and fov <= 120 then
        workspace.CurrentCamera.FieldOfView = fov
    end
    fovBox.Text = ""
end)
-- Variables
local activo = false
local rojo = Color3.fromRGB(255, 0, 0)
local verde = Color3.fromRGB(0, 255, 0)

-- Función cambiar estado
local function cambiarEstado()
    activo = not activo
    
    if activo then
        humanoid.Sit = true
        button.Text = "Sentado"
        button.BackgroundColor3 = verde
    else
        humanoid.Sit = false
        button.Text = "Sentarse"
        button.BackgroundColor3 = rojo
    end
end

-- Click en el botón
button.MouseButton1Click:Connect(cambiarEstado)

-- Si salta, se desactiva
humanoid.StateChanged:Connect(function(_, newState)
    if activo and newState == Enum.HumanoidStateType.Jumping then
        activo = false
        button.Text = "Sentarse"
        button.BackgroundColor3 = rojo
    end
end)
-- Alternar visibilidad con el botón "Utilities"
pag2.MouseButton1Click:Connect(function()
    utilitiesFrame.Visible = not utilitiesFrame.Visible
end)

local function makePlayerLabel(name, isLocal, playerObj)
    local label = Instance.new("TextButton")
    label.Size = UDim2.new(1, 0, 0, 32)
    label.BackgroundTransparency = 0.2
    label.BackgroundColor3 = isLocal and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(40, 40, 40)
    label.Text = name
    label.TextColor3 = isLocal and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16
    label.ZIndex = 10
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = label
    label.Parent = playersScroll

local list = Instance.new("UIListLayout")
list.FillDirection = Enum.FillDirection.Vertical
list.Padding = UDim.new(0, 2)
list.Parent = playersScroll

    -- Click para abrir ventana de acciones
    if not isLocal then
        label.MouseButton1Click:Connect(function()
            -- Si ya hay una ventana abierta, ciérrala antes de abrir la nueva
            if actionFrame then
                closeActionFrame()
            end
            -- No abrir ventana si haces click en ti mismo
            if playerObj and playerObj ~= player then
                openActionFrame(playerObj)
            end
        end)
    end
    return label
end

-- ===== Drag fluido compatible PC, móvil y tablet para utilitiesFrame =====
local draggingUtilities = false
local dragInputUtilities, dragStartUtilities, startPosUtilities

local function updateUtilitiesDrag(input)
    local delta = input.Position - dragStartUtilities
    local goal = UDim2.new(
        startPosUtilities.X.Scale,
        startPosUtilities.X.Offset + delta.X,
        startPosUtilities.Y.Scale,
        startPosUtilities.Y.Offset + delta.Y
    )
    RunService:BindToRenderStep("DragUtilitiesFrame", Enum.RenderPriority.Input.Value, function()
        if draggingUtilities then
            utilitiesFrame.Position = utilitiesFrame.Position:Lerp(goal, 0.2)
        else
            RunService:UnbindFromRenderStep("DragUtilitiesFrame")
        end
    end)
end

-- Detectar inicio del drag (Mouse o Touch)
utilitiesTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingUtilities = true
        dragStartUtilities = input.Position
        startPosUtilities = utilitiesFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingUtilities = false
            end
        end)
    end
end)

-- Detectar cambios de input
utilitiesTop.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputUtilities = input
    end
end)

-- Actualizar posición mientras se arrastra
UIS.InputChanged:Connect(function(input)
    if input == dragInputUtilities and draggingUtilities then
        updateUtilitiesDrag(input)
    end
end)

-- ===== Drag fluido compatible PC, móvil y tablet para playersFrame =====
local draggingPlayers = false
local dragInputPlayers, dragStartPlayers, startPosPlayers

local function updatePlayersDrag(input)
    local delta = input.Position - dragStartPlayers
    local goal = UDim2.new(
        startPosPlayers.X.Scale,
        startPosPlayers.X.Offset + delta.X,
        startPosPlayers.Y.Scale,
        startPosPlayers.Y.Offset + delta.Y
    )
    RunService:BindToRenderStep("DragPlayersFrame", Enum.RenderPriority.Input.Value, function()
        if draggingPlayers then
            playersFrame.Position = playersFrame.Position:Lerp(goal, 0.2)
        else
            RunService:UnbindFromRenderStep("DragPlayersFrame")
        end
    end)
end

-- Detectar inicio del drag (Mouse o Touch)
playersTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingPlayers = true
        dragStartPlayers = input.Position
        startPosPlayers = playersFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingPlayers = false
            end
        end)
    end
end)

-- Detectar cambios de input
playersTop.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputPlayers = input
    end
end)

-- Actualizar posición mientras se arrastra
UIS.InputChanged:Connect(function(input)
    if input == dragInputPlayers and draggingPlayers then
        updatePlayersDrag(input)
    end
end)

-- Alternar visibilidad con el botón "Players"
pag1.MouseButton1Click:Connect(function()
    playersFrame.Visible = not playersFrame.Visible
end)

-- Refresco eficiente de la lista de jugadores
local lastPlayers = {}
local function getPlayersList()
    local list = {}
    for _, plr in Players:GetPlayers() do
        table.insert(list, plr.Name)
    end
    return list
end

local function areListsEqual(listA, listB)
    if #listA ~= #listB then return false end
    for i = 1, #listA do
        if listA[i] ~= listB[i] then return false end
    end
    return true
end

local function refreshPlayersUI()
    -- Limpiar los labels anteriores
    for _, child in pairs(playersScroll:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    local playersList = getPlayersList()
    for i = 1, #playersList do
        local plrObj = nil
        for _, plr in Players:GetPlayers() do
            if plr.Name == playersList[i] then
                plrObj = plr
                break
            end
        end
        makePlayerLabel(playersList[i], playersList[i] == player.Name, plrObj)
    end
    -- Scroll optimizado: solo si hay muchos jugadores
    local maxVisible = math.floor(playersScroll.AbsoluteSize.Y / 50) -- cada label mide 32 + 2 margen
    if #playersList > maxVisible then
        playersScroll.CanvasSize = UDim2.new(0, 0, 0, #playersList * 50)
        playersScroll.ScrollingEnabled = true
    else
        playersScroll.CanvasSize = UDim2.new(0, 0, 0, playersScroll.AbsoluteSize.Y)
        playersScroll.ScrollingEnabled = false
        playersScroll.CanvasPosition = Vector2.new(0, 0)
    end
end

-- Actualizar la lista cada 0.5 segundos solo si hay cambios
task.spawn(function()
    while true do
        local currentPlayers = getPlayersList()
        if not areListsEqual(currentPlayers, lastPlayers) then
            refreshPlayersUI()
            lastPlayers = currentPlayers
        end
        task.wait(0.5)
    end
end)

local espDrawing = nil
RunService.RenderStepped:Connect(function()
    -- ESP2D
    if esp2dEnabled and esp2dTarget and esp2dTarget.Character and esp2dTarget.Character:FindFirstChild("HumanoidRootPart") then
        local cam = workspace.CurrentCamera
        local hrp = esp2dTarget.Character.HumanoidRootPart
        local head = esp2dTarget.Character:FindFirstChild("Head")
        if not head then return end
        local sizeY = (hrp.Position.Y - head.Position.Y) + 2.5
        local sizeX = 1
        local worldPos = hrp.Position
        local screenPos, onScreen = cam:WorldToViewportPoint(worldPos)
        if onScreen then
            if not espDrawing then
                espDrawing = Drawing.new("Square")
                espDrawing.Thickness = 2
                espDrawing.Filled = false
                espDrawing.Color = Color3.fromRGB(255,255,255)
            end
            espDrawing.Visible = true
            espDrawing.Size = Vector2.new(sizeX*22, sizeY*22)
            espDrawing.Position = Vector2.new(screenPos.X - (sizeX*11), screenPos.Y - (sizeY*11))
        else
            if espDrawing then espDrawing.Visible = false end
        end
    else
        if espDrawing then espDrawing.Visible = false end
    end

    -- TRACER
    if tracerEnabled and tracerTarget and tracerTarget.Character and tracerTarget.Character:FindFirstChild("HumanoidRootPart") then
        local cam = workspace.CurrentCamera
        local hrp = tracerTarget.Character.HumanoidRootPart
        local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        local mousePos = UIS:GetMouseLocation()
        if onScreen then
            if not tracerDrawing then
                tracerDrawing = Drawing.new("Line")
                tracerDrawing.Thickness = 2
                tracerDrawing.Color = Color3.fromRGB(255,255,255)
            end
            tracerDrawing.Visible = true
            tracerDrawing.From = Vector2.new(mousePos.X, mousePos.Y)
            tracerDrawing.To = Vector2.new(screenPos.X, screenPos.Y)
        else
            if tracerDrawing then tracerDrawing.Visible = false end
        end
    else
        if tracerDrawing then
            tracerDrawing.Visible = false
        end
    end
end)

-- Limpiar ESP2D y Tracer al cerrar ventana de acciones
if actionFrame then
    actionFrame.Destroying:Connect(function()
        if espDrawing then
            espDrawing.Visible = false
            espDrawing:Remove()
            espDrawing = nil
        end
        esp2dEnabled = false
        esp2dTarget = nil
        if tracerDrawing then
            tracerDrawing.Visible = false
            tracerDrawing:Remove()
            tracerDrawing = nil
        end
        tracerEnabled = false
        tracerTarget = nil
    end)
end

local gamesFrame = Instance.new("Frame")
gamesFrame.Name = "GamesFrame"
gamesFrame.Size = UDim2.new(0, 220, 0, 320)
gamesFrame.Position = UDim2.new(0, 300, 0, 10)
gamesFrame.BackgroundTransparency = 0.5
gamesFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
gamesFrame.BorderSizePixel = 0
gamesFrame.Visible = false
gamesFrame.Parent = frame

local gamesCorner = Instance.new("UICorner")
gamesCorner.CornerRadius = UDim.new(0, 10)
gamesCorner.Parent = gamesFrame

local gamesTop = Instance.new("Frame")
gamesTop.Size = UDim2.new(1, 0, 0, 24)
gamesTop.Position = UDim2.new(0, 0, 0, 0)
gamesTop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gamesTop.BackgroundTransparency = 0.2
gamesTop.Parent = gamesFrame

local gamesTopCorner = Instance.new("UICorner")
gamesTopCorner.CornerRadius = UDim.new(0, 8)
gamesTopCorner.Parent = gamesTop

local gamesLabel = Instance.new("TextLabel")
gamesLabel.Size = UDim2.new(1, 0, 0, 24)
gamesLabel.Position = UDim2.new(0, 0, 0, 0)
gamesLabel.BackgroundTransparency = 1
gamesLabel.Text = "Games"
gamesLabel.TextColor3 = Color3.fromRGB(255,255,255)
gamesLabel.Font = Enum.Font.SourceSansBold
gamesLabel.TextSize = 18
gamesLabel.Parent = gamesTop

local gamesScroll = Instance.new("ScrollingFrame")
gamesScroll.Name = "PlayersScroll"
gamesScroll.Size = UDim2.new(1, -12, 1, -32)
gamesScroll.Position = UDim2.new(0, 6, 0, 28)
gamesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
gamesScroll.ScrollBarThickness = 8
gamesScroll.BackgroundTransparency = 1
gamesScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
gamesScroll.ScrollBarImageTransparency = 0.2
gamesScroll.Parent = gamesFrame

local listGames = Instance.new("UIListLayout")
listGames.FillDirection = Enum.FillDirection.Vertical
listGames.Padding = UDim.new(0, 4)
listGames.Parent = gamesScroll
listGames.SortOrder = Enum.SortOrder.LayoutOrder
listGames.HorizontalAlignment = Enum.HorizontalAlignment.Center

local inkGamesButton = Instance.new("TextButton")
inkGamesButton.Name = "InkGameButton"
inkGamesButton.Size = UDim2.new(0, 150, 0, 42)
inkGamesButton.Position = UDim2.new(0, 28, 0, 5)
inkGamesButton.Text = "Load Ink Game Script V1"
inkGamesButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
inkGamesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
inkGamesButton.Font = Enum.Font.SourceSansBold
inkGamesButton.TextSize = 16
inkGamesButton.Parent = gamesScroll
inkGamesButton.ZIndex = 23
inkGamesButton.LayoutOrder = 1

local inkGamesTopCorner = Instance.new("UICorner")
inkGamesTopCorner.CornerRadius = UDim.new(0, 8)
inkGamesTopCorner.Parent = inkGamesButton

local inkGamesV2Button = Instance.new("TextButton")
inkGamesV2Button.Name = "InkGameV2Button"
inkGamesV2Button.Size = UDim2.new(0, 150, 0, 42)
inkGamesV2Button.Position = UDim2.new(0, 28, 0, 5)
inkGamesV2Button.Text = "Load Ink Game Script V2"
inkGamesV2Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
inkGamesV2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
inkGamesV2Button.Font = Enum.Font.SourceSansBold
inkGamesV2Button.TextSize = 16
inkGamesV2Button.Parent = gamesScroll
inkGamesV2Button.ZIndex = 23
inkGamesV2Button.LayoutOrder = 2

local inkGamesV2TopCorner = Instance.new("UICorner")
inkGamesV2TopCorner.CornerRadius = UDim.new(0, 8)
inkGamesV2TopCorner.Parent = inkGamesV2Button

local daHoodv1Button = Instance.new("TextButton")
daHoodv1Button.Name = "DaHoodv1Button"
daHoodv1Button.Size = UDim2.new(0, 150, 0, 42)
daHoodv1Button.Position = UDim2.new(0, 28, 0, 5)
daHoodv1Button.Text = "Load AzureModded"
daHoodv1Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
daHoodv1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
daHoodv1Button.Font = Enum.Font.SourceSansBold
daHoodv1Button.TextSize = 16
daHoodv1Button.Parent = gamesScroll
daHoodv1Button.ZIndex = 23
daHoodv1Button.LayoutOrder = 3

local DaHoodv1TopCorner = Instance.new("UICorner")
DaHoodv1TopCorner.CornerRadius = UDim.new(0, 8)
DaHoodv1TopCorner.Parent = daHoodv1Button

-- Script Raw -Loadstring 

inkGamesButton.MouseButton1Click:Connect(function()
    pcall(function()
        inkGamesButton.Text = "Loading. . ."
        inkGamesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua", true))()
    end)
    inkGamesButton.Text = "Load Ink Game Script V1"
    inkGamesButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    task.wait(5)
end)

inkGamesV2Button.MouseButton1Click:Connect(function()
    pcall(function()
        inkGamesV2Button.Text = "Not Available. . ."
        inkGamesV2Button.BackgroundColor3 = Color3.fromRGB(125, 0, 0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.json", true))()
    end)
    inkGamesV2Button.Text = "Load Ink Game Script V2"
    inkGamesV2Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    task.wait(5)
end)

daHoodv1Button.MouseButton1Click:Connect(function()
    pcall(function()
        daHoodv1Button.Text = "Loading. . ."
        daHoodv1Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
    end)
    daHoodv1Button.Text = "Load AzureModded"
    daHoodv1Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    task.wait(5)
end)

-- Alternar visibilidad con el botón "Games"
pag3.MouseButton1Click:Connect(function()
    gamesFrame.Visible = not gamesFrame.Visible
end)

-- ===== Drag fluido para gamesFrame =====
local draggingGames = false
local dragInputGames, dragStartGames, startPosGames

local function updateGamesDrag(input)
    local delta = input.Position - dragStartGames
    local goal = UDim2.new(
        startPosGames.X.Scale,
        startPosGames.X.Offset + delta.X,
        startPosGames.Y.Scale,
        startPosGames.Y.Offset + delta.Y
    )
    RunService:BindToRenderStep("DragGamesFrame", Enum.RenderPriority.Input.Value, function()
        if draggingGames then
            gamesFrame.Position = gamesFrame.Position:Lerp(goal, 0.2) -- movimiento suave
        else
            RunService:UnbindFromRenderStep("DragGamesFrame")
        end
    end)
end

-- Detectar inicio del drag
gamesTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingGames = true
        dragStartGames = input.Position
        startPosGames = gamesFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingGames = false
            end
        end)
    end
end)

-- Detectar cambio de input (mouse o touch)
gamesTop.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputGames = input
    end
end)

-- Actualizar posición mientras se arrastra
UIS.InputChanged:Connect(function(input)
    if input == dragInputGames and draggingGames then
        updateGamesDrag(input)
    end
end)


local wasdFrame = Instance.new("Frame")
wasdFrame.Name = "WasdFrame"
wasdFrame.Size = UDim2.new(0, 220, 0, 160)
wasdFrame.Position = UDim2.new(0, 300, 0, 10)
wasdFrame.BackgroundTransparency = 0.5
wasdFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
wasdFrame.BorderSizePixel = 0
wasdFrame.Visible = false
wasdFrame.Parent = frame

local wasdCorner = Instance.new("UICorner")
wasdCorner.CornerRadius = UDim.new(0, 10)
wasdCorner.Parent = wasdFrame

local wasdTop = Instance.new("Frame")
wasdTop.Size = UDim2.new(1, 0, 0, 24)
wasdTop.Position = UDim2.new(0, 0, 0, 0)
wasdTop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
wasdTop.BackgroundTransparency = 0.2
wasdTop.Parent = wasdFrame

local wasdTopCorner = Instance.new("UICorner")
wasdTopCorner.CornerRadius = UDim.new(0, 8)
wasdTopCorner.Parent = wasdTop

local wasdLabel = Instance.new("TextLabel")
wasdLabel.Size = UDim2.new(1, 0, 0, 24)
wasdLabel.Position = UDim2.new(0, 0, 0, 0)
wasdLabel.BackgroundTransparency = 1
wasdLabel.Text = "WASDCONTROL"
wasdLabel.TextColor3 = Color3.fromRGB(255,255,255)
wasdLabel.Font = Enum.Font.SourceSansBold
wasdLabel.TextSize = 18
wasdLabel.Parent = wasdTop

local pagwasd = Instance.new("TextButton") 
pagwasd.Name = "pagwasd"
pagwasd.Size = UDim2.new(0, 50, 0, 25)
pagwasd.Position = UDim2.new(0, 170, 0, 0)
pagwasd.Text = "WASD"
pagwasd.BackgroundTransparency = 0
pagwasd.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
pagwasd.TextColor3 = Color3.new(1, 1, 1)
pagwasd.Font = Enum.Font.SourceSans
pagwasd.TextSize = 16
pagwasd.Parent = gamesTop

local wasdPagCorner = Instance.new("UICorner")
wasdPagCorner.CornerRadius = UDim.new(0, 8)
wasdPagCorner.Parent = pagwasd

-- Alternar visibilidad con el botón "WasdFrame"
pagwasd.MouseButton1Click:Connect(function()
    wasdFrame.Visible = not wasdFrame.Visible
    pagwasd.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    wait(0.2)
    pagwasd.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end)

-- Botones WASD dentro del wasdFrame
local function createButtonV2(name, text, size, position, parent)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = size
    btn.Position = position
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    return btn
end

-- Crear los botones
local wBtn = createButtonV2("W", "W", UDim2.new(0, 50, 0, 50), UDim2.new(0.5, -25, 0, 30), wasdFrame)
local sBtn = createButtonV2("S", "S", UDim2.new(0, 50, 0, 50), UDim2.new(0.5, -25, 0, 90), wasdFrame)
local aBtn = createButtonV2("A", "A", UDim2.new(0, 50, 0, 50), UDim2.new(0, 40, 0, 60), wasdFrame)
local dBtn = createButtonV2("D", "D", UDim2.new(0, 50, 0, 50), UDim2.new(1, -90, 0, 60), wasdFrame)

-- Eventos de prueba (aquí puedes conectar con tu lógica de movimiento)
local function connectBtn(btn, key)
    btn.MouseButton1Down:Connect(function()
        print(key.." presionado")
    end)
    btn.MouseButton1Up:Connect(function()
        print(key.." soltado")
    end)
end

connectBtn(wBtn, "W")
connectBtn(aBtn, "A")
connectBtn(sBtn, "S")
connectBtn(dBtn, "D")

-- Drag suave del wasdTop con delay de 1 segundo
local dragging = false
local dragStart, startPos
local dragDelay = 1 -- segundos
local dragTimer = nil

local UserInputService = game:GetService("UserInputService")

local function updateDrag(input)
    local delta = input.Position - dragStart
    wasdFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

wasdTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = wasdFrame.Position
        dragTimer = task.delay(dragDelay, function()
            dragging = true
        end)
    end
end)

wasdTop.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

wasdTop.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragTimer then
            task.cancel(dragTimer)
            dragTimer = nil
        end
        dragging = false
    end
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

    for _, plr in Players:GetPlayers() do
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

-- Activar/Desactivar CamLock con Q, C, Tab
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.C then -- Aqui Cambia la tecla por cual quieras, Default Key : Q
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
        local hrp = CamTarget.Character.Head --HumanoidRootPart - Head
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
-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Variables de estado
local speedLoopActive = false
local flyLoopActive = false
local speedLoopConnection = nil
local flyLoopConnection = nil
local prevAutoRotateSpeed = nil
local moveKeys = {W=false, A=false, S=false, D=false}
local targetPosition

-- Referencias dinámicas
local function getChar()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    return char, hrp, humanoid
end

local function clamp(n, a, b) return math.max(a, math.min(b, n)) end

-- ================== LOOP FLY (V) ==================
local function stopFlyLoop()
    if flyLoopConnection then
        flyLoopConnection:Disconnect()
        flyLoopConnection = nil
    end
    local char, root, humanoid = getChar()
    if humanoid and root then
        humanoid.PlatformStand = false
        root.Velocity = Vector3.zero
    end
    flyLoopActive = false
    if loopFlyButton then
        loopFlyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        loopFlyButton.Text = "Loop Fly (OFF)"
    end
end

local function resolveCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    return char, root, humanoid
end

local function startFlyLoop()
    local char, root, humanoid = resolveCharacter()
    if not (char and root and humanoid) then return end
    humanoid.PlatformStand = true
    targetPosition = root.Position

    if flyLoopConnection then flyLoopConnection:Disconnect() end
    flyLoopConnection = RunService.RenderStepped:Connect(function(dt)
        local studs = tonumber(studsBox2.Text) or 150
        local speed = tonumber(speedBox2.Text) or 16
        local cam = workspace.CurrentCamera

        local dir = Vector3.zero
        if moveKeys.W then dir += cam.CFrame.LookVector end
        if moveKeys.S then dir -= cam.CFrame.LookVector end
        if moveKeys.A then dir -= cam.CFrame.RightVector end
        if moveKeys.D then dir += cam.CFrame.RightVector end
        if dir.Magnitude > 0 then
            dir = dir.Unit
            targetPosition += dir * studs * (speed/16) * dt
        end

        local lookVector = (cam.CFrame.Position - targetPosition) * -1
        root.CFrame = CFrame.new(targetPosition, targetPosition + lookVector)
        root.Velocity = Vector3.zero
    end)
end

local function toggleFlyLoop()
    if flyLoopActive then
        stopFlyLoop()
        return
    end

    if speedLoopActive then
        stopSpeedLoop()
    end

    flyLoopActive = true
    if loopFlyButton then
        loopFlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        loopFlyButton.Text = "Loop Fly (ON)"
    end
    startFlyLoop()
end

-- ================== SPEED LOOP MODE (Z) ==================
local function stopSpeedLoop()
    if speedLoopConnection then
        speedLoopConnection:Disconnect()
        speedLoopConnection = nil
    end
    local char, hrp, humanoid = getChar()
    if humanoid and prevAutoRotateSpeed ~= nil then
        humanoid.AutoRotate = prevAutoRotateSpeed
    end
    speedLoopActive = false
    if flyButton then
        flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        flyButton.Text = "Speed Loop Mode"
    end
end

local function startSpeedLoop()
    local char, hrp, humanoid = getChar()
    if not (char and hrp and humanoid) then return end
    prevAutoRotateSpeed = humanoid.AutoRotate
    humanoid.AutoRotate = false

    if speedLoopConnection then speedLoopConnection:Disconnect() end
    speedLoopConnection = RunService.RenderStepped:Connect(function(delta)
        local studs = tonumber(studsBox1.Text) or 15
        local speed = tonumber(speedBox1.Text) or 16
        studs = clamp(studs, 0, 1000)
        speed = clamp(speed, 0, 1000)

        local moveVec = Vector3.new()
        local cam = workspace.CurrentCamera
        if not cam then return end

        local camForward = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
        local camRight = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z).Unit

        if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += camForward end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= camForward end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= camRight end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += camRight end

        local targetPos = hrp.Position
        if moveVec.Magnitude > 0 then
            targetPos += moveVec.Unit * studs
        end

        local alpha = 1 - math.exp(-speed * delta)
        local newPos = hrp.Position:Lerp(targetPos, alpha)
        local lookDir = Vector3.new(camForward.X, 0, camForward.Z).Unit
        hrp.CFrame = CFrame.new(newPos, newPos + lookDir)
    end)
end

local function toggleSpeedLoop()
    if speedLoopActive then
        stopSpeedLoop()
        return
    end

    if flyLoopActive then
        stopFlyLoop()
    end

    speedLoopActive = true
    if flyButton then
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        flyButton.Text = "Speed Loop Mode (ON)"
    end
    startSpeedLoop()
end

-- ================== BOTONES Y TECLAS ==================
if flyButton then
    flyButton.MouseButton1Click:Connect(toggleSpeedLoop)
end
if loopFlyButton then
    loopFlyButton.MouseButton1Click:Connect(toggleFlyLoop)
end

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Z then toggleSpeedLoop() end
    if input.KeyCode == Enum.KeyCode.V then toggleFlyLoop() end
    if moveKeys[input.KeyCode.Name] ~= nil then moveKeys[input.KeyCode.Name] = true end
end)

UIS.InputEnded:Connect(function(input)
    if moveKeys[input.KeyCode.Name] ~= nil then moveKeys[input.KeyCode.Name] = false end
end)

-- ================== REINICIO AL RESPAWNEAR ==================
player.CharacterAdded:Connect(function()
    stopSpeedLoop()
    stopFlyLoop()
end)

-- ===== Bloque Frame =====
local camera = cam
local frameRelativePos = UDim2.new(0.5, 0, 0.5, 0) -- posición inicial
local draggingFrame = false

-- Actualiza posición del frame
local function UpdateFramePosition()
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(
        frameRelativePos.X.Scale,
        frameRelativePos.X.Offset,
        frameRelativePos.Y.Scale,
        frameRelativePos.Y.Offset
    )
end

-- Guardar posición relativa
local function SaveFrameRelativePosition()
    local viewport = camera.ViewportSize
    local absPos = frame.AbsolutePosition
    local absSize = frame.AbsoluteSize
    local centerX = absPos.X + absSize.X * 0.5
    local centerY = absPos.Y + absSize.Y * 0.5

    frameRelativePos = UDim2.new(centerX / viewport.X, 0, centerY / viewport.Y, 0)
end

-- Drag del frame
topFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = true
    end
end)

topFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = false
        SaveFrameRelativePosition()
    end
end)

-- Actualiza posición al cambiar tamaño de la pantalla
camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateFramePosition)

-- Inicial
UpdateFramePosition()
-- ===== ToggleButton responsivo tipo CoreGui + drag estable con delay =====

-- Configuración
local timeOfGripToggleButton = 1 -- segundos que debes mantener presionado antes de arrastrar

-- Variables
local draggingToggle = false
local dragInput, dragStart, startPos
local hasBeenDragged = false
local pressTime = nil
local holdConnection = nil

-- Posición inicial
local toggleOffsetY = 50
local toggleCenterX = 0.5

-- Función para actualizar la posición (si no se ha movido manualmente)
local function UpdateTogglePosition()
    if not hasBeenDragged then
        local viewport = camera.ViewportSize
        local x = viewport.X * toggleCenterX
        toggleButton.AnchorPoint = Vector2.new(0.5, 0)
        toggleButton.Position = UDim2.new(0, x, 0, toggleOffsetY)
    end
end

-- Detectar inicio de input
toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        pressTime = tick()
        dragStart = input.Position
        startPos = toggleButton.Position
        hasBeenDragged = true

        -- Verifica si se mantuvo presionado el tiempo requerido
        holdConnection = RunService.Heartbeat:Connect(function()
            if pressTime and (tick() - pressTime >= timeOfGripToggleButton) then
                draggingToggle = true
                holdConnection:Disconnect()
                holdConnection = nil
            end
        end)

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingToggle = false
                pressTime = nil
                if holdConnection then
                    holdConnection:Disconnect()
                    holdConnection = nil
                end
            end
        end)
    end
end)

-- Detectar movimiento
toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- Actualizar arrastre en RenderStepped
RunService.RenderStepped:Connect(function()
    if draggingToggle and dragInput then
        local delta = dragInput.Position - dragStart
        local newX = startPos.X.Offset + delta.X
        local newY = startPos.Y.Offset + delta.Y
        toggleButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- Reajustar si cambia el tamaño de pantalla (solo si no se movió manualmente)
camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateTogglePosition)

-- Inicia
UpdateTogglePosition()

-- ===== Servicios =====
local camera = workspace.CurrentCamera

-- ===== Configuración =====
local baseViewport = Vector2.new(1920, 1080) -- Resolución en la que diseñaste la UI
local minScale = 0.8 -- nunca se achicará más de 80% (para no romper scrolls)
local maxScale = 1   -- en PC siempre queda igual

-- ===== UIScale dinámico =====
local uiScale = Instance.new("UIScale")
uiScale.Parent = frame  -- <<--- tu frame principal
uiScale.Scale = 1

-- ===== Función para recalcular escala =====
local function ApplyResponsiveScaling()
    local viewport = camera.ViewportSize
    local scaleX = viewport.X / baseViewport.X
    local scaleY = viewport.Y / baseViewport.Y

    -- Escalado proporcional
    local newScale = math.min(scaleX, scaleY)

    -- Limitar para evitar bugs
    newScale = math.clamp(newScale, minScale, maxScale)

    uiScale.Scale = newScale
end

-- ===== Inicial =====
ApplyResponsiveScaling()

-- ===== Auto-ajuste cuando cambia la pantalla =====
camera:GetPropertyChangedSignal("ViewportSize"):Connect(ApplyResponsiveScaling)
