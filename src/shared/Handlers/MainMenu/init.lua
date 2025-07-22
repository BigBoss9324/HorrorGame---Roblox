local MainMenu = {}
----
local ButtonHandler = require(script.ButtonHandler)

local camera = game.Workspace.Camera
local MainCamera = game.Workspace.MainMenu.Cameras.MainCamera
local PlayCamera = game.Workspace.MainMenu.Cameras.PlayCamera
local CreditsCamera = game.Workspace.MainMenu.Cameras.CreditsCamera
local plr = game.Players.LocalPlayer

-- Tween --
local tweenservice = game:GetService('TweenService')
local tinfo = TweenInfo.new(.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
local PlayCameraL = {CFrame = workspace.MainMenu.Cameras.PlayCamera.CFrame}
local MainCameraL = {CFrame = workspace.MainMenu.Cameras.MainCamera.CFrame}
local CreditsCameraL = {CFrame = workspace.MainMenu.Cameras.CreditsCamera.CFrame}
local PlayCameraT = tweenservice:Create(camera, tinfo, PlayCameraL)
local MainCameraT = tweenservice:Create(camera, tinfo, MainCameraL)
local CreditsCameraT = tweenservice:Create(camera, tinfo, CreditsCameraL)

-- UI --
local mainMenuGui = workspace.MainMenu.Computer.Computer.ScreenLight.SurfaceGui
local mainMenuFrame = mainMenuGui['MainMenuFrame']

-- Sounds --
local clickSound = script.clickSound

function MainMenu:Initialize()
	-- Camera --
	camera.CameraType = Enum.CameraType.Scriptable
	MainMenu:SetMainCamera()
	
	-- Player --
	game.Workspace[plr.Name].Humanoid.JumpPower = 0
	game.Workspace[plr.Name].Humanoid.WalkSpeed = 0
	
	-- Buttons --
	local playButton = mainMenuFrame['ButtonsFrame']['Play']
	playButton.MouseButton1Click:Connect(MainMenu.SetPlayCamera)

	local settingsButton = mainMenuFrame['ButtonsFrame']['Settings']
	settingsButton.MouseButton1Click:Connect(MainMenu.PlayClickingSound)

	local creditsButton = mainMenuFrame['ButtonsFrame']['Credits']
	creditsButton.MouseButton1Click:Connect(MainMenu.SetCreditsCamera)
	
	-- Inits --
	local PageHandler = require(script.PageHandler)
	PageHandler:Exit()
end




function MainMenu:PlayClickingSound()
	clickSound:Play()
	wait(clickSound.TimeLength - .8)
end

function MainMenu:SetMainCamera()
	-- Camera --
	MainCameraT:Play()
	wait(1)
	mainMenuFrame.Visible = true
end

function MainMenu:SetPlayCamera()
	local PageHandler = require(script.PageHandler)
	-- Camera --
	MainMenu:PlayClickingSound()
	PlayCameraT:Play()
	wait(1)
	PageHandler:Init()
end

function MainMenu:SetCreditsCamera()
	-- Camera --
	MainMenu:PlayClickingSound()
	CreditsCameraT:Play()
	wait(1)
	
end

return MainMenu