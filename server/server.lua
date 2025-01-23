if Config.VersionESX == "old" then 
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.VersionESX == "new" then 
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterNetEvent("Kabyle:Location:BuyVehicle", function(v)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source) 

    if not xPlayer then return print("xPlayer not found") end

    if not v.label or not v.model or not v.price then return print("ID: ".._source.." Cheating") end

    if xPlayer.getMoney() >= v.price then 
        xPlayer.removeMoney(v.price)
        xPlayer.showNotification("Vous avez loué un(e) "..v.label.." pour "..v.price.."$")
        TriggerClientEvent("Kabyle:Location:SpawnVehicle", _source, v.model)

    else
        xPlayer.showNotification("~r~Vous n'avez pas assez d'argent")
    end

end)