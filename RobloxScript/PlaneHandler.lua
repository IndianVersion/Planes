local PlaneHandler = {}
local UserInputService = game:GetService("UserInputService")

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
					flying = true
					local planeTaxiingSpeed : number = 30
					local taxiingDefault : number = 0
				end
				if input.KeyCode == Enum.KeyCode[controllingKeys.forward] then
					-- apply force to -z
				end
			end
		)
	end
end

function PlaneHandler.RemapKeys()
	
end


return PlaneHandler