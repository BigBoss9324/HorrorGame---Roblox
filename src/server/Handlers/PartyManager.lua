local PartyManager = {}
PartyManager.Parties = {}

local placeId = 17898966864

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

function PartyManager:CreateServer(host:Players, isPublic:BoolValue, partyName:string, playersNumber:IntValue, pass:string)

	local Id = tostring(math.random(1, 100000))
	self.Parties[Id] = {
		partyName = partyName,
		Host = host.UserId,
		Public = isPublic,
		Pass = pass,
		Members = {host.UserId},
		MembersKicked = {},
		MaxPlayers = playersNumber
	}

	print(self.Parties[Id])
end

function PartyManager:JoinParty(player:Players, Id:IntValue, password:string)
	local party = self.Parties[Id]
	if not party then
		return warn("Party not found")
	end

	if not party.Public and party.Password ~= password then
		return warn("Incorrect password")
	end

	if table.find(party.MembersKicked, player)  then
		return warn("You were recently Kicked from this party")
	end
	
	table.insert(party.Members, player)
end

function PartyManager:LeaveParty(player:Players, Id:IntValue, password:string)
	local party = self.Parties[Id]
	
	table.remove(party.Members, player)
	
	if table.find(party.Members == nil) then
		self.Parties[Id] = nil
	end
	
	if table.find(party.Host, player) then
		party.Host = party.Members[1]
	end
end

function PartyManager:KickedParty(player:Players, Id:IntValue, password:string)
	local party = self.Parties[Id]
	table.remove(party.Members, player)
	table.insert(party.MembersKicked, player)
end


--local code = TeleportService:ReserveServer(placeId)
--TeleportService:TeleportPartyAsync(placeId, code, {player}, nil, {ServerCode = pass})

return PartyManager