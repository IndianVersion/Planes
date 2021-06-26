-- Written by Sqowly for no reason @ may/15/21 12-1 AM.
-- Edited By Soqwly also for no reason @ june/25/2021 1:30-2:00 AM.
local SpawnLocation : any = workspace.SpawnLocation
local isFinishedRaying : boolean  = false
local self = {
	raysize = 50;
}
local collidable : any = workspace:GetChildren()
local collisionObjects = {}

function MakeRay()
	table.insert(collidable)
	while wait(0.5) do
		for i in pairs (collisionObjects) do
			if collisionObjects[i][#collidable]:IsA "Part" then
				local objects : any  = collisionObjects[i][#collidable] -- get position from this
				local origin : Vector3 = Vector3.new(0, math.floor(SpawnLocation.Position.Y), 0)
				local direction : Vector3 = Vector3.new(0, origin * self.raysize, 0)
				local newRay : any = Ray.new(origin, -direction/objects.position.Y)
				print(newRay)
				while wait() do
					local part : any = Instance.new("Part", workspace)
					part.Anchored = true
					if part ~= nil then
						print(newRay.Origin.Y) -- when dir = 0
						part.Size = Vector3.new(0, self.raysize, 0)
						part.Size += Vector3.new(0, -newRay.Direction, 0)
						game:GetService("Debris"):AddItem(part, 1)
						for count : number = 1, 5 do
							delay(count, function()
								-- move to next object to ray on
								
							end)
						end
					else
						return newRay
					end
				end
			else
				return collisionObjects[i]
			end
		end
	end
end

MakeRay()