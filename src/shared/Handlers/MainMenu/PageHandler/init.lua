local PageHandler = {}

-- inits
local CreationHandler = require(script.CreationHandler)
local MainMenu = require(game.ReplicatedStorage.Handlers.MainMenu)

local board = workspace.MainMenu.DetectiveBoard
local GUI = board.PlayGui
local PlayFrame = GUI.PlayFrame
local pageLayout = PlayFrame.UIPageLayout
pageLayout.ScrollWheelInputEnabled = false

local Blank = PlayFrame.Blank
local ButtonsFrame = PlayFrame.ButtonsFrame
local joinButton = PlayFrame.ButtonsFrame.Join
local createButton = PlayFrame.ButtonsFrame.Create
local ServerList = PlayFrame.ServerList
local CreateServer = PlayFrame.CreateServer

for _, frame in ipairs(PlayFrame:GetChildren()) do
    if frame:IsA('Frame') then
        for _, button in ipairs(frame:GetChildren()) do
            if button:IsA('TextButton') and button.Name == 'Back' then
                button.MouseButton1Click:Connect(function()
					if pageLayout.CurrentPage.LayoutOrder ~= 5 then
						pageLayout:JumpTo(ButtonsFrame)
						return
					end
					if pageLayout.CurrentPage.LayoutOrder == 5 then
						PageHandler:Exit()
						MainMenu:SetMainCamera()
					end
                end)
            end
        end
    end
end

function PageHandler:Init()
	self.isInitializing = true
	pageLayout:JumpTo(ButtonsFrame)
	wait(0.5)
	Blank.Visible = false
	self.isInitializing = false
end

function PageHandler:Exit()
	if self.isInitializing then
		repeat
			wait(0.1)
		until not self.isInitializing
	end

	Blank.Visible = true
	pageLayout:JumpTo(Blank)
end

local function switchPage(page)
	pageLayout:JumpTo(page)
end

--createButton.MouseButton1Click:Connect(function()
--	switchPage(createPage)
--end)

joinButton.MouseButton1Click:Connect(function()
	switchPage(ServerList)
end)
createButton.MouseButton1Click:Connect(function()
	switchPage(CreateServer)
end)

return PageHandler
