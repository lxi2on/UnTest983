-- Servicios (concentrados al inicio)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = workspace

-- Variables comunes iniciales
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local cam = workspace.CurrentCamera

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

-- == Sección GUI ==
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
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollingEnabled = true
scrollFrame.Active = true -- permite scroll en móvil/tablet
scrollFrame.ScrollBarThickness = 0 -- grosor 0 para no mostrar
scrollFrame.ScrollBarImageTransparency = 1 -- completamente invisible
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180) -- color si quieres mostrar en algún momento
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
-- Canvas dinámico según contenido
scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    local contentHeight = 0
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            contentHeight = math.max(contentHeight, child.Position.Y.Offset + child.AbsoluteSize.Y)
        end
    end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0.040, contentHeight)
end)
scrollFrame.Parent = frame

local lineFrame = Instance.new("Frame")
lineFrame.Size = UDim2.new(1, 0, 1, -680)
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

-- boton para abrir pagina 1 de Jugadores aparece otro frame con la lista dejugadores en vertical hacia abajo todo losque estan en el server esto abre un frame conn scrollframe y drag 
local pag1 = createButton("Pag1Button", "Players", UDim2.new(0, 15, 0, 575), btnSize)

-- boton para abrir pagina 2 de Utilidades como Esp, Tracer, etc Pero para todos los jugadores Ejemplo osea local osea soloyoveo el esp2d y el tracer
local pag2 = createButton("Pag2Button", "Utilities", UDim2.new(0, 15, 0, 620), btnSize)

-- boton para abrir pagina 3 de Games como Ink Gamme, Da hood (Copy), Etc.
local pag3 = createButton("Pag3Button", "Games", UDim2.new(0, 15, 0, 665), btnSize)
