local AirplaneNose : any = workspace.AirplaneNose
local AirplaneNoseRemote : any = game.ReplicatedStorage:WaitForChild("AirplaneNoseRemote")

local store : any = {}

function calc(player : any)
    while wait(0.5) do
        -- not smoothe yet
        table.insert(store, AirplaneNose.Position) -- clamp in server
        for i in pairs (store) do
            if (store[i] ~= nil) then
                AirplaneNoseRemote:FireClient(player, store[i])
            else
                return;
            end
        end
    end
end

game.Players.PlayerAdded:Connect(calc)