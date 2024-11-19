-- NOTE: If you're portals are MODELS then set the primary part in them, in the properties tab!
local portal1 = game.Workspace.Maps.Towers.Blue -- Set this to your desired model/part
local portal2 = game.Workspace.Maps.Towers.Red -- Set this to your desired model/part
local Cooldown = true

-- Only set the following if cooldown is set to true.
local p1Cooldown = 5
local p2Cooldown = 5


-- Don't touch these values lol
local CanTeleportP1 = true
local CanTeleportP2 = true

local function Portal1Function(hit) -- Function for Portal 1
	if hit.Parent:FindFirstChildOfClass("Humanoid") and CanTeleportP1 == true then -- Checking for the player, and if it even can teleport.
		CanTeleportP2 = false -- Sets the other portal to false, so you just don't get in a tp loop.
		hit.Parent:MoveTo(portal2.WorldPivot.Position) -- Move the player to the other portal.
	end

	if Cooldown == true then -- If you set the cooldown to true it'll just make it so you can't teleport again for the seconds you set.
		CanTeleportP1 = false
		wait(p1Cooldown)
		CanTeleportP1 = true
	end

	wait(p1Cooldown) -- Again waiting for the seconds you set.
	CanTeleportP2 = true -- Setting the other portal back to true.
end

local function Portal2Function(hit)-- Function for Portal 2 (Inverse of portal 1)
	if hit.Parent:FindFirstChildOfClass("Humanoid") and CanTeleportP2 == true then
		CanTeleportP1 = false
		hit.Parent:MoveTo(portal1.WorldPivot.Position)
	end

	if Cooldown == true then
		CanTeleportP2 = false
		wait(p2Cooldown)
		CanTeleportP2 = true
	end

	wait(p2Cooldown)
	CanTeleportP1 = true
end

if portal1:IsA("Model") then
	portal1.PrimaryPart.Touched:Connect(Portal1Function)
elseif portal1:IsA("BasePart") then
	portal1.Touched:Connect(Portal1Function)
end

if portal2:IsA("Model") then
	portal2.PrimaryPart.Touched:Connect(Portal2Function)
elseif portal2:IsA("BasePart") then
	portal2.Touched:Connect(Portal2Function)
end
