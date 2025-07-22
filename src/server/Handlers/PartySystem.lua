-- Memory Store
local MSS = game:GetService("MemoryStoreService")
local PartyLobbies = MSS:GetSortedMap("test_store_1")

local PartySystem = {}
PartySystem.__index = PartySystem

-- Constructor
function PartySystem.new()
	local self = setmetatable({}, PartySystem)

	-- Initialize an empty player list
	self.PlayerList = {}

	return self
end


-- Function to create a new lobby
function PartySystem:CreateLobby(Player, LobbySettings)
	local LobbyData = {
		["Members"] = {Player.UserId},
		["Limit"] = LobbySettings.Limit,
		["Map"] = LobbySettings.Map,
		["Code"] = LobbySettings.Code,
		["LobbyLeader"] = Player.UserId
	}

	-- Attempt to set the lobby data in Memory Store
	local Success, Bool = pcall(function()
		return PartyLobbies:SetAsync(LobbySettings.Code, LobbyData, 10000)
	end)

	if Success then
		self.PlayerList[Player.UserId] = LobbySettings.Code
	end

	return LobbyData
end