local plrs = game:GetService("Players")
local SS = game:GetService("ServerStorage")
local DSS = game:GetService("DataStoreService")
local MoneyService = DSS:GetDataStore("PlayerData", "Money")
defaultData = {
	["Money"] = 15
}


local function onPlayerAdded(plr)
	local atp = 1
	local PlayerMoney = Instance.new("IntValue")
	PlayerMoney.Name = plr.Name
	PlayerMoney.Parent = SS.PlayerMoney
	--
	repeat
		success, data = pcall(function()
			return MoneyService:GetAsync(plr.UserId)
		end)
		if not success then
			warn(data)
			task.wait(5)
		end
		atp += 1
	until success or atp == 3
	
	if success then
		if data == nil then
			warn(plr, "Has no data, creating new")
			
			
		return end
		PlayerMoney.Value = data
	end
end

local function onPlayerRemoval(plr)
	local atp = 1
	print(plr, "is leaving")
	
	repeat
		success, err = pcall(function()
			MoneyService:UpdateAsync(plr.UserId, SS.PlayerMoney[plr.Name].Value)
		end)
		
		if not success then
			warn(err)
			task.wait(5)
		end
		
		atp += 1
	until success or atp == 3
	SS.PlayerMoney[plr.Name]:Destroy()
end

plrs.PlayerAdded:Connect(onPlayerAdded)
plrs.PlayerRemoving:Connect(onPlayerRemoval)