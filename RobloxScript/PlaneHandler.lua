local PlaneHandler = {};
local UserInputService = game:GetService("UserInputService");
local PlaneCenter : any = workspace.PlaneCenter;
local taxiing : boolean = false;
local velSet : boolean = false;
local afterVelSet : boolean = false;
local numsCounter : any = {};

local controllingKeys : any = {
	forward == "W";
	backwards == "S";
	right == "D";
	left == "A"
}

function PlaneHandler.AllKeysToFly(touchingGround : boolean)
	for int in pairs (controllingKeys) do
		UserInputService.InputBegan:Connect(
			function (input : any, isTyping : boolean)
				if input.KeyCode == Enum.KeyCode[controllingKeys[int]] then
					flying = true;
					planeTaxiingSpeed = 30;
					taxiingDefault = 0;
				end
				if input.KeyCode == Enum.KeyCode[controllingKeys.forward] then
					-- apply force to -z
					taxiing = true;
					if taxiing then
						while wait(0.1) do
							taxiingDefault += 1;
							if taxiingDefault == planeTaxiingSpeed then
								velSet = true;
								if velSet then
									table.insert(numsCounter, taxiingDefault)
									afterVelSet = true;
									break
								end
							end
						end
						if afterVelSet then
							for x in pairs (numsCounter) do
								
							end
						end
					end
				end
			end
		)
	end
end

function PlaneHandler.RemapKeys()
	
end


return PlaneHandler;