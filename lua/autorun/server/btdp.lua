--[[
* Purpose of this file *
The main script of BTDP, which stands for "Back to Deathpoint".

* Credits *
Scripting: theandrew61

!! PLEASE DON'T STEAL THIS CODE !!
]]

local initDone = false
local useDeathPos = true
local deathpos
local hasDiedBefore = -1 -- integers are easier to use, false is read as "not" and is default for unset boolean variables

hook.Add("PlayerDeath", "BTDPDeath", function(victim, weapon, killer)
	if IsValid(victim) then
		deathpos = victim:GetPos()
		hasDiedBefore = 1
		print(victim:GetName() .. " has died at (" .. roundNum(deathpos.x) .. ", " .. roundNum(deathpos.y) .. ", " .. roundNum(deathpos.z) .. ").")
	end
end)

hook.Add("PlayerInitialSpawn", "BTDPFirstTime", function(ply)
	if not initDone then
		MsgC(Color(255, 0, 255), "---------------\n! BTDP loaded !\n---------------\n")
		initDone = true
		hasDiedBefore = -1
		ply:ConCommand("btdp_enabled 1")
	end
end)

hook.Add("PlayerSpawn", "BTDPSpawn", function(ply)
	if useDeathPos and hasDiedBefore == 1 then
		ply:SetPos(deathpos)
	end
end)

concommand.Add("btdp_enabled", function(ply, cmd, args)
	if args[1] == "1" then
		useDeathPos = true
		print("BTDP (Back to Deathpoint) is enabled")
	elseif args[1] == "0" then
		useDeathPos = false
		print("BTDP (Back to Deathpoint) is disabled")
	else
		useDeathPos = true
	end
end)

concommand.Add("btdp_mypos", function(ply, cmd, args)
	local pos = ply:GetPos()
	ply:ChatPrint(ply:GetName() .. " is at (" .. roundNum(pos.x) .. ", " .. roundNum(pos.y) .. ", " .. roundNum(pos.z) .. ").")
end)

function roundNum(n)
  return math.floor((math.floor(n*2) + 1)/2)
end
