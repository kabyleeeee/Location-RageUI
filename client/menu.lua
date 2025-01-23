OpenMenu = false
local mainMenu = RageUI.CreateMenu("Location", "Location de véhicules")
mainMenu.Closed = function()
    OpenMenu = false
end

RegisterNetEvent("Kabyle:Location:SpawnVehicle", function(model)
    ESX.Game.SpawnVehicle(model, Config.spawnVehicle, Config.spawnHeading, function(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)
end)

OpenMainMenuLocation = function()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenu, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenu, true)


        CreateThread(function()
            while OpenMenu do
                Wait(1)

                RageUI.IsVisible(mainMenu, function()

                    for k,v in pairs(Config.vehicles) do 

                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).." $"}, true, {
                            onSelected = function()
                                TriggerServerEvent("Kabyle:Location:BuyVehicle", v)
                                RageUI.CloseAll()
                            end
                        })

                    end

                end)
            end
        end)
    end
end