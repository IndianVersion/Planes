-- Written by Sqowly for no reason @ may/15/21 12-1 AM.
-- Edited By Sqowly also for no reason @ june/25/2021 1:30-2:00 AM.
local SpawnLocation : any = workspace.SpawnLocation
local isFinishedRaying : boolean  = false
local collidable : any = workspace:GetChildren()
local maxNum : number = 5

local params = {raysize = 50}
local collisionObjects = {}
local global_direction
local all = {}

function ApplyHealthToAllObjects(x : any)
	x:SetAttribute("minHealth", 50)
	x:SetAttribute("maxHealth", 100)
end

function MakeRay()
	table.insert(collidable)
	while wait(0.5) do
		for i in pairs (collisionObjects) do
			if (collisionObjects[i][#collidable]:IsA "Part") then
				local objects : any  = collisionObjects[i][#collidable] -- get position from this
				local origin : Vector3 = Vector3.new(0, math.floor(SpawnLocation.Position.Y), 0)
				local direction : Vector3 = Vector3.new(0, origin * params.raysize, 0)
				local newRay : any = Ray.new(origin, -direction/objects.position.Y)
				print(newRay)
				while wait() do
					local part : any = Instance.new("Part", workspace)
					part.Anchored = true
					if (part ~= nil) then
						print(newRay.Origin.Y) -- when dir = 0
						part.Size = Vector3.new(0, params.raysize, 0)
						part.Size += Vector3.new(0, -newRay.Direction, 0)
						game:GetService("Debris"):AddItem(part, 1)
						for count : number = 1, 5 do
							delay(count, function()
								-- move to next object to ray on
								for timer : number = 1, maxNum do
									if (timer == maxNum) then
										isFinishedRaying = true
										if (isFinishedRaying) then
											global_direction  = {}
											table.insert(global_direction, newRay)
											for dir in pairs (global_direction) do
												num = dir
												RayDir = global_direction[dir].Direction.Y
											end
										end
										local allObjects : any = collisionObjects[i][#collidable]
										table.insert(all, allObjects)
										for ofu in pairs (all) do
											ApplyHealthToAllObjects(all[ofu])
											local min : number = all[ofu]:GetAttribute("minHealth")
											local max : number = all[ofu]:GetAttribute("maxHealth")
											local randomizedHealth : number = math.random(min, max)
											local healthValue : any = Instance.new("IntValue", all[ofu])
											healthValue.Name = "HealthValue"
											healthValue.Value = randomizedHealth
											if (all[ofu].healthValue.Value == 0) then
												table.remove(global_direction, num)
												local AlteredRayDirection : number = -RayDir/all[ofu].Position.Y
												part.Position = Vector3.new(0, AlteredRayDirection, 0)
											end
										end
									end
								end
							end)
						end
					else
						return newRay
					end
				end
			else
				return collisionObjects[i][#collidable]
			end
		end
	end
end

MakeRay()