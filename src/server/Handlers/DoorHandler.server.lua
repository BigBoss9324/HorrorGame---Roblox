local ts = game:GetService("TweenService")
local ss = game:GetService("ServerStorage")
local rs = game:GetService("ReplicatedStorage")
local Folder = workspace.Doors

---
local Tinfo = TweenInfo.new()

for _, v in pairs(Folder:GetChildren()) do
	if not v:IsA("Model") then continue end
	---
	local open = ts:Create(v.PrimaryPart, Tinfo, {
		CFrame = v.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(95),0)
	})
	local close = ts:Create(v.PrimaryPart, Tinfo, {
		CFrame = v.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(0),0)
	})


	local function check()
		if v:GetAttribute("Open") == false then
			v:SetAttribute("Open", true)
		else
			v:SetAttribute("Open", false)
		end
	end
	--
	local AutoCloseTime = v["Configuration"]:GetAttribute("AutoClose")

	v["ProximityPrompt"].Triggered:Connect(function(plr)
		if v["Configuration"]:GetAttribute("KeyRequired") == true then
			local KeyName = v["Configuration"]:GetAttribute("KeyName")
			if not plr.Backpack:FindFirstChild(KeyName) then return end
		end
		check()
	end)

	v:GetAttributeChangedSignal("Open"):Connect(function()
		if v:GetAttribute("Open") == false then
			close:Play()
			return
		end
		if v:GetAttribute("Open") == true then
			open:Play()
		end

		if AutoCloseTime == 0 then
			return
		else
			wait(AutoCloseTime)
			v:SetAttribute("Open", false)
		end
	end)
	
end