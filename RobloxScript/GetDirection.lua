local RunService = game:GetService("RunService")
local AirplaneNose : any = workspace.AirplaneNose
local PlaneCenter : any = workspace.PlaneCenter
local stalled : boolean = false
local touchingGround : boolean = false
local stallHeight : number = 500
local ImageLabel : any = script.Parent
local MaxRot : number = 180
local storeAirplaneNosePos : any = {}
local storePlanePos : any = {}
local flying : boolean = _G.flying
local PlaneHandler : any = require(game.ReplicatedStorage.Common:WaitForChild("PlaneHandler"))

function TriggerResetX(x : number)
	return x == 0
end

function TriggerOnStall()
	
end

RunService.RenderStepped:Connect(function()
	table.insert(storeAirplaneNosePos, AirplaneNose.Position)
	table.insert(storePlanePos, PlaneCenter.Position)
	for i in pairs (storeAirplaneNosePos) do
		all = i
		if storeAirplaneNosePos[i] ~= nil then
			if storeAirplaneNosePos[i].X ~= 0 then --only clamped x y will be inf since 360 is a thing
				local clampedX : number = math.clamp(storeAirplaneNosePos[i].X, 90, 180)
				ImageLabel.Position = Vector2.new(clampedX, 0)
				if storeAirplaneNosePos[1].X ~= nil then
					if ImageLabel.Position.X == MaxRot then
						TriggerResetX(storeAirplaneNosePos[i].X)
					end
				end
			else
				return storeAirplaneNosePos[i].X;
			end
			if storeAirplaneNosePos[i].Y < 90 then
				ImageLabel.Rotation = storeAirplaneNosePos[i].Y
				for o in pairs (storePlanePos) do
					nums = o
					local origin : Vector3 = Vector3.new(0, -PlaneCenter.Position.Y, 0)
					local direction : Vector3 = Vector3.new(0, math.huge, 0)
					local cast : any = Ray.new(origin, direction)
					local DirBeam : any = Instance.new("Part", workspace)
					DirBeam.Transparency = 1
					DirBeam.Anchored = true
					DirBeam.CanCollide = false
					DirBeam.Color = Color3.fromRGB(255, 0, 0)
					local ScaleDist : number = (storePlanePos[o] - workspace.Baseplate.Position).magnitude
					DirBeam.Size = Vector3.new(2.5, -cast.Direction/storePlanePos[o].Y+ScaleDist, 2.5)
					local RayAndBaseplate : any = table.pack(workspace.Baseplate, DirBeam)
					if workspace:ArePartsTouchingOthers(RayAndBaseplate) == nil then
						touchingGround = true
						while touchingGround do
							PlaneHandler.AllKeysToFly(touchingGround)
							break
						end
					else
						touchingGround = false
					end
				end
			end
		else
			return;
		end
	end
	for liteDel : number = 1, all do
		table.remove(storeAirplaneNosePos, liteDel)
	end
	for liteDel_2 : number = 1, nums do
		table.remove(storePlanePos, liteDel_2)
	end
end)