local ButtonHandler = {}
----

local computer = workspace.MainMenu.Computer.Computer.ScreenLight
local GUI = computer.SurfaceGui
local MainMenuFrame = GUI.MainMenuFrame
local board = workspace.MainMenu.DetectiveBoard
local GUI = board.PlayGui
local PlayFrame = GUI.PlayFrame

local function getButtons(Frame)
	for _, frame in ipairs(Frame:GetChildren()) do
		if not frame:IsA('Frame') then return end
		for _, button in ipairs(frame:GetChildren()) do
			if not button:IsA('TextButton') then return end
			print(button)
			button.MouseButton1Click:Connect(function()
				local MainMenu = require(game.ReplicatedStorage.Handlers.MainMenu)
				MainMenu:PlayClickingSound()
			end)
			button.MouseEnter:Connect(function()
				button.Size = UDim2.new(button.Size.X.Scale * 1.05, 0, button.Size.Y.Scale * 1.075, 0)
			end)
			button.MouseLeave:Connect(function()
				button.Size = UDim2.new(button.Size.X.Scale / 1.05, 0, button.Size.Y.Scale / 1.075, 0)
			end)
		end
	end
end

getButtons(MainMenuFrame)
getButtons(PlayFrame)
getButtons(PlayFrame.ServerList)

return ButtonHandler