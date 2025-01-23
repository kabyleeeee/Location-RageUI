
if Config.VersionESX == "old" then 
    ESX = nil
    
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
elseif Config.VersionESX == "new" then 
    ESX = exports["es_extended"]:getSharedObject()
end


CreateThread(function()
    for k,v in pairs(Config.positions) do 
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, Config.blips.sprite)
        SetBlipScale(blip, Config.blips.scale)
        SetBlipColour(blip, Config.blips.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.blips.label)
        EndTextCommandSetBlipName(blip)
    end

    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.positions) do
            local distance = #(playerCoords - vector3(v.x, v.y, v.z))
            if distance < 10 then
                timer = 0
                if distance < 5 then
                    DrawMarker(27, v.x, v.y, v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 255, 0, 100, 0, 0, 0, 0)
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la location")
                    if IsControlJustPressed(0, 51) then
                        OpenMainMenuLocation()
                    end
                end
            elseif distance > 5.0 and distance < 15.0 then
                timer = 750
            end
        end
        Wait(timer)
    end
end)