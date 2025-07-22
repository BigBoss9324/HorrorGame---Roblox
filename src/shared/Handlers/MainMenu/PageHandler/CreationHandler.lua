CreationHandler = {}

print("CreationHandler loaded")

local board = workspace.MainMenu.DetectiveBoard
local GUI = board.PlayGui
local PlayFrame = GUI.PlayFrame
local CreateServerPage = PlayFrame.CreateServer
local Frame = CreateServerPage.CreateServerOptions.Frame

-- PrivateToggle
local PrivateToggleButton = Frame.Private.CheckBoxButton
local PrivateToggleCheck = PrivateToggleButton.Check
PrivateToggleButton.MouseButton1Click:Connect(function()
	print("Checked")
	PrivateToggleCheck.Visible = not PrivateToggleCheck.Visible
end)


--CreateServerButton
local CreateServerButton = Frame.CreateServer
CreateServerButton.MouseButton1Click:Connect(function()
    print("Create Server button clicked")
    onCreateServerButtonClicked(game.Players.LocalPlayer, PrivateToggleCheck.Visible)
end)

function onCreateServerButtonClicked(user, private)
    print("User", user)
    print("Private", private)
    print("Create Server button clicked")
end

return CreationHandler