local PlaneHandler = {}

local UserInputService = game:GetService("UserInputService")
local PlaneCenter : any = workspace.PlaneCenter
local taxiing : boolean = false
local velSet : boolean = false
local afterVelSet : boolean = false
local fullStop : boolean = false
local numsCounter : any = {}
local numForMinus : any = {}

local controllingKeys : any = {
	forward == "W";
	backwards == "S";
	right == "D";
	left == "A"
}

function PlaneHandler.AllKeysToFly(touchingGround : boolean)
	for int in pairs (controllingKeys) do
		every = int
		UserInputService.InputBegan:Connect(
			function (input : any, isTyping : boolean)
				if input.KeyCode == Enum.KeyCode[controllingKeys[int]] then
					flying = true
					planeTaxiingSpeed = 30
					taxiingDefault = 0
				end
				if input.KeyCode == Enum.KeyCode[controllingKeys.forward] then
					-- apply force to -z
					taxiing = true; -- use for triggering a stop on the plane
					if taxiing then
						while wait(0.1) do
							taxiingDefault += 1
							if taxiingDefault == planeTaxiingSpeed then
								velSet = true
								if velSet then
									table.insert(numsCounter, taxiingDefault)
									afterVelSet = true
									break
								end
							end
						end
						if afterVelSet then
							for x in pairs (numsCounter) do
								bodyvelocity = Instance.new("BodyVelocity", PlaneCenter)
								bodyvelocity.Velocity = Vector3.new(0,0,-PlaneCenter.Position.Z*numsCounter[x])
								bodyvelocity.P = -taxiingDefault*2
								bodyvelocity.MaxForce = Vector3.new(0,0,-numsCounter[x]*5)
							end
						end
					end
				end
			end
		)
	end
end

function PlaneHandler.AllKeysToStop()
	UserInputService.InputEnded:Connect(
		function (input : any, isTyping : boolean)
			if isTyping then return end
			if input.KeyCode == Enum.KeyCode[controllingKeys[every]] then
				flying = false
				while not flying do
					wait(0.1)
					taxiingDefault -= 1
					table.insert(numForMinus, taxiingDefault)
					if taxiingDefault == 0 then
						fullStop = true
					end
				end
				if fullStop then
					for minus in pairs (numForMinus) do
						local cancel = numForMinus[minus]
						return bodyvelocity.Velocity == Vector3.new(cancel,cancel,cancel)
					end
				end
			end
		end
	)
end

function PlaneHandler.RemapKeys()
	
end


return PlaneHandler