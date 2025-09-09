local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

frame.Position = UDim2.new(0, 500, 0, 150)

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

scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- ajusta según la cantidad de botones

scrollFrame.ScrollBarThickness = 8

scrollFrame.BackgroundTransparency = 1

scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)

scrollFrame.ScrollBarImageTransparency = 0.3  -- 0 es opaco, 1 invisible

scrollFrame.ScrollBarThickness = 0  -- antes era 8

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

-- Crear el frame flotante de jugadores

local playersFrame = Instance.new("Frame")

playersFrame.Name = "PlayersFrame"

playersFrame.Size = UDim2.new(0, 220, 0, 320)

playersFrame.Position = UDim2.new(0, 300, 0, 180)

playersFrame.BackgroundTransparency = 0.3

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

local loopTpActive = false

local loopTpConnection = nil

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

	if loopTpConnection then

		loopTpConnection:Disconnect()

		loopTpConnection = nil

	end

	loopTpActive = false

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



-- Botón LoopTP

local loopTpBtn = Instance.new("TextButton")

loopTpBtn.Name = "LoopTPToPlayerBtn"

loopTpBtn.Size = UDim2.new(0, 150, 0, 32)

loopTpBtn.Position = UDim2.new(0, 15, 0, 146)

loopTpBtn.Text = "Loop " .. targetPlayer.Name

loopTpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

loopTpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

loopTpBtn.Font = Enum.Font.SourceSansBold

loopTpBtn.TextSize = 16

loopTpBtn.Parent = actionFrame

loopTpBtn.ZIndex = 23



local loopCorner = Instance.new("UICorner")

loopCorner.CornerRadius = UDim.new(0, 7)

loopCorner.Parent = loopTpBtn



local loopRadius = 5 -- distancia alrededor del jugador

local angleSpeed = math.rad(180) -- velocidad angular rad/s

local theta = 0

local speedStudsVelocity = 0 -- 0 = orbita instantáneo, >0 = moverse antes de orbitar



loopTpBtn.MouseButton1Click:Connect(function()

	loopTpActive = not loopTpActive



	if loopTpActive then

		if not (targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head")) then

			warn("⚠️ No se encontró al jugador objetivo.")

			loopTpActive = false

			return

		end



		loopTpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

		humanoid.PlatformStand = true



		-- 🔹 Loop en Heartbeat

		loopTpConnection = RunService.Heartbeat:Connect(function(delta)

			if not (character and root and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head")) then 

				return 

			end



			local targetHeadPos = targetPlayer.Character.Head.Position + Vector3.new(0, 3, 0)

			local direction = targetHeadPos - root.Position

			local distance = direction.Magnitude



			if speedStudsVelocity <= 0 then

				-- Orbita instantáneo

				theta = theta + angleSpeed * delta

				local offset = Vector3.new(math.cos(theta) * loopRadius, 0, math.sin(theta) * loopRadius)

				root.CFrame = CFrame.new(targetHeadPos + offset, targetHeadPos)

			else

				-- Movimiento progresivo antes de orbitar

				if distance > loopRadius then

					local move = direction.Unit * math.min(speedStudsVelocity * delta, distance - loopRadius)

					root.CFrame = CFrame.new(root.Position + move, targetHeadPos)

				else

					theta = theta + angleSpeed * delta

					local offset = Vector3.new(math.cos(theta) * loopRadius, 0, math.sin(theta) * loopRadius)

					root.CFrame = CFrame.new(targetHeadPos + offset, targetHeadPos)

				end

			end



			-- 🔹 Evitar caídas y bugs

			root.Velocity = Vector3.zero

			root.RotVelocity = Vector3.zero

		end)

	else

		loopTpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

		humanoid.PlatformStand = false

		if loopTpConnection then

			loopTpConnection:Disconnect()

			loopTpConnection = nil

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

utilitiesFrame.Position = UDim2.new(0, 300, 0, 180)

utilitiesFrame.BackgroundTransparency = 0.3

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

-- Botón Loop Fly

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

local studsBox = Instance.new("TextBox")

studsBox.Size = UDim2.new(0, 80, 1, 0)

studsBox.Position = UDim2.new(1, -158, 0, 44)

studsBox.Parent = flyButton

studsBox.Text = "15"

studsBox.PlaceholderText = "Studs"

studsBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

studsBox.TextColor3 = Color3.new(1, 1, 1)

local studsCorner = Instance.new("UICorner")

studsCorner.CornerRadius = UDim.new(0, 8)

studsCorner.Parent = studsBox

-- TextBox para "FlySpeed" (fluidez)

local speedBox = Instance.new("TextBox")

speedBox.Size = UDim2.new(0, 80, 1, 0)

speedBox.Position = UDim2.new(1, -68, 0, 44)

speedBox.Parent = flyButton

speedBox.Text = "16"

speedBox.PlaceholderText = "Speed"

speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

speedBox.TextColor3 = Color3.new(1, 1, 1)

local speedBoxCorner = Instance.new("UICorner")

speedBoxCorner.CornerRadius = UDim.new(0, 8)

speedBoxCorner.Parent = speedBox

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

local studsBoxx = Instance.new("TextBox")

studsBoxx.Name = "StudsBoxx"

studsBoxx.PlaceholderText = "Studs"

studsBoxx.Text = "150"

studsBoxx.Size = UDim2.new(0, 80, 1, 0)

studsBoxx.Position = UDim2.new(1, -156, 0, 44)

studsBoxx.Parent = loopFlyButton

studsBoxx.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

studsBoxx.TextColor3 = Color3.new(1, 1, 1)

local studsBoxxCorner = Instance.new("UICorner")

studsBoxxCorner.CornerRadius = UDim.new(0, 8)

studsBoxxCorner.Parent = studsBoxx

-- TextBox Speed

local speedBoxx = Instance.new("TextBox")

speedBoxx.Name = "SpeedBox"

speedBoxx.PlaceholderText = "FlySpeed"

speedBoxx.Text = "16"

speedBoxx.Size = UDim2.new(0, 80, 1, 0)

speedBoxx.Position = UDim2.new(1, -64, 0, 44)

speedBoxx.Parent = loopFlyButton

speedBoxx.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

speedBoxx.TextColor3 = Color3.new(1, 1, 1)

local speedBoxxCorner = Instance.new("UICorner")

speedBoxxCorner.CornerRadius = UDim.new(0, 8)

speedBoxxCorner.Parent = speedBoxx

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

-- Drag para el Utilities

local dragging = false

local dragInput, dragStart, startPos

local function updateDrag(input)

local delta = input.Position - dragStart

local goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)

RunService:BindToRenderStep("DragUtilitiesFrame", Enum.RenderPriority.Input.Value, function()

	if dragging then

		utilitiesFrame.Position = utilitiesFrame.Position:Lerp(goal, 0.2)

	else

		RunService:UnbindFromRenderStep("DragUtilitiesFrame")

	end

end)

end

--TopBar

utilitiesTop.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then

	dragging = true

	dragStart = input.Position

	startPos = utilitiesFrame.Position

	input.Changed:Connect(function()

		if input.UserInputState == Enum.UserInputState.End then

			dragging = false

		end

	end)

end

end)

utilitiesTop.InputChanged:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseMovement then

	dragInput = input

end

end)

--UIS

UIS.InputChanged:Connect(function(input)

if input == dragInput and dragging then

	updateDrag(input)

end

end)

-- Dragging para el frame de jugadores

local draggingPlayers = false

local dragInputPlayers, dragStartPlayers, startPosPlayers

local function updatePlayersDrag(input)

local delta = input.Position - dragStartPlayers

local goal = UDim2.new(startPosPlayers.X.Scale, startPosPlayers.X.Offset + delta.X, startPosPlayers.Y.Scale, startPosPlayers.Y.Offset + delta.Y)

RunService:BindToRenderStep("DragPlayersFrame", Enum.RenderPriority.Input.Value, function()

	if draggingPlayers then

		playersFrame.Position = playersFrame.Position:Lerp(goal, 0.2)

	else

		RunService:UnbindFromRenderStep("DragPlayersFrame")

	end

end)

end

playersTop.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then

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

playersTop.InputChanged:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseMovement then

	dragInputPlayers = input

end

end)

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

-- Variables de control

local SpeedWalkLoop = false

local SpeedLoopConnection = nil

local prevAutoRotate = humanoid.AutoRotate

local FlyLoop = nil

local flying = false

local moveKeys = {W=false,A=false,S=false,D=false}

local targetPosition

-- Referencia directa a botones y cajas existentes del executor

local SpeedLoopButton = _G.SpeedLoopButton -- Usa el botón que ya existe

local LoopFlyButton = _G.LoopFlyButton

local studsBox = _G.StudsBox

local speedBox = _G.SpeedBox

-- Función para obtener personaje actual

local function getChar()

character = player.Character or player.CharacterAdded:Wait()

humanoid = character:WaitForChild("Humanoid")

root = character:WaitForChild("HumanoidRootPart")

return character, humanoid, root

end

-- Función clamp

local function clamp(n,a,b) return math.max(a,math.min(b,n)) end

-- ====== SPEED LOOP (Z) ======

local function toggleSpeedLoop()

SpeedWalkLoop = not SpeedWalkLoop

local char, humanoid, root = getChar()

if not (char and humanoid and root) then return end



if SpeedWalkLoop then

    SpeedLoopButton.BackgroundColor3 = Color3.fromRGB(0,255,0)

    prevAutoRotate = humanoid.AutoRotate

    humanoid.AutoRotate = false



    if SpeedLoopConnection then SpeedLoopConnection:Disconnect() end

    SpeedLoopConnection = RunService.RenderStepped:Connect(function(delta)

        local studs = clamp(tonumber(studsBox.Text) or 15,0,1000)

        local flySpeed = clamp(tonumber(speedBox.Text) or 16,0,1000)



        local moveVec = Vector3.new()

        if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z).Unit end

        if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z).Unit end

        if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= Vector3.new(cam.CFrame.RightVector.X,0,cam.CFrame.RightVector.Z).Unit end

        if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += Vector3.new(cam.CFrame.RightVector.X,0,cam.CFrame.RightVector.Z).Unit end



        local targetPos = root.Position

        if moveVec.Magnitude > 0 then

            targetPos += moveVec.Unit * studs

        end



        local alpha = 1 - math.exp(-flySpeed*delta)

        root.CFrame = CFrame.new(root.Position:Lerp(targetPos,alpha), root.Position:Lerp(targetPos,alpha) + Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z).Unit)

    end)

else

    SpeedLoopButton.BackgroundColor3 = Color3.fromRGB(255,0,0)

    if SpeedLoopConnection then SpeedLoopConnection:Disconnect() SpeedLoopConnection=nil end

    humanoid.AutoRotate = prevAutoRotate

end

end

-- Conectar botón y tecla Z

if SpeedLoopButton then

SpeedLoopButton.MouseButton1Click:Connect(toggleSpeedLoop)

end

UIS.InputBegan:Connect(function(input,gpe)

if gpe then return end

if input.KeyCode==Enum.KeyCode.Z then toggleSpeedLoop() end

end)

-- ====== LOOP FLY (V) ======

local function resolveCharacterFly()

character = player.Character or player.CharacterAdded:Wait()

humanoid = character:WaitForChild("Humanoid")

root = character:WaitForChild("HumanoidRootPart")

targetPosition = root.Position

end

UIS.InputBegan:Connect(function(input,gpe)

if gpe then return end

if moveKeys[input.KeyCode.Name] ~= nil then moveKeys[input.KeyCode.Name]=true end

end)

UIS.InputEnded:Connect(function(input)

if moveKeys[input.KeyCode.Name] ~= nil then moveKeys[input.KeyCode.Name]=false end

end)

local function startFly()

resolveCharacterFly()

humanoid.PlatformStand = true

targetPosition = root.Position

if FlyLoop then FlyLoop:Disconnect() end



FlyLoop = RunService.RenderStepped:Connect(function(dt)

    local studs = clamp(tonumber(studsBox.Text) or 15,0,1000)

    local speed = clamp(tonumber(speedBox.Text) or 16,0,1000)

    local dir = Vector3.zero

    if moveKeys.W then dir += cam.CFrame.LookVector end

    if moveKeys.S then dir -= cam.CFrame.LookVector end

    if moveKeys.A then dir -= cam.CFrame.RightVector end

    if moveKeys.D then dir += cam.CFrame.RightVector end

    if dir.Magnitude>0 then

        targetPosition += dir.Unit * studs * (speed/16) * dt

    end

    root.CFrame = CFrame.new(targetPosition, targetPosition + (cam.CFrame.Position - targetPosition).Unit)

    root.Velocity = Vector3.zero

end)

end

local function stopFly()

if FlyLoop then FlyLoop:Disconnect() FlyLoop=nil end

if humanoid and root then

    humanoid.PlatformStand=false

    root.Velocity=Vector3.zero

end

flying=false

if LoopFlyButton then

    LoopFlyButton.Text="Loop Fly (OFF)"

    LoopFlyButton.BackgroundColor3=Color3.fromRGB(255,0,0)

end

end

local function toggleFly()

flying = not flying

if flying then

    if LoopFlyButton then

        LoopFlyButton.Text="Loop Fly (ON)"

        LoopFlyButton.BackgroundColor3=Color3.fromRGB(0,255,0)

    end

    startFly()

else

    stopFly()

end

end

-- Conectar botón y tecla V

if LoopFlyButton then

LoopFlyButton.MouseButton1Click:Connect(toggleFly)

end

UIS.InputBegan:Connect(function(input,gpe)

if gpe then return end

if input.KeyCode==Enum.KeyCode.V then toggleFly() end

end)

-- ====== Reconectar al respawnear ======

player.CharacterAdded:Connect(function()

if SpeedWalkLoop then

    if SpeedLoopConnection then SpeedLoopConnection:Disconnect() SpeedLoopConnection=nil end

    prevAutoRotate = nil

end

stopFly()

end)

humanoid.Died:Connect(stopFly)

-- ====== Detectar si GUI se elimina o reemplaza ======

local function resetAll()

if SpeedLoopConnection then SpeedLoopConnection:Disconnect() SpeedLoopConnection=nil end

humanoid.AutoRotate=prevAutoRotate

stopFly()

end

-- Solo si los botones existen

if SpeedLoopButton then

SpeedLoopButton.AncestryChanged:Connect(resetAll)

end

if LoopFlyButton then

LoopFlyButton.AncestryChanged:Connect(resetAll)

end

