---@author Razzway
---@version 1.0
ESX = nil;

TriggerEvent(_Config.getESX, function(object) ESX = object end)

---@class AC
AC = {} or {};
AC.distanceProtect = 10;

RegisterServerEvent((_Config.Prefix..'%s'):format(_Config.Events.startHarvest))
AddEventHandler(((_Config.Prefix..'%s'):format(_Config.Events.startHarvest)), function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    for _, btc in pairs(_Config.position.farm.interactionZone) do
        local pCoords, recoltPosition = GetEntityCoords(GetPlayerPed(_src)), btc.pos
        if #(pCoords - recoltPosition) <= AC.distanceProtect then
            if (not isHarvesting[_src]) then
                isHarvesting[_src] = true
                TriggerClientEvent('esx:showNotification', _src, '~y~Bitcoin~s~ \nVous commencé à miner...')
                Server:Harvest(_src)
            else
                print(('%s: %s a tenté de glitch avec le marker !'):format(_Config.Prefix, GetPlayerIdentifiers(_src)[1]))
            end
        else
            DropPlayer(_src, 'Bitcoin : Triche de récolte détectée.')
            Server:toDiscord(_ServerConfig.param.name, xPlayer.getName()..' a été expulsé pour tricherie ! (récolte)', _ServerConfig.param.colorAC)
        end
    end
end)

RegisterServerEvent((_Config.Prefix..'%s'):format(_Config.Events.stopHarvest))
AddEventHandler(((_Config.Prefix..'%s'):format(_Config.Events.stopHarvest)), function()
    local _src = source
    isHarvesting[_src] = false
end)

RegisterServerEvent((_Config.Prefix..'%s'):format(_Config.Events.sellBitcoin))
AddEventHandler(((_Config.Prefix..'%s'):format(_Config.Events.sellBitcoin)), function(count, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local btcQuantity = xPlayer.getInventoryItem('bitcoin').count

    count = tonumber(count)
    price = tonumber(price)

    for _, sell in pairs(_Config.position.sell.interactionZone) do
        local pCoords, sellPosition = GetEntityCoords(GetPlayerPed(_src)), sell.pos
        if #(pCoords - sellPosition) <= AC.distanceProtect then
            if count > btcQuantity then
                TriggerClientEvent('esx:showNotification', _src, '~r~Vous n\'avez pas autant de bitcoin à vendre.')
            else
                xPlayer.removeInventoryItem('bitcoin', count)
                xPlayer.addAccountMoney('cash', price)
                TriggerClientEvent('esx:showNotification', _src, ('~y~Bitcoin~s~ \nVous avez vendu %s ~b~bitcoin~s~'):format(count))
                TriggerClientEvent('esx:showNotification', _src, ('~g~+%s $~s~'):format(price))
                Server:toDiscord(_ServerConfig.param.name, (xPlayer.getName()..' a vendu %s bitcoin pour %s $ !'):format(count, price), _ServerConfig.param.colorSell)
            end
        else
            DropPlayer(_src, 'Bitcoin : Triche de revente détectée.')
            Server:toDiscord(_ServerConfig.param.name, xPlayer.getName()..' a été expulsé pour tricherie ! (revente)', _ServerConfig.param.colorAC)
        end
    end
end)